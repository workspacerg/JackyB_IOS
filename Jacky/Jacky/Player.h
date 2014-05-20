//
//  Player.h
//  Jacky
//
//  Created by Romain GABEL on 19/05/2014.
//  Copyright (c) 2014 Romain GABEL. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Carte.h"
#import "Rules.h"

enum TypePlayer {

    userType,
    comType

};


@interface Player : NSObject

@property (nonatomic) NSString * name;
@property (nonatomic) NSNumber * money;
@property (nonatomic) NSNumber * joker;
@property (nonatomic) enum TypePlayer * type;
@property (nonatomic) NSMutableArray * cartes;


- (id)initWithName: (NSString *) name_;
- (id)initCom;
- (NSString *)description;

- (void) addCard: (Carte * ) Card;
- (int) getValueOfCards;


@end
