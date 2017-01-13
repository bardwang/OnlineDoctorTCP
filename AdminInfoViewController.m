//
//  AdminInfoViewController.m
//  FinalProject
//
//  Created by Xun on 12/1/16.
//  Copyright © 2016 Xun. All rights reserved.
//

#import "AdminInfoViewController.h"
#import "AppDelegate.h"

@interface AdminInfoViewController ()

@end

@implementation AdminInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.admin = [AdminAccount new];
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
    self.admin.username = self.usernametf.text;
    self.admin.password = self.passwordtf.text;
    
    NSString* repassword = self.repasswordtf.text;
    NSString* access = self.accesstf.text;
    
    // to create username alert
    if([self.admin.username length] == 0){
        
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
    if([self.admin.password length] == 0){
        
        UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"Alert"
                                                                       message:@"Please type a right password"
                                                                preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault
                                                              handler:^(UIAlertAction * action) {}];
        
        [alert addAction:defaultAction];
        [self presentViewController:alert animated:YES completion:nil];
        return;
    }
    
    
    if(![self.admin.password isEqualToString:repassword]){
        
        UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"Alert"
                                                                       message:@"The passwords are not the same"
                                                                preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault
                                                              handler:^(UIAlertAction * action) {}];
        
        [alert addAction:defaultAction];
        [self presentViewController:alert animated:YES completion:nil];
        
        return;
        
    }
    
    // to create an access alert
    if(![access isEqualToString:@"admin"]){
        
        UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"Alert"
                                                                       message:@"The access code you entered is not right"
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
    NSManagedObject* adminAccountEntity = [NSEntityDescription insertNewObjectForEntityForName:@"AdminAccountEntity" inManagedObjectContext:context];
    
    [adminAccountEntity setValue:self.admin.username forKey:@"username"];
    [adminAccountEntity setValue:self.admin.password forKey:@"password"];
    
    NSManagedObject* accountEntity = [NSEntityDescription insertNewObjectForEntityForName:@"AccountEntity" inManagedObjectContext:context];
    
    [accountEntity setValue:self.admin.username forKey:@"username"];
    [accountEntity setValue:self.admin.password forKey:@"password"];
    [accountEntity setValue:@"Admin" forKey:@"type"];
    
    NSError* error;
    if(![context save:&error]){
        NSLog(@"failed to add");
    }
}


@end
