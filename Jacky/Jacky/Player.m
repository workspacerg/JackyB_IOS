//
//  Player.m
//  Jacky
//
//  Created by Romain GABEL on 19/05/2014.
//  Copyright (c) 2014 Romain GABEL. All rights reserved.
//

#import "Player.h"


@implementation Player


- (id)initWithName:(NSString *)name_
{
    self = [super init];
    
    if (self) {
        _type = userType;
        _name = name_;
        _money = [NSNumber numberWithInt:400];
        _joker = [NSNumber numberWithInt:0];
        _cartes = [[NSMutableArray alloc] init];
    }
    return self;
}

- (id)initCom
{
    
    self = [super init];
    
    if (self)
    {
        _type = comType;
        _name = @"Com";
        _money = [NSNumber numberWithInt:0];
        _joker = [NSNumber numberWithInt:0];
        _cartes = [[NSMutableArray alloc] init];
    }
    return self;
}

- (NSString *)description
{
    return [NSString stringWithFormat:@"%@",_name];
}

- (void) addCard: (Carte *) Card
{
    [_cartes addObject:Card];
}

- (int) getValueOfCards
{
    int result = 0;    
    for (int i = 0 ; i < [_cartes count]; i++) {
        result += [[[_cartes objectAtIndex:i] valueCard] intValue];
    }
    
    return result;
}

@end
