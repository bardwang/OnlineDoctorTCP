//
//  DrugConfirmViewController.h
//  FinalProject
//
//  Created by Xun on 12/16/16.
//  Copyright © 2016 Xun. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Drug.h"

@interface DrugConfirmViewController : UIViewController

@property (weak, nonatomic) IBOutlet UITextField *quantity;
@property (weak, nonatomic) IBOutlet UITextView *descriptiontf;
@property (weak, nonatomic) IBOutlet UIButton *confirmBtn;


@property Drug* drug;

@property NSInputStream *inputStream;
@property NSOutputStream *outputStream;
@property NSString* username;

- (IBAction)confirm:(id)sender;


@end
