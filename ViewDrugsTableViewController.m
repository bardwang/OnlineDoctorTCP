//
//  ViewDrugsTableViewController.m
//  FinalProject
//
//  Created by Xun on 12/14/16.
//  Copyright © 2016 Xun. All rights reserved.
//

#import "ViewDrugsTableViewController.h"
#import "AppDelegate.h"
#import "Drug.h"
#import "DrugConfirmViewController.h"

@interface ViewDrugsTableViewController ()

@end

@implementation ViewDrugsTableViewController

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
    
    NSFetchRequest* request = [NSFetchRequest fetchRequestWithEntityName:@"DrugEntity"];
    
    NSError* error;
    NSArray* results = [context executeFetchRequest:request error:&error];
    
    for(NSManagedObject *obj in results){
        Drug* d = [Drug new];
        d.name = [obj valueForKey:@"name"];
        d.price = [obj valueForKey:@"price"];
        NSData* imageData = [obj valueForKey:@"image"];
        d.image = [UIImage imageWithData:imageData];
        [self.drugs addObject:d];
    }
    
    self.drugsShow = [[NSMutableArray alloc] initWithArray:self.drugs];
    
    [self.tableView reloadData];
}

-(void)viewDidAppear:(BOOL)animated{
    self.tabBarController.navigationItem.title = @"View Drugs";
    self.tabBarController.navigationItem.rightBarButtonItem = nil;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

// search bar
- (void) searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText{
    
    if(searchBar.text.length == 0){
        [self.drugsShow removeAllObjects];
        [self.drugsShow addObjectsFromArray:self.drugs];
    }else{
        [self.drugsShow removeAllObjects];
        for (Drug* d in self.drugs){
            NSRange r = [d.name rangeOfString:searchBar.text options:NSCaseInsensitiveSearch];
            if(r.location != NSNotFound){
                [self.drugsShow addObject:d];
            }
        }
    }
    
    [self.tableView reloadData];
}

- (void) searchBarSearchButtonClicked:(UISearchBar *) asearchBar{
    [self.searchBar resignFirstResponder];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.drugsShow count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    // the identifier for the cell
    NSString* identifier = @"identifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    
    if(cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:identifier];
    }
    
    Drug* d = self.drugsShow[indexPath.row];
    cell.textLabel.text = d.name;
    cell.detailTextLabel.text = d.price;
    cell.imageView.image = d.image;
    
    return cell;
}

// click and get details
- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    self.drug = self.drugsShow[indexPath.row];
    [self performSegueWithIdentifier:@"detail" sender:self];
    
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    if([segue.identifier isEqualToString:@"detail"]){
        DrugConfirmViewController *controller = (DrugConfirmViewController *)segue.destinationViewController;
        controller.drug = self.drug;
        controller.inputStream = self.inputStream;
        controller.outputStream = self.outputStream;
        controller.username = self.username;
    }
}

@end
