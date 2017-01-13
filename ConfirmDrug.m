//
//  ConfirmDrug.m
//  FinalProject
//
//  Created by Xun on 12/16/16.
//  Copyright © 2016 Xun. All rights reserved.
//

#import "ConfirmDrug.h"

@implementation ConfirmDrug

// init
- (instancetype)init
{
    self = [super init];
    if (self) {
        self.quantity = @"0";
        self.drugdescription = @"";
        self.date = nil;
        self.doctor = @"";
    }
    return self;
}

@end
