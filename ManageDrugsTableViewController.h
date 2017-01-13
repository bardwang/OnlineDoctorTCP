//
//  ManageDrugsTableViewController.h
//  FinalProject
//
//  Created by Xun on 12/4/16.
//  Copyright © 2016 Xun. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ManageDrugsTableViewController : UITableViewController

@property NSMutableArray* drugs;
@property NSMutableArray* drugsShow;
@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;

@end
