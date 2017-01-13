//
//  RegisterTypeTableViewController.h
//  FinalProject
//
//  Created by Xun on 11/30/16.
//  Copyright © 2016 Xun. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RegisterTypeTableViewController : UITableViewController

@property (nonatomic, retain) NSArray* types;
@property (nonatomic, retain) NSString* type;
@property (nonatomic, retain) NSIndexPath* index;
- (IBAction)clickNext:(id)sender;

@end
