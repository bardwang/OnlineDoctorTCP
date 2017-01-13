//
//  Account.m
//  FinalProject
//
//  Created by Xun on 12/1/16.
//  Copyright © 2016 Xun. All rights reserved.
//

#import "Account.h"

@implementation Account

// to initialize the dealer
-(instancetype)init
{
    self = [super init];
    if (self) {
        self.username = @"";
        self.password = @"";
        self.type = @"";
    }
    return self;
}


@end
