//
//  PatientInfoViewController.h
//  FinalProject
//
//  Created by Xun on 12/1/16.
//  Copyright © 2016 Xun. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PatientAccount.h"

@interface PatientInfoViewController : UIViewController

@property (weak, nonatomic) IBOutlet UITextField *usernametf;
@property (weak, nonatomic) IBOutlet UITextField *passwordtf;
@property (weak, nonatomic) IBOutlet UITextField *repasswordtf;
@property (weak, nonatomic) IBOutlet UITextField *nametf;
@property (nonatomic, retain) PatientAccount* pa;

@end
