//
//  DoctorAccount.m
//  FinalProject
//
//  Created by Xun on 12/1/16.
//  Copyright © 2016 Xun. All rights reserved.
//

#import "DoctorAccount.h"

@implementation DoctorAccount

// init
- (instancetype)init
{
    self = [super init];
    if (self) {
        self.name = @"";
        self.image = nil;
        self.detailedInfo = @"";
        self.field = @"";
    }
    return self;
}

@end
