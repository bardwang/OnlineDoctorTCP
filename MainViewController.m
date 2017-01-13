//
//  ViewController.m
//  FinalProject
//
//  Created by Xun on 11/30/16.
//  Copyright © 2016 Xun. All rights reserved.
//

#import "MainViewController.h"
#import "AppDelegate.h"
#import "Account.h"
#import "DoctorViewController.h"
#import "PatientViewController.h"

@interface MainViewController ()

@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.hospital = [Hospital getHospital];
    [[self navigationController] setNavigationBarHidden:NO animated:YES];
    // to hide the back button
    self.navigationItem.hidesBackButton = YES;
    
}

- (void)viewDidAppear:(BOOL)animated{
    
        // Core Data
        AppDelegate* appDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
        NSManagedObjectContext* context = appDelegate.persistentContainer.viewContext;
        
        NSFetchRequest* request = [NSFetchRequest fetchRequestWithEntityName:@"AccountEntity"];
        
        NSError* error;
        NSArray* results = [context executeFetchRequest:request error:&error];
        
        for(NSManagedObject *obj in results){
            Account* a = [Account new];
            a.username = [obj valueForKey:@"username"];
            a.password = [obj valueForKey:@"password"];
            a.type = [obj valueForKey:@"type"];
            if(![self.hospital.accounts containsObject:a]){
            [self.hospital.accounts addObject:a];
            }
        }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

// to login
- (IBAction)login:(id)sender {
    
    NSString* username = self.usernametf.text;
    NSString* password = self.passwordtf.text;
    
    for(Account* a in self.hospital.accounts){
        if([username isEqualToString:a.username] && [password isEqualToString:a.password]){
            self.username = a.username;
            self.password = a.password;
            self.type = a.type;
            break;
        }
    }
    
    if([self.type isEqualToString:@"Doctor"]){
        [self performSegueWithIdentifier:@"doctorLogin" sender:self];
    }else if([self.type isEqualToString:@"Patient"]){
        [self performSegueWithIdentifier:@"patientLogin" sender:self];
    }else if([self.type isEqualToString:@"Admin"]){
        [self performSegueWithIdentifier:@"adminLogin" sender:self];
    }else{
        UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"Alert"
                                                                       message:@"The account you entered does not exist"
                                                                preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault
                                                              handler:^(UIAlertAction * action) {}];
        
        [alert addAction:defaultAction];
        [self presentViewController:alert animated:YES completion:nil];
        
        return;
    }
}

#pragma mark - Navigation
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
     if([segue.identifier isEqualToString:@"doctorLogin"]){
         DoctorViewController *controller = (DoctorViewController *)segue.destinationViewController;
         controller.username = self.username;
     }else if([segue.identifier isEqualToString:@"patientLogin"]){
         PatientViewController *controller = (PatientViewController *)segue.destinationViewController;
         controller.username = self.username;
     }
 }

@end
