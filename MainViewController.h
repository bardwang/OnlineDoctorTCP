//
//  ViewController.h
//  FinalProject
//
//  Created by Xun on 11/30/16.
//  Copyright © 2016 Xun. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Hospital.h"

@interface MainViewController : UIViewController

@property Hospital* hospital;
@property (weak, nonatomic) IBOutlet UITextField *usernametf;
@property (weak, nonatomic) IBOutlet UITextField *passwordtf;

@property NSString* username;
@property NSString* password;
@property NSString* type;

- (IBAction)login:(id)sender;

@end

