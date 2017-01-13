//
//  AdminTableViewController.m
//  FinalProject
//
//  Created by Xun on 12/3/16.
//  Copyright © 2016 Xun. All rights reserved.
//

#import "AdminTableViewController.h"
#import "AppDelegate.h"
#import "Account.h"

@interface AdminTableViewController ()

@end

@implementation AdminTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    self.accounts = [NSMutableArray new];
    
    // Core Data
    AppDelegate* appDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    NSManagedObjectContext* context = appDelegate.persistentContainer.viewContext;
    
    NSFetchRequest* request = [NSFetchRequest fetchRequestWithEntityName:@"AccountEntity"];
    
    NSError* error;
    NSArray* results = [context executeFetchRequest:request error:&error];
    
    for(NSManagedObject *obj in results){
        Account* a = [Account new];
        a.username = [obj valueForKey:@"username"];
        a.type = [obj valueForKey:@"type"];
        [self.accounts addObject:a];        
    }
    
    self.accountsShow = [[NSMutableArray alloc] initWithArray:self.accounts];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

// search bar
- (void) searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText{
    
    if(searchBar.text.length == 0){
        [self.accountsShow removeAllObjects];
        [self.accountsShow addObjectsFromArray:self.accounts];
    }else{
        [self.accountsShow removeAllObjects];
        for (Account* a in self.accounts){
            NSRange r = [a.username rangeOfString:searchBar.text options:NSCaseInsensitiveSearch];
            if(r.location != NSNotFound){
                [self.accountsShow addObject:a];
            }
        }
    }
    
    [self.tableView reloadData];
}

- (void) searchBarSearchButtonClicked:(UISearchBar *) asearchBar{
    [self.searchBar resignFirstResponder];
}

#pragma mark - Table view data source

/*
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
#warning Incomplete implementation, return the number of sections
    return 0;
}
*/

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.accountsShow count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    // the identifier for the cell
    NSString* identifier = @"identifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    
    if(cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:identifier];
    }
    
    Account* a = self.accountsShow[indexPath.row];
    cell.textLabel.text = a.username;
    cell.detailTextLabel.text = a.type;
    
    return cell;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
