//
//  ViewDrugsTableViewController.h
//  FinalProject
//
//  Created by Xun on 12/14/16.
//  Copyright © 2016 Xun. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Drug.h"

@interface ViewDrugsTableViewController : UITableViewController

@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;
@property NSMutableArray* drugs;
@property NSMutableArray* drugsShow;
@property Drug* drug;

@property NSInputStream *inputStream;
@property NSOutputStream *outputStream;
@property NSString* username;

@end
