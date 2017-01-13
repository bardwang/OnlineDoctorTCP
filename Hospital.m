//
//  Hospital.m
//  FinalProject
//
//  Created by Xun on 12/1/16.
//  Copyright © 2016 Xun. All rights reserved.
//

#import "Hospital.h"

@implementation Hospital

static Hospital *hospital = nil;    // static instance variable

// to init a hospital
- (id)init {
    if ( (self = [super init]) ) {
        self.accounts = [NSMutableArray new];
    }
    return self;
}

// use singleton method to get the hospital
+ (Hospital *) getHospital {
    if (hospital == nil) {
        hospital = [[super allocWithZone:NULL] init];
    }
    return hospital;
}

@end
