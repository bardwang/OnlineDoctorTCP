//
//  DrugConfirmViewController.m
//  FinalProject
//
//  Created by Xun on 12/16/16.
//  Copyright © 2016 Xun. All rights reserved.
//

#import "DrugConfirmViewController.h"
#import "ConfirmDrug.h"
#import "DoctorChatViewController.h"
#import "AppDelegate.h"

@interface DrugConfirmViewController ()

@end

@implementation DrugConfirmViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = self.drug.name;
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

- (IBAction)confirm:(id)sender {
    
    NSString* quantity = self.quantity.text;
    NSString* description = self.descriptiontf.text;
    
    // to create quantity alert
    if([quantity rangeOfCharacterFromSet:[[NSCharacterSet decimalDigitCharacterSet] invertedSet]].location != NSNotFound){
        
        UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"Alert"
                                                                       message:@"Please type a right quantity"
                                                                preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault
                                                              handler:^(UIAlertAction * action) {}];
        
        [alert addAction:defaultAction];
        [self presentViewController:alert animated:YES completion:nil];
        
        return;
    }
    
    // to create drug name alert
    if([description length] == 0){
        
        UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"Alert"
                                                                       message:@"Please type a description"
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
    NSManagedObject* drugCartEntity = [NSEntityDescription insertNewObjectForEntityForName:@"DrugCartEntity" inManagedObjectContext:context];
    
    [drugCartEntity setValue:self.username forKey:@"username"];
    [drugCartEntity setValue:self.drug.name forKey:@"name"];
    [drugCartEntity setValue:self.drug.price forKey:@"price"];
    NSData *imageData = UIImagePNGRepresentation(self.drug.image);
    [drugCartEntity setValue:imageData forKey:@"image"];
    [drugCartEntity setValue:quantity forKey:@"quantity"];
    [drugCartEntity setValue:description forKey:@"drugdescription"];
    
    NSError* error;
    if(![context save:&error]){
        NSLog(@"failed to add");
    }
    
    self.confirmBtn.enabled = false;
    self.quantity.enabled = false;
    self.descriptiontf.editable = NO;
    
    UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"Alert"
                                                                   message:@"You have added the drug successfully"
                                                            preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault
                                                          handler:^(UIAlertAction * action) {}];
    
    [alert addAction:defaultAction];
    [self presentViewController:alert animated:YES completion:nil];
    
}
@end
