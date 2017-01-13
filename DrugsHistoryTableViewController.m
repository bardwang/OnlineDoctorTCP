//
//  DrugsHistoryTableViewController.m
//  FinalProject
//
//  Created by Xun on 12/14/16.
//  Copyright © 2016 Xun. All rights reserved.
//

#import "DrugsHistoryTableViewController.h"
#import "ConfirmDrug.h"
#import "DrugDetailViewController.h"
#import "AppDelegate.h"

@interface DrugsHistoryTableViewController ()

@end

@implementation DrugsHistoryTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    self.drugs = [NSMutableArray new];
    
    // Core Data
    AppDelegate* appDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    NSManagedObjectContext* context = appDelegate.persistentContainer.viewContext;
    
    // to get the confirm drugs
    NSFetchRequest* request = [NSFetchRequest fetchRequestWithEntityName:@"DrugConfirmEntity"];
    
    NSError* error;
    NSArray* results = [context executeFetchRequest:request error:&error];
    
    for(NSManagedObject *obj in results){
        if([self.username isEqualToString:[obj valueForKey:@"username"]]){
            ConfirmDrug* d = [ConfirmDrug new];
            d.name = [obj valueForKey:@"name"];
            d.quantity = [obj valueForKey:@"quantity"];
            d.drugdescription = [obj valueForKey:@"drugdescription"];
            d.date = [obj valueForKey:@"date"];
            d.doctor = [obj valueForKey:@"doctor"];
            [self.drugs addObject:d];
        }
    }
    
    // to get the drugs list
    NSFetchRequest* request2 = [NSFetchRequest fetchRequestWithEntityName:@"DrugEntity"];
    
    NSError* error2;
    NSArray* results2 = [context executeFetchRequest:request2 error:&error2];
    
    for(ConfirmDrug* d in self.drugs){
        for(NSManagedObject *obj in results2){
            if([d.name isEqualToString:[obj valueForKey:@"name"]]){
                d.price = [obj valueForKey:@"price"];
                d.image = [UIImage imageWithData: [obj valueForKey:@"image"]];
                break;
            }
        }
    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.drugs count];
}

// click and get details
- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    self.drug = self.drugs[indexPath.row];
    [self performSegueWithIdentifier:@"detail" sender:self];
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    // the identifier for the cell
    NSString* identifier = @"identifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    
    if(cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:identifier];
    }
    
    ConfirmDrug* d = self.drugs[indexPath.row];
    NSMutableString* s = [NSMutableString new];
    [s appendString:@"date:"];
    NSDateFormatter *outputFormatter = [[NSDateFormatter alloc] init];
    [outputFormatter setDateFormat:@"yyyy-MM-dd hh:mm:ss"];
    NSString *newDateString = [outputFormatter stringFromDate:d.date];
    [s appendString:newDateString];
    [s appendString:@"\nquantity:"];
    [s appendString:d.quantity];
    cell.textLabel.text = d.name;
    cell.detailTextLabel.text = s;
    cell.detailTextLabel.numberOfLines = 5;
    cell.imageView.image = d.image;
    
    return cell;
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    if([segue.identifier isEqualToString:@"detail"]){
        DrugDetailViewController *controller = (DrugDetailViewController *)segue.destinationViewController;
        controller.drug = self.drug;
    }
}

@end
