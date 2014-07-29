//
//  StudentAccount.h
//  BT
//
//  Created by LGBS dev on 7/29/14.
//  Copyright (c) 2014 LGBS. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface StudentAccount : NSObject
@property (nonatomic,retain)NSString* name;
+(StudentAccount*) newStudent : (NSString*)name;

@end
