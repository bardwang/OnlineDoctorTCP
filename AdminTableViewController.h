//
//  AdminTableViewController.h
//  FinalProject
//
//  Created by Xun on 12/3/16.
//  Copyright © 2016 Xun. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AdminTableViewController : UITableViewController

@property NSMutableArray* accounts;
@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;

@property NSMutableArray* accountsShow;

@end
