//
//  testPlayer.m
//  Jacky
//
//  Created by Romain GABEL on 19/05/2014.
//  Copyright (c) 2014 Romain GABEL. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "Player.h"

@interface testPlayer : XCTestCase

@property (nonatomic) Player * monJoueur ;
@property (nonatomic) Player * computer ;

@end

@implementation testPlayer

- (void)setUp
{
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
    
    _monJoueur = [[Player alloc] initWithName:@"Romain"];
    _computer = [[Player alloc] initCom];
    
}

- (void)tearDown
{
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testIfObjectUserExiste
{
    XCTAssertNotNil(_monJoueur);
    
    NSString * tested = [_monJoueur name];
    NSString * test = @"Romain";
    XCTAssertTrue([test isEqualToString:tested]);
    
}

- (void)testIfObjectComExiste
{
    XCTAssertNotNil(_computer);
    
    NSString * tested = [_computer name];
    NSString * test = @"Com";
    XCTAssertTrue([test isEqualToString:tested]);
    
}




@end
