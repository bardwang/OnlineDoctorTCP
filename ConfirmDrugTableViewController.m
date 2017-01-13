//
//  RecommandDrugTableViewController.m
//  FinalProject
//
//  Created by Xun on 12/14/16.
//  Copyright © 2016 Xun. All rights reserved.
//

#import "ConfirmDrugTableViewController.h"
#import "AppDelegate.h"
#import "ConfirmDrug.h"

@interface ConfirmDrugTableViewController ()

@end

@implementation ConfirmDrugTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
}

-(void)viewDidAppear:(BOOL)animated{
    self.tabBarController.navigationItem.title = @"Confirm Drugs";
    UIBarButtonItem *SendButton = [[UIBarButtonItem alloc]
                                   initWithTitle:@"Send"
                                   style:UIBarButtonItemStylePlain
                                   target:self
                                   action:@selector(sendInfo:)];
    self.tabBarController.navigationItem.rightBarButtonItem = SendButton;
    
    self.drugs = [NSMutableArray new];
    AppDelegate* appDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    NSManagedObjectContext* context = appDelegate.persistentContainer.viewContext;
    
    NSFetchRequest* request = [NSFetchRequest fetchRequestWithEntityName:@"DrugCartEntity"];
    
    NSError* error;
    NSArray* results = [context executeFetchRequest:request error:&error];
    
    // Core Data
    for(NSManagedObject *obj in results){
        ConfirmDrug* d = [ConfirmDrug new];
        NSString* username = [obj valueForKey:@"username"];
        if([self.username isEqualToString:username]){
            d.name = [obj valueForKey:@"name"];
            d.price = [obj valueForKey:@"price"];
            NSData* imageData = [obj valueForKey:@"image"];
            d.image = [UIImage imageWithData:imageData];
            d.quantity = [obj valueForKey:@"quantity"];
            d.drugdescription = [obj valueForKey:@"drugdescription"];
            [self.drugs addObject:d];
        }
    }
    [self.tableView reloadData];
    [self initNetworkCommunication];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.drugs count];
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

// to press the back button
- (void)viewDidDisappear:(BOOL)animated
{
    [self.inputStream close];
    [self.outputStream close];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    // the identifier for the cell
    NSString* identifier = @"identifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    
    if(cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:identifier];
    }
    
    ConfirmDrug* d = self.drugs[indexPath.row];
    NSString* q = @"quantity:";
    cell.textLabel.text = d.name;
    cell.detailTextLabel.text = [q stringByAppendingString:d.quantity];
    cell.imageView.image = d.image;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // get the cell
        ConfirmDrug* d = self.drugs[indexPath.row];
        
        [self.drugs removeObjectAtIndex:indexPath.row];
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
        
        // Core Data
        AppDelegate* appDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
        NSManagedObjectContext* context = appDelegate.persistentContainer.viewContext;
        NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
        [fetchRequest setEntity:[NSEntityDescription entityForName:@"DrugCartEntity" inManagedObjectContext:context]];
        [fetchRequest setPredicate:[NSPredicate predicateWithFormat:@"name == %@", d.name]];
        [fetchRequest setPredicate:[NSPredicate predicateWithFormat:@"quantity == %@", d.quantity]];
        
        NSError* error = nil;
        
        NSArray* results = [context executeFetchRequest:fetchRequest error:&error];
        [context deleteObject:results[0]];
        [context save:&error];
        
    }
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)sendInfo:(id)sender{
    
    if([self.drugs count] == 0){
        UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"Alert"
                                                                       message:@"No drugs to send"
                                                                preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault
                                                              handler:^(UIAlertAction * action) {}];
        
        [alert addAction:defaultAction];
        [self presentViewController:alert animated:YES completion:nil];
        return;
    }
    
    NSMutableString* response = [NSMutableString new];
    [response appendString:@"add:info"];
    for(ConfirmDrug* d in self.drugs){
        [response appendString:d.name];
        [response appendString:@"_"];
        [response appendString:d.quantity];
        [response appendString:@"_"];
        [response appendString:d.drugdescription];
        [response appendString:@"_"];
        [response appendString:self.name];
        [response appendString:@"|"];
    }
    
    // Core Data
    AppDelegate* appDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    NSManagedObjectContext* context = appDelegate.persistentContainer.viewContext;
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] initWithEntityName:@"DrugCartEntity"];
    [fetchRequest setIncludesPropertyValues:NO]; //only fetch the managedObjectID
    
    NSError *error;
    NSArray *fetchedObjects = [context executeFetchRequest:fetchRequest error:&error];
    for (NSManagedObject *object in fetchedObjects)
    {
        
        [context deleteObject:object];
    }
    
    error = nil;
    [context save:&error];
    
    NSData *data = [[NSData alloc] initWithData:[[response substringToIndex:[response length] - 1] dataUsingEncoding:NSASCIIStringEncoding]];
    [self.outputStream write:[data bytes] maxLength:[data length]];
    
    UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"Congrats"
                                                                   message:@"You have sent the information successfully"
                                                            preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault
                                                          handler:^(UIAlertAction * action) {}];
    
    [alert addAction:defaultAction];
    [self presentViewController:alert animated:YES completion:nil];
    
    [self viewDidAppear:true];

}
@end
