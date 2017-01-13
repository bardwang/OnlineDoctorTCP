//
//  DoctorInfo2ViewController.h
//  FinalProject
//
//  Created by Xun on 12/2/16.
//  Copyright © 2016 Xun. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DoctorAccount.h"

@interface DoctorInfo2ViewController : UIViewController <UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextViewDelegate>

@property (weak, nonatomic) IBOutlet UITextField *nametf;
@property (weak, nonatomic) IBOutlet UIImageView *image;
@property (weak, nonatomic) IBOutlet UITextView *detailtf;
@property (weak, nonatomic) IBOutlet UIButton *pickBtn;

@property DoctorAccount* da;
@property CGRect keyboardFrameBeginRect;

- (IBAction)pickPhoto:(id)sender;

@end
