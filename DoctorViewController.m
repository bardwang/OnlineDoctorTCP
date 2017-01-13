//
//  DoctorViewController.m
//  FinalProject
//
//  Created by Xun on 12/14/16.
//  Copyright © 2016 Xun. All rights reserved.
//

#import "DoctorViewController.h"
#import "DoctorChatViewController.h"
#import "ViewDrugsTableViewController.h"
#import "ConfirmDrugTableViewController.h"
#import "AppDelegate.h"

@interface DoctorViewController ()

@end

@implementation DoctorViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.hidesBackButton = YES;
    // Core Data
    AppDelegate* appDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    NSManagedObjectContext* context = appDelegate.persistentContainer.viewContext;
    
    NSFetchRequest* request = [NSFetchRequest fetchRequestWithEntityName:@"DoctorAccountEntity"];
    
    NSError* error;
    NSArray* results = [context executeFetchRequest:request error:&error];
    
    for(NSManagedObject *obj in results){
        NSString* username = [obj valueForKey:@"username"];
        if([username isEqualToString:self.username]){
            self.name = [obj valueForKey:@"name"];
            break;
        }
    }
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
        
    if([segue.identifier isEqualToString:@"chatwithpatient"]){
        DoctorChatViewController *controller1 = [[(UITabBarController *)segue.destinationViewController viewControllers] objectAtIndex:0];
        controller1.inputStream = self.inputStream;
        controller1.outputStream = self.outputStream;
        controller1.name = self.name;
        ViewDrugsTableViewController* controller2 = [[(UITabBarController *)segue.destinationViewController viewControllers] objectAtIndex:1];
        controller2.inputStream = self.inputStream;
        controller2.outputStream = self.outputStream;
        controller2.username = self.username;
        ConfirmDrugTableViewController* controller3 = [[(UITabBarController *)segue.destinationViewController viewControllers] objectAtIndex:2];
        controller3.inputStream = self.inputStream;
        controller3.outputStream = self.outputStream;
        controller3.username = self.username;
        controller3.name = self.name;
    }
}

@end
