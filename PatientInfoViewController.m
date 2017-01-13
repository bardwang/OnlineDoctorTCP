//
//  PatientInfoViewController.m
//  FinalProject
//
//  Created by Xun on 12/1/16.
//  Copyright © 2016 Xun. All rights reserved.
//

#import "PatientInfoViewController.h"
#import "PatientAccount.h"
#import "AppDelegate.h"

@interface PatientInfoViewController ()

@end

@implementation PatientInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.pa = [PatientAccount new];
    
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
    self.pa.username = self.usernametf.text;
    self.pa.password = self.passwordtf.text;
    self.pa.name = self.nametf.text;
    
    NSString* repassword = self.repasswordtf.text;
    
    // to create username alert
    if([self.pa.username length] == 0){
        
        UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"Alert"
                                                                       message:@"Please type a right username"
                                                                preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault
                                                              handler:^(UIAlertAction * action) {}];
        
        [alert addAction:defaultAction];
        [self presentViewController:alert animated:YES completion:nil];
        return;
    }
    
    // to create password alert
    if([self.pa.password length] == 0){
        
        UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"Alert"
                                                                       message:@"Please type a right password"
                                                                preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault
                                                              handler:^(UIAlertAction * action) {}];
        
        [alert addAction:defaultAction];
        [self presentViewController:alert animated:YES completion:nil];
        return;
    }
    
    
    if(![self.pa.password isEqualToString:repassword]){
        
        UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"Alert"
                                                                       message:@"The passwords are not the same"
                                                                preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault
                                                              handler:^(UIAlertAction * action) {}];
        
        [alert addAction:defaultAction];
        [self presentViewController:alert animated:YES completion:nil];
        
        return;
        
    }
    
    // to create name alert
    if([self.pa.name length] == 0){
        
        UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"Alert"
                                                                       message:@"Please type a right name"
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
    NSManagedObject* patientAccountEntity = [NSEntityDescription insertNewObjectForEntityForName:@"PatientAccountEntity" inManagedObjectContext:context];
    
    [patientAccountEntity setValue:self.pa.username forKey:@"username"];
    [patientAccountEntity setValue:self.pa.password forKey:@"password"];
    [patientAccountEntity setValue:self.pa.name forKey:@"name"];
    
    NSManagedObject* accountEntity = [NSEntityDescription insertNewObjectForEntityForName:@"AccountEntity" inManagedObjectContext:context];
    
    [accountEntity setValue:self.pa.username forKey:@"username"];
    [accountEntity setValue:self.pa.password forKey:@"password"];
    [accountEntity setValue:@"Patient" forKey:@"type"];
    
    NSError* error;
    if(![context save:&error]){
        NSLog(@"failed to add");
    }
}

@end
