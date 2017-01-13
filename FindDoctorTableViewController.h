//
//  FindDoctorTableViewController.h
//  FinalProject
//
//  Created by Xun on 12/14/16.
//  Copyright © 2016 Xun. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DoctorAccount.h"

@interface FindDoctorTableViewController : UITableViewController <NSStreamDelegate>

@property NSInputStream *inputStream;
@property NSOutputStream *outputStream;

@property NSString* type;
@property (nonatomic, retain) NSIndexPath* index;
@property NSString* name;
@property NSString* username;

@property NSMutableArray* accounts;
@property NSMutableArray* accountsShow;

@end
