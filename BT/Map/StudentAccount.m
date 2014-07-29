//
//  StudentAccount.m
//  BT
//
//  Created by LGBS dev on 7/29/14.
//  Copyright (c) 2014 LGBS. All rights reserved.
//

#import "StudentAccount.h"

@implementation StudentAccount
+(StudentAccount*) newStudent : (NSString*)name
{
    StudentAccount* student=[[StudentAccount alloc]init];
    if (student) {
        student.name=name;
    }
    return student;
}
@end
