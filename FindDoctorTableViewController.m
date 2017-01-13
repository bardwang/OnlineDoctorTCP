//
//  FindDoctorTableViewController.m
//  FinalProject
//
//  Created by Xun on 12/14/16.
//  Copyright © 2016 Xun. All rights reserved.
//

#import "FindDoctorTableViewController.h"
#import "PatientChatViewController.h"
#import "AppDelegate.h"
#import "DoctorAccount.h"

@interface FindDoctorTableViewController ()

@end

@implementation FindDoctorTableViewController

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
    
    NSFetchRequest* request = [NSFetchRequest fetchRequestWithEntityName:@"DoctorAccountEntity"];
    
    NSError* error;
    NSArray* results = [context executeFetchRequest:request error:&error];
    
    for(NSManagedObject *obj in results){
        DoctorAccount* da = [DoctorAccount new];
        da.field = [obj valueForKey:@"field"];
        if([da.field isEqualToString:self.type]){
        da.name = [obj valueForKey:@"name"];
        da.image = [UIImage imageWithData: [obj valueForKey:@"image"]];
        da.detailedInfo = [obj valueForKey:@"detail"];
        [self.accounts addObject:da];
        }
    }
    
    self.accountsShow = [[NSMutableArray alloc] initWithArray:self.accounts];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

// to init the network communication
- (void)initNetworkCommunication {
    CFReadStreamRef readStream;
    CFWriteStreamRef writeStream;
    CFStreamCreatePairWithSocketToHost(NULL, (CFStringRef)@"192.168.1.167", 1234, &readStream, &writeStream);
    self.inputStream = (__bridge NSInputStream *)readStream;
    self.outputStream = (__bridge NSOutputStream *)writeStream;
    [self.inputStream setDelegate:self];
    [self.outputStream setDelegate:self];
    [self.inputStream scheduleInRunLoop:[NSRunLoop currentRunLoop] forMode:NSDefaultRunLoopMode];
    [self.outputStream scheduleInRunLoop:[NSRunLoop currentRunLoop] forMode:NSDefaultRunLoopMode];
    [self.inputStream open];
    [self.outputStream open];
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.accountsShow count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    // the identifier for the cell
    NSString* identifier = @"identifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    
    if(cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:identifier];
    }
    
    DoctorAccount* da = self.accountsShow[indexPath.row];
    cell.textLabel.text = da.name;
    cell.detailTextLabel.text = da.detailedInfo;
    cell.detailTextLabel.numberOfLines = 5;
    
    // to add an image
    cell.imageView.image = da.image;
    
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

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    [self initNetworkCommunication];
    NSString *response  = [NSString stringWithFormat:@"iam:pat-%@", self.name];
    NSData *data = [[NSData alloc] initWithData:[response dataUsingEncoding:NSASCIIStringEncoding]];
    [self.outputStream write:[data bytes] maxLength:[data length]];
    
    if([segue.identifier isEqualToString:@"chatwithdoctor"]){
        PatientChatViewController *controller = (PatientChatViewController *)segue.destinationViewController;
        controller.inputStream = self.inputStream;
        controller.outputStream = self.outputStream;
        controller.username = self.username;
    }
    [self.tableView cellForRowAtIndexPath:self.index].accessoryType = UITableViewCellAccessoryNone;
}


@end
