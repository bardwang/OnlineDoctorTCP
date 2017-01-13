//
//  DoctorViewController.h
//  FinalProject
//
//  Created by Xun on 12/14/16.
//  Copyright © 2016 Xun. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DoctorViewController : UIViewController <NSStreamDelegate>

@property NSString* username;
@property NSString* name;

@property NSInputStream *inputStream;
@property NSOutputStream *outputStream;


@end
