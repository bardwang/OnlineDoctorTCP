//
//  SelectFieldTableViewController.m
//  FinalProject
//
//  Created by Xun on 12/1/16.
//  Copyright © 2016 Xun. All rights reserved.
//

#import "SelectFieldTableViewController.h"
#import "DoctorInfo2ViewController.h"

@interface SelectFieldTableViewController ()

@end

@implementation SelectFieldTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    self.types = @[@"Allergist",@"Audiologist",@"Cardiologist",@"Dentist",@"General"];
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

// to set the field
- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    self.type = self.types[indexPath.row];
    
}

// to fit all the rows
- (NSInteger)tableView:(UITableView *)tableView indentationLevelForRowAtIndexPath:(nonnull NSIndexPath *)indexPath{
    if(indexPath.row == 1){
        return 2;
    }else{
        return 1;
    }
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    if([segue.identifier isEqualToString:@"doctorInfo2"]){
        DoctorInfo2ViewController *controller = (DoctorInfo2ViewController *)segue.destinationViewController;
        self.da.field = self.type;
        controller.da = self.da;
    }
    [self.tableView cellForRowAtIndexPath:self.index].accessoryType = UITableViewCellAccessoryNone;
}


@end
