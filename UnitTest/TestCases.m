//
//  TestCases.m
//  GeoStrass
//
//  Created by amadou diallo on 11/3/12.
//  Copyright (c) 2012 unistra. All rights reserved.
//

#import "TestCases.h"

@implementation TestCases

-(void) testString
{
    NSString* str1 = @"lol";
    NSString* str2 = @"lolo";
    GHAssertEqualStrings(str1, str2, @"test Failed");
}

-(void) testString2
{
    NSString* str1 = @"lol";
    NSString* str2 = @"lol";
    GHAssertEqualStrings(str1, str2, @"test Succeeded");
}

@end
