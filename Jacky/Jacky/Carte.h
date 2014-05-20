//
//  Carte.h
//  Jacky
//
//  Created by Romain GABEL on 19/05/2014.
//  Copyright (c) 2014 Romain GABEL. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <stdlib.h>


enum symboleCarte{
    
    coeur,
    carreau,
    trefle,
    pique
    
};

@interface Carte : NSObject

@property (nonatomic) enum symboleCarte * color ;
@property (nonatomic) NSNumber * number ;
@property (nonatomic) NSNumber * valueCard ;

- (id)init;
- (id)initWithColor: (enum symboleCarte *) color_ Number : (NSNumber *) number_ Value : (NSNumber *) value ;

- (NSString *)description;




@end
