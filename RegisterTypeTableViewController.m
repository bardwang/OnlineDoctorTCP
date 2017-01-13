//
//  RegisterTypeTableViewController.m
//  FinalProject
//
//  Created by Xun on 11/30/16.
//  Copyright © 2016 Xun. All rights reserved.
//

#import "RegisterTypeTableViewController.h"

@interface RegisterTypeTableViewController ()

@end

@implementation RegisterTypeTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    self.types = @[@"Doctor",@"Patient",@"Admin"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

/*
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
#warning Incomplete implementation, return the number of sections
    return 0;
}
*/

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.types count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    // the identifier for the cell
    NSString* identifier = @"identifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    
    if(cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    
    cell.textLabel.text = self.types[indexPath.row];
    
    // to add an image
    NSString* imageName = [NSString stringWithFormat:@"%@.jpeg", self.types[indexPath.row]];
    UIImage* image = [UIImage imageNamed:imageName];
    cell.imageView.image = image;
    
    return cell;
}

// to add to checkmark for the table cell
-(NSIndexPath *)tableView:(UITableView *)tableView willSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSIndexPath *oldIndex = [tableView indexPathForSelectedRow];
    [tableView cellForRowAtIndexPath:oldIndex].accessoryType = UITableViewCellAccessoryNone;
    [tableView cellForRowAtIndexPath:indexPath].accessoryType = UITableViewCellAccessoryCheckmark;
    self.index = indexPath;
    return indexPath;
}

// to set the role
- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    self.type = self.types[indexPath.row];
    
}

// to fit all the rows
- (NSInteger)tableView:(UITableView *)tableView indentationLevelForRowAtIndexPath:(nonnull NSIndexPath *)indexPath{
    if(indexPath.row == 0){
        return 6;
    }else{
        return 1;
    }
}

- (IBAction)clickNext:(id)sender {
    // to clean all the check marks
    [self.tableView cellForRowAtIndexPath:self.index].accessoryType = UITableViewCellAccessoryNone;
    if([self.type isEqualToString:@"Doctor"]){
        [self performSegueWithIdentifier:@"doctor" sender:self];
    }else if([self.type isEqualToString:@"Patient"]){
        [self performSegueWithIdentifier:@"patient" sender:self];
    }else if([self.type isEqualToString:@"Admin"]){
        [self performSegueWithIdentifier:@"admin" sender:self];
    }else{
        UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"Alert"
                                                                       message:@"Please select a role"
                                                                preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault
                                                              handler:^(UIAlertAction * action) {}];
        
        [alert addAction:defaultAction];
        [self presentViewController:alert animated:YES completion:nil];
        
        return;
    }
}


#pragma mark - Navigation
/*
// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    if([segue.identifier isEqualToString:@"doctor"]){
        ListVehiclesViewController *controller = (ListVehiclesViewController *)segue.destinationViewController;
        controller.salesDepartment = self.salesDepartment;
        controller.vehicles = self.salesDepartment.vehicles;
    }
}
*/


@end
