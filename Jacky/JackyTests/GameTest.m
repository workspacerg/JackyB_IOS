//
//  GameTest.m
//  Jacky
//
//  Created by Romain GABEL on 20/05/2014.
//  Copyright (c) 2014 Romain GABEL. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "UIGameVC.h"
#import "Carte.h"
#import "Rules.h"

@interface GameTest : XCTestCase


@property (nonatomic) UIGameVC * game ;



@end

@implementation GameTest

- (void)setUp
{
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
    _game = [[UIGameVC alloc] init];
    [_game viewDidLoad];
    
}

- (void)tearDown
{
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}


- (void)test1Win
{
    // user = 20
    [_game.userPlayer addCard:[[Carte alloc] initWithColor:coeur Number:[NSNumber numberWithInt:5] Value:[NSNumber numberWithInt:5]]];
    [_game.userPlayer addCard:[[Carte alloc] initWithColor:coeur Number:[NSNumber numberWithInt:10] Value:[NSNumber numberWithInt:10]]];
    [_game.userPlayer addCard:[[Carte alloc] initWithColor:coeur Number:[NSNumber numberWithInt:5] Value:[NSNumber numberWithInt:5]]];
    
    // com = 27
    [_game.comPlayer addCard:[[Carte alloc] initWithColor:coeur Number:[NSNumber numberWithInt:10] Value:[NSNumber numberWithInt:10]]];
    [_game.comPlayer addCard:[[Carte alloc] initWithColor:coeur Number:[NSNumber numberWithInt:7] Value:[NSNumber numberWithInt:7]]];
    [_game.comPlayer addCard:[[Carte alloc] initWithColor:coeur Number:[NSNumber numberWithInt:10] Value:[NSNumber numberWithInt:10]]];
    
    
    enum resultat * result = [Rules whoIsTheWinnerBetweenUser:[_game.userPlayer getValueOfCards] AndCom:[_game.comPlayer getValueOfCards]];

    NSLog(@"---------------------------------------------");
//    NSLog(@"user valueOfCard : %d",[_game.userPlayer getValueOfCards]);
//    NSLog(@"com valueOfCard : %d",[_game.comPlayer getValueOfCards]);
//    NSLog(@"result : %d", (int) result);
//    NSLog(@"userWin : %d", (int) userWin);
    NSLog(@"---------------------------------------------");
    
    
    
    XCTAssertTrue((int)result == userWin, @"User don't win");
}

- (void)test1Loose
{
    // user = 20
    [_game.userPlayer addCard:[[Carte alloc] initWithColor:coeur Number:[NSNumber numberWithInt:5] Value:[NSNumber numberWithInt:5]]];
    [_game.userPlayer addCard:[[Carte alloc] initWithColor:coeur Number:[NSNumber numberWithInt:10] Value:[NSNumber numberWithInt:10]]];
    [_game.userPlayer addCard:[[Carte alloc] initWithColor:coeur Number:[NSNumber numberWithInt:3] Value:[NSNumber numberWithInt:3]]];
    
    // com = 27
    [_game.comPlayer addCard:[[Carte alloc] initWithColor:coeur Number:[NSNumber numberWithInt:9] Value:[NSNumber numberWithInt:9]]];
    [_game.comPlayer addCard:[[Carte alloc] initWithColor:coeur Number:[NSNumber numberWithInt:10] Value:[NSNumber numberWithInt:10]]];
    
    
    enum resultat * result = [Rules whoIsTheWinnerBetweenUser:[_game.userPlayer getValueOfCards] AndCom:[_game.comPlayer getValueOfCards]];
    
    NSLog(@"---------------------------------------------");
    //    NSLog(@"user valueOfCard : %d",[_game.userPlayer getValueOfCards]);
    //    NSLog(@"com valueOfCard : %d",[_game.comPlayer getValueOfCards]);
    //    NSLog(@"result : %d", (int) result);
    //    NSLog(@"userWin : %d", (int) userWin);
    NSLog(@"---------------------------------------------");
    
    
    
    XCTAssertTrue((int)result == comWin, @"User don't win");
}

- (void)test1NoWinner
{
    // user = 20
    [_game.userPlayer addCard:[[Carte alloc] initWithColor:coeur Number:[NSNumber numberWithInt:5] Value:[NSNumber numberWithInt:5]]];
    [_game.userPlayer addCard:[[Carte alloc] initWithColor:coeur Number:[NSNumber numberWithInt:10] Value:[NSNumber numberWithInt:10]]];
    [_game.userPlayer addCard:[[Carte alloc] initWithColor:coeur Number:[NSNumber numberWithInt:3] Value:[NSNumber numberWithInt:3]]];
        [_game.userPlayer addCard:[[Carte alloc] initWithColor:coeur Number:[NSNumber numberWithInt:1] Value:[NSNumber numberWithInt:1]]];
    
    // com = 27
    [_game.comPlayer addCard:[[Carte alloc] initWithColor:coeur Number:[NSNumber numberWithInt:9] Value:[NSNumber numberWithInt:9]]];
    [_game.comPlayer addCard:[[Carte alloc] initWithColor:coeur Number:[NSNumber numberWithInt:10] Value:[NSNumber numberWithInt:10]]];
    
    
    enum resultat * result = [Rules whoIsTheWinnerBetweenUser:[_game.userPlayer getValueOfCards] AndCom:[_game.comPlayer getValueOfCards]];
    
    NSLog(@"---------------------------------------------");
    //    NSLog(@"user valueOfCard : %d",[_game.userPlayer getValueOfCards]);
    //    NSLog(@"com valueOfCard : %d",[_game.comPlayer getValueOfCards]);
    //    NSLog(@"result : %d", (int) result);
    //    NSLog(@"userWin : %d", (int) userWin);
    NSLog(@"---------------------------------------------");
    
    
    
    XCTAssertTrue((int)result == noWiner, @"User don't win");
}

@end
