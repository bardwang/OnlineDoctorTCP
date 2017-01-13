//
//  RecommandDrugTableViewController.h
//  FinalProject
//
//  Created by Xun on 12/14/16.
//  Copyright © 2016 Xun. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ConfirmDrugTableViewController : UITableViewController <NSStreamDelegate>

@property NSInputStream *inputStream;
@property NSOutputStream *outputStream;

@property NSMutableArray* drugs;
@property NSString* username;
@property NSString* name;

@end
