//
//  testCarte.m
//  Jacky
//
//  Created by Romain GABEL on 19/05/2014.
//  Copyright (c) 2014 Romain GABEL. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "Carte.h"

@interface testCarte : XCTestCase

@property (nonatomic) Carte * carte;

@end

@implementation testCarte

- (void)setUp
{
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
    
    //_carte = [[Carte alloc] initWithColor:coeur Number:@"dame" Value: [NSNumber numberWithInt:11]];
    _carte = [[Carte alloc] init];

}

- (void)tearDown
{
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testIsNotNull
{
    XCTAssertNotNil(_carte);
}

- (void) testDescription
{
    NSString * tested = [_carte description];
    NSString * test = @"dame de 0 avec valeur = 11";    
    
    XCTAssertFalse([test isEqualToString:tested]);
}

@end
