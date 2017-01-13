//
//  PatientChatViewController.h
//  FinalProject
//
//  Created by Xun on 12/14/16.
//  Copyright © 2016 Xun. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PatientChatViewController : UIViewController <NSStreamDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate>

@property NSInputStream *inputStream;
@property NSOutputStream *outputStream;

@property NSMutableArray* messages;
@property int isimage;
@property int issend;
@property NSMutableData* completeImageData;
@property NSUInteger dataLength;
@property int position;
@property NSString* username;

@property (weak, nonatomic) IBOutlet UIScrollView *chatBox;
@property (weak, nonatomic) IBOutlet UITextField *messageBox;
@property (weak, nonatomic) IBOutlet UIButton *imageBtn;

- (IBAction)send:(id)sender;
- (IBAction)sendImage:(id)sender;

@end
