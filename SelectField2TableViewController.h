//
//  SelectField2TableViewController.h
//  FinalProject
//
//  Created by Xun on 12/14/16.
//  Copyright © 2016 Xun. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DoctorAccount.h"

@interface SelectField2TableViewController : UITableViewController

@property (nonatomic, retain) NSArray* types;
@property (nonatomic, retain) NSString* type;
@property (nonatomic, retain) NSIndexPath* index;
@property NSString* name;
@property NSString* username;

@end
