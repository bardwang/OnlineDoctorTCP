//
//  Hospital.h
//  FinalProject
//
//  Created by Xun on 12/1/16.
//  Copyright © 2016 Xun. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Hospital : NSObject

@property NSMutableArray* accounts;
+ (Hospital*) getHospital;

@end
