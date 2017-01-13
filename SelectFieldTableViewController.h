//
//  SelectFieldTableViewController.h
//  FinalProject
//
//  Created by Xun on 12/1/16.
//  Copyright © 2016 Xun. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DoctorAccount.h"

@interface SelectFieldTableViewController : UITableViewController

@property (nonatomic, retain) NSArray* types;
@property (nonatomic, retain) NSString* type;
@property (nonatomic, retain) NSIndexPath* index;

@property DoctorAccount* da;

@end
