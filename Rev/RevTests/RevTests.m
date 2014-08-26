//
//  RevTests.m
//  RevTests
//
//  Created by Eric Williams on 8/7/14.
//  Copyright (c) 2014 Eric Williams. All rights reserved.
//

#import <XCTest/XCTest.h>

@interface RevTests : XCTestCase

@end

@implementation RevTests

- (void)setUp
{
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown
{
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testForLoops
{
    //Fast Enumeration
    for (int i=0; i < 5; i++) {
        sum = sum + 1;
    }
    NSLog(<#NSString *format, ...#>)
}

@end
