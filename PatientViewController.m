//
//  PatientViewController.m
//  FinalProject
//
//  Created by Xun on 12/14/16.
//  Copyright © 2016 Xun. All rights reserved.
//

#import "PatientViewController.h"
#import "SelectField2TableViewController.h"
#import "DrugsHistoryTableViewController.h"
#import "AppDelegate.h"
#import "PatientAccount.h"

@interface PatientViewController ()

@end

@implementation PatientViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.hidesBackButton = YES;
    
    // Core Data
    AppDelegate* appDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    NSManagedObjectContext* context = appDelegate.persistentContainer.viewContext;
    
    NSFetchRequest* request = [NSFetchRequest fetchRequestWithEntityName:@"PatientAccountEntity"];
    
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
    if([segue.identifier isEqualToString:@"selectfield"]){
        SelectField2TableViewController *controller = (SelectField2TableViewController *)segue.destinationViewController;
        controller.name = self.name;
        controller.username = self.username;
    }else if([segue.identifier isEqualToString:@"drughistory"]){
        DrugsHistoryTableViewController *controller = (DrugsHistoryTableViewController *)segue.destinationViewController;
        controller.username = self.username;
    }
}

@end
