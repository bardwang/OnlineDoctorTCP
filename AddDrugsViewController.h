//
//  AddDrugsViewController.h
//  FinalProject
//
//  Created by Xun on 12/4/16.
//  Copyright © 2016 Xun. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AddDrugsViewController : UIViewController <UIImagePickerControllerDelegate, UINavigationControllerDelegate>

@property (weak, nonatomic) IBOutlet UITextField *drugNametf;
@property (weak, nonatomic) IBOutlet UITextField *drugPricetf;
@property (weak, nonatomic) IBOutlet UIButton *pickBtn;
- (IBAction)pickPhoto:(id)sender;
@property (weak, nonatomic) IBOutlet UIImageView *image;
- (IBAction)complete:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *completeBtn;

@end
