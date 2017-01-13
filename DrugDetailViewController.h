//
//  DrugDetailViewController.h
//  FinalProject
//
//  Created by Xun on 12/17/16.
//  Copyright © 2016 Xun. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ConfirmDrug.h"

@interface DrugDetailViewController : UIViewController

@property ConfirmDrug* drug;

@property (weak, nonatomic) IBOutlet UIImageView *drugImage;
@property (weak, nonatomic) IBOutlet UITextField *drugName;
@property (weak, nonatomic) IBOutlet UITextField *drugDate;
@property (weak, nonatomic) IBOutlet UITextField *drugQuantity;
@property (weak, nonatomic) IBOutlet UITextField *drugPrice;
@property (weak, nonatomic) IBOutlet UITextField *drugDoctor;
@property (weak, nonatomic) IBOutlet UITextView *drugDescription;

@end
