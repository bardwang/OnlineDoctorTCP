//
//  DoctorInfoViewController.h
//  FinalProject
//
//  Created by Xun on 12/1/16.
//  Copyright © 2016 Xun. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DoctorAccount.h"

@interface DoctorInfoViewController : UIViewController

@property (weak, nonatomic) IBOutlet UITextField *usernametf;
@property (weak, nonatomic) IBOutlet UITextField *passwordtf;
@property (weak, nonatomic) IBOutlet UITextField *repasswordtf;
@property (weak, nonatomic) IBOutlet UITextField *accesstf;

@property DoctorAccount* da;

@end
