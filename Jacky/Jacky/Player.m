//
//  Player.m
//  Jacky
//
//  Created by Romain GABEL on 19/05/2014.
//  Copyright (c) 2014 Romain GABEL. All rights reserved.
//

#import "Player.h"
#import "Rules.h"


@implementation Player


- (id)initWithName:(NSString *)name_
{
    self = [super init];
    
    if (self) {
        _type = userType;
        _name = name_;
        _money = [NSNumber numberWithInt:400];
        _joker = 0;
        _cartes = [[NSMutableArray alloc] init];
    }
    return self;
}

- (id)initCom
{
    
    self = [super init];
    
    if (self)
    {
        _type = (enum TypePlayer *) comType;
        _name = @"Com";
        _money = [NSNumber numberWithInt:0];
        _joker = 0;
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
    NSLog(@"%@ > %@",_name, [Card description]);
    if ([[Card number] intValue] == 1) {
        
        _joker++;
    }
    [_cartes addObject:Card];
}

- (int) getValueOfCards
{
    
    int result = 0;    
    for (int i = 0 ; i < [_cartes count]; i++) {
        result += [[[_cartes objectAtIndex:i] valueCard] intValue];
    }
    
    if ([Rules valueIsOutOfLimit:result]) {
        
        if (_joker > 0 ) {
            [self useJoker];
        }
    }
    
    result -= (10*_jokerUse);
    
    return result;
}

- (void) cleanGame
{

    [_cartes removeAllObjects];
    _jokerUse = 0 ;
    _joker = 0 ;

}

- (void)useJoker
{
    
    _jokerUse++;
    _joker--;

}

@end
