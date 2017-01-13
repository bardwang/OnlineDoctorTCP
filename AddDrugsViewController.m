//
//  AddDrugsViewController.m
//  FinalProject
//
//  Created by Xun on 12/4/16.
//  Copyright © 2016 Xun. All rights reserved.
//

#import "AddDrugsViewController.h"
#import "AppDelegate.h"

@interface AddDrugsViewController ()

@end

@implementation AddDrugsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

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
    
}

- (IBAction)complete:(id)sender {
    
    NSString* drugName = self.drugNametf.text;
    NSString* drugPrice = self.drugPricetf.text;
    
    // to create drug name alert
    if([drugName length] == 0){
        
        UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"Alert"
                                                                       message:@"Please type a drug name"
                                                                preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault
                                                              handler:^(UIAlertAction * action) {}];
        
        [alert addAction:defaultAction];
        [self presentViewController:alert animated:YES completion:nil];
        return;
    }
    
    // to create drug price alert
    if([drugPrice length] == 0){
        
        UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"Alert"
                                                                       message:@"Please type a drug price"
                                                                preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault
                                                              handler:^(UIAlertAction * action) {}];
        
        [alert addAction:defaultAction];
        [self presentViewController:alert animated:YES completion:nil];
        return;
    }
    
    // to create drug image alert
    if(self.image == nil){
        UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"Alert"
                                                                       message:@"Please select an image of the drug"
                                                                preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault
                                                              handler:^(UIAlertAction * action) {}];
        
        [alert addAction:defaultAction];
        [self presentViewController:alert animated:YES completion:nil];
        return;
    }
    
    // to add a dollar sign
    drugPrice = [drugPrice stringByAppendingString:@"$"];
    
    // Core Data
    AppDelegate* appDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    NSManagedObjectContext* context = appDelegate.persistentContainer.viewContext;
    NSManagedObject* drugEntity = [NSEntityDescription insertNewObjectForEntityForName:@"DrugEntity" inManagedObjectContext:context];
    
    [drugEntity setValue:drugName forKey:@"name"];
    [drugEntity setValue:drugPrice forKey:@"price"];
    NSData *imageData = UIImagePNGRepresentation(self.image.image);
    [drugEntity setValue:imageData forKey:@"image"];
    
    NSError* error;
    if(![context save:&error]){
        NSLog(@"failed to add");
    }
    
    self.drugNametf.enabled = false;
    self.drugPricetf.enabled = false;
    self.pickBtn.enabled = false;
    self.completeBtn.enabled = false;
    
    UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"Success"
                                                                   message:@"You have added the drug successfully"
                                                            preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault
                                                          handler:^(UIAlertAction * action) {}];
    
    [alert addAction:defaultAction];
    [self presentViewController:alert animated:YES completion:nil];
    
}
@end
