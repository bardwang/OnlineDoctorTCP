//
//  PatientChatViewController.m
//  FinalProject
//
//  Created by Xun on 12/14/16.
//  Copyright © 2016 Xun. All rights reserved.
//

#import "PatientChatViewController.h"
#import "AppDelegate.h"

@interface PatientChatViewController ()

@end

@implementation PatientChatViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.messages = [[NSMutableArray alloc] init];
    [self.inputStream setDelegate:self];
    [self.outputStream setDelegate:self];
    // the position for the message
    self.position = 10;
    // to check if it is a sent image
    self.isimage = 0;
    self.issend = 1;
    self.completeImageData = [NSMutableData new];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                                          action:@selector(dismissKeyboard)];
    [self.view addGestureRecognizer:tap];
    
}

- (void)viewDidAppear:(BOOL)animated{
    NSString *response  = @"total:";
    NSData *data = [[NSData alloc] initWithData:[response dataUsingEncoding:NSASCIIStringEncoding]];
    [self.outputStream write:[data bytes] maxLength:[data length]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

// stream events
- (void)stream:(NSStream *)theStream handleEvent:(NSStreamEvent)streamEvent {
    
    switch (streamEvent) {
            
        case NSStreamEventOpenCompleted:
            NSLog(@"Stream opened");
            break;
            
        case NSStreamEventHasBytesAvailable:
            
            if (theStream == self.inputStream) {
                
                uint8_t buffer[1024];
                memset( buffer, '\0', sizeof(buffer));
                NSInteger len;
                
                while ([self.inputStream hasBytesAvailable]) {
                    len = [self.inputStream read:buffer maxLength:sizeof(buffer)];
                    if (len > 0) {
                        
                        // to get the data from buffer
                        NSData* data = [[NSData alloc] initWithBytes:buffer length:len];
                        NSData* typedata = [data subdataWithRange:NSMakeRange(0, 4)];
                        NSData* restdata = [data subdataWithRange:NSMakeRange(4, data.length - 4)];
                        NSData* frontdata = [restdata subdataWithRange:NSMakeRange(0, 4)];
                        NSString* type = [[NSString alloc] initWithData:typedata encoding:NSUTF8StringEncoding];
                        NSString* fronttype = [[NSString alloc] initWithData:frontdata encoding:NSUTF8StringEncoding];
                        NSString* reststring = [[NSString alloc] initWithData:restdata encoding:NSUTF8StringEncoding];
                        NSData* imagedata = data;
                        
                        // to check if it is a text or an image
                        if([type isEqualToString:@"text"]){
                            self.isimage = 0;
                        }else if([type isEqualToString:@"imag"]){
                            int index = 0;
                            for(int i = 0; i < sizeof(buffer); i++){
                                // to find the position for :
                                if(buffer[i] == ':'){
                                    index = i;
                                    break;
                                }
                            }
                            NSData* numberData = [restdata subdataWithRange:NSMakeRange(0, index - 4)];
                            self.dataLength = [[[NSString alloc] initWithData:numberData encoding:NSUTF8StringEncoding] integerValue];
                            imagedata = [data subdataWithRange:NSMakeRange(index + 1, data.length - index - 1)];
                            self.isimage = 1;
                        }
                        
                        // to send the text message
                        if(self.isimage == 0){
                            if([fronttype isEqualToString:@"info"]){
                                // Core Data
                                AppDelegate* appDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
                                NSManagedObjectContext* context = appDelegate.persistentContainer.viewContext;
                                NSManagedObject* drugEntity = [NSEntityDescription insertNewObjectForEntityForName:@"DrugConfirmEntity" inManagedObjectContext:context];

                                NSArray* array = [[reststring substringFromIndex:4] componentsSeparatedByString:@"|"];
                                for(NSString* s in array){
                                    NSArray* infos = [s componentsSeparatedByString:@"_"];
                                    [drugEntity setValue:infos[0] forKey:@"name"];
                                    [drugEntity setValue:infos[1] forKey:@"quantity"];
                                    [drugEntity setValue:infos[2] forKey:@"drugdescription"];
                                    [drugEntity setValue:infos[3] forKey:@"doctor"];
                                    [drugEntity setValue:self.username forKey:@"username"];
                                    [drugEntity setValue:[NSDate date] forKey:@"date"];
                                    
                                    NSError* error;
                                    if(![context save:&error]){
                                        NSLog(@"failed to add");
                                    }
                                }
                                [self showAlert];
                            }else if (nil != reststring) {
                                NSLog(@"server said: %@", [reststring substringFromIndex:4]);
                                NSString* textMessage = [reststring substringFromIndex:4];
                                [self messageReceived:textMessage];
                            }
                        }else{
                            // to append the image data
                            if (nil != imagedata) {
                                [self.completeImageData appendData:imagedata];
                            }
                        }
                    }
                }
                // to check if the image data is complete
                if(self.isimage == 1 && self.dataLength == self.completeImageData.length){
                    UIImage* image = [[UIImage alloc]initWithData:self.completeImageData];
                    [self imageReceived:image];
                    self.completeImageData = [NSMutableData new];
                    self.isimage = 0;
                }
            }
            break;
            
        case NSStreamEventErrorOccurred:
            NSLog(@"Can not connect to the host!");
            break;
            
        case NSStreamEventEndEncountered:
            break;
            
        default:
            NSLog(@"Unknown event");
    }
    
}

// to show alert
- (void) showAlert {
    UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"Complete"
                                                                   message:@"The doctor has sent you the drugs list. Please check your drugs history. Thanks!"
                                                            preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault
                                                          handler:^(UIAlertAction * action) {}];
    
    [alert addAction:defaultAction];
    [self presentViewController:alert animated:YES completion:nil];
}

// to receive text messages
- (void) messageReceived:(NSString *)message {
    
    [self.messageBox setText:@""];
    
    UIFont *myFont = [UIFont systemFontOfSize:15];
    NSDictionary *attributes = @{NSFontAttributeName: myFont};
    CGSize myStringSize = [message sizeWithAttributes:attributes];
    
    CGRect someRect = CGRectMake(5.0, self.position, myStringSize.width + 10, 30.0);
    UITextField* text = [[UITextField alloc] initWithFrame:someRect];
    text.enabled = false;
    
    // to change background color for doctor or patient
    if(self.issend == 1){
        text.backgroundColor = [UIColor greenColor];
    }else{
        text.backgroundColor = [UIColor whiteColor];
    }
    text.layer.cornerRadius = 5;
    text.font = [UIFont systemFontOfSize:15];
    message = [@" " stringByAppendingString:message];
    [text setText:message];
    [self.chatBox addSubview:text];
    self.chatBox.contentSize = CGSizeMake(343, self.position + 40);
    self.position = self.position + 40;
    // to move the offset down
    if(self.position > 200){
        CGPoint bottomOffset = CGPointMake(0, self.chatBox.contentSize.height - self.chatBox.bounds.size.height);
        [self.chatBox setContentOffset:bottomOffset animated:YES];
    }
    self.issend = 0;
}

// to receive the image
- (void) imageReceived:(UIImage *)image {
    
    UIImageView* imageView = [[UIImageView alloc] initWithImage:image];
    CGFloat h = image.size.height;
    CGFloat ratio = h / 150;
    imageView.frame = CGRectMake(5.0, self.position, image.size.width / ratio, 150);
    [self.chatBox addSubview:imageView];
    self.chatBox.contentSize = CGSizeMake(343, self.position + 160);
    self.position = self.position + 160;
    // to move the offset down
    if(self.position > 200){
        CGPoint bottomOffset = CGPointMake(0, self.chatBox.contentSize.height - self.chatBox.bounds.size.height);
        [self.chatBox setContentOffset:bottomOffset animated:YES];
    }
}

-(void)dismissKeyboard {
    [self.messageBox resignFirstResponder];
}

// to press the back button
- (void)didMoveToParentViewController:(UIViewController *)parent
{
    if (![parent isEqual:self.parentViewController]) {
        [self.inputStream close];
        [self.outputStream close];
    }
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

// to send the text message
- (IBAction)send:(id)sender {
    NSString *response  = [NSString stringWithFormat:@"msg:%@", self.messageBox.text];
    NSData *data = [[NSData alloc] initWithData:[response dataUsingEncoding:NSASCIIStringEncoding]];
    [self.outputStream write:[data bytes] maxLength:[data length]];
    
    self.issend = 1;
}

// to send the image
- (IBAction)sendImage:(id)sender {
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.delegate = self;
    if((UIButton *) sender == self.imageBtn){
        picker.sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
    }else{
        picker.sourceType = UIImagePickerControllerSourceTypeCamera;
    }
    [self presentViewController:picker animated:YES completion:nil];
}

// to set and show the image
- (void) imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info{
    
    [[picker presentingViewController] dismissViewControllerAnimated:YES completion:nil];
    
    UIImage* originalImage = nil;
    originalImage = [info objectForKey:UIImagePickerControllerEditedImage];
    if(originalImage==nil)
    {
        originalImage = [info objectForKey:UIImagePickerControllerOriginalImage];
    }
    if(originalImage==nil)
    {
        originalImage = [info objectForKey:UIImagePickerControllerCropRect];
    }
    
    // to transfer image to image data
    NSData* imgData = UIImageJPEGRepresentation(originalImage, 1);
    // to append the tag and image length to the image data
    NSString* imgLength = [@"imag" stringByAppendingString:[NSString stringWithFormat: @"%ld", (long)imgData.length]];
    // to seperate image data with the tag and the image length by symbol ":"
    NSString *requestString = [imgLength stringByAppendingString:@":"];
    NSData * stringData = [requestString dataUsingEncoding:NSUTF8StringEncoding];
    
    self.dataLength = imgData.length;
    NSMutableData *completeData = [[NSMutableData alloc] initWithBytes:[stringData bytes] length:[stringData length]];
    [completeData appendData:imgData];
    /*
     //sending NSData over to server
     [self.outputStream write:[imgData bytes] maxLength:[imgData length]];
     */
    
    // to send the image data
    // send more than one times if outputStream is not big enough
    NSInteger bytesWritten = 0;
    while ( completeData.length > bytesWritten )
    {
        while ( ! self.outputStream.hasSpaceAvailable )
            [NSThread sleepForTimeInterval:0.05];
        
        //sending NSData over to server
        NSInteger writeResult = [self.outputStream write:[completeData bytes] + bytesWritten maxLength:[completeData length] - bytesWritten];
        if ( writeResult == -1 ) {
            NSLog(@"error code here");
        }
        else {
            bytesWritten += writeResult;
        }
    }
}

@end
