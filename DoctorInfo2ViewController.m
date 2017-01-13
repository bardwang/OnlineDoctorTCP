//
//  DoctorInfo2ViewController.m
//  FinalProject
//
//  Created by Xun on 12/2/16.
//  Copyright © 2016 Xun. All rights reserved.
//

#import "DoctorInfo2ViewController.h"
#import "AppDelegate.h"

@interface DoctorInfo2ViewController ()

@end

@implementation DoctorInfo2ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillChange:) name:UIKeyboardWillChangeFrameNotification object:nil];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                                          action:@selector(dismissKeyboard)];
    [self.view addGestureRecognizer:tap];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    self.da.detailedInfo = self.detailtf.text;
    self.da.name = self.nametf.text;
    
    // to create name alert
    if([self.da.name length] == 0){
        
        UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"Alert"
                                                                       message:@"Please type a name"
                                                                preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault
                                                              handler:^(UIAlertAction * action) {}];
        
        [alert addAction:defaultAction];
        [self presentViewController:alert animated:YES completion:nil];
        return;
    }
    
    // to create an image alert
    if(self.da.image == nil){
        UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"Alert"
                                                                       message:@"Please select an image of you"
                                                                preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault
                                                              handler:^(UIAlertAction * action) {}];
        
        [alert addAction:defaultAction];
        [self presentViewController:alert animated:YES completion:nil];
        return;
    }
    
    // to create detail info alert
    if([self.da.detailedInfo length] == 0){
        
        UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"Alert"
                                                                       message:@"Please type the detailed information"
                                                                preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault
                                                              handler:^(UIAlertAction * action) {}];
        
        [alert addAction:defaultAction];
        [self presentViewController:alert animated:YES completion:nil];
        return;
    }  
    
    // Core Data
    AppDelegate* appDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    NSManagedObjectContext* context = appDelegate.persistentContainer.viewContext;
    NSManagedObject* patientAccountEntity = [NSEntityDescription insertNewObjectForEntityForName:@"DoctorAccountEntity" inManagedObjectContext:context];
    
    [patientAccountEntity setValue:self.da.username forKey:@"username"];
    [patientAccountEntity setValue:self.da.password forKey:@"password"];
    [patientAccountEntity setValue:self.da.name forKey:@"name"];
    NSData *imageData = UIImagePNGRepresentation(self.da.image);
    [patientAccountEntity setValue:imageData forKey:@"image"];
    [patientAccountEntity setValue:self.da.detailedInfo forKey:@"detail"];
    [patientAccountEntity setValue:self.da.field forKey:@"field"];
    
    NSManagedObject* accountEntity = [NSEntityDescription insertNewObjectForEntityForName:@"AccountEntity" inManagedObjectContext:context];
    
    [accountEntity setValue:self.da.username forKey:@"username"];
    [accountEntity setValue:self.da.password forKey:@"password"];
    [accountEntity setValue:@"Doctor" forKey:@"type"];
    
    NSError* error;
    if(![context save:&error]){
        NSLog(@"failed to add");
    }
    
}

// to resign detail text view
-(void)dismissKeyboard {
    [self.detailtf resignFirstResponder];
}

// text view begin editing
- (void)textViewDidBeginEditing:(UITextView *)textView
{
    [self animateTextView:textView up:YES];
}

// text view end editing
- (void)textViewDidEndEditing:(UITextView *)textView
{
    [self animateTextView:textView up:NO];
}

// to move up and down for keyboard
- (void) animateTextView: (UITextView*) textView up: (BOOL) up
{
    int animatedDistance = self.keyboardFrameBeginRect.size.height - 20;

    if(animatedDistance > 0)
    {
        const int movementDistance = animatedDistance;
        const float movementDuration = 0.3f;
        int movement = (up ? -movementDistance : movementDistance);
        [UIView beginAnimations: nil context: nil];
        [UIView setAnimationBeginsFromCurrentState: YES];
        [UIView setAnimationDuration: movementDuration];
        self.view.frame = CGRectOffset(self.view.frame, 0, movement);
        [UIView commitAnimations];
    }
}

// to check the keyboard size
- (void)keyboardWillChange:(NSNotification *)notification {
    NSDictionary* keyboardInfo = [notification userInfo];
    NSValue* keyboardFrameBegin = [keyboardInfo valueForKey:UIKeyboardFrameBeginUserInfoKey];
    self.keyboardFrameBeginRect = [keyboardFrameBegin CGRectValue];
}

// to pick a photo
- (IBAction)pickPhoto:(id)sender {
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.delegate = self;
    if((UIButton *) sender == self.pickBtn){
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
    
    // to show the image
    self.image.image = originalImage;
    
    // to set the vehicle image
    self.da.image = originalImage;
}

@end
