//
//  DrugsHistoryTableViewController.h
//  FinalProject
//
//  Created by Xun on 12/14/16.
//  Copyright © 2016 Xun. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ConfirmDrug.h"

@interface DrugsHistoryTableViewController : UITableViewController

@property NSMutableArray* drugs;
@property NSString* username;

@property ConfirmDrug* drug;

@end
