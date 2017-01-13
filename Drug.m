//
//  Drug.m
//  FinalProject
//
//  Created by Xun on 12/4/16.
//  Copyright © 2016 Xun. All rights reserved.
//

#import "Drug.h"

@implementation Drug

// init
- (instancetype)init
{
    self = [super init];
    if (self) {
        self.name = @"";
        self.price = @"";
        self.image = nil;
    }
    return self;
}

@end
