//
//  Carte.m
//  Jacky
//
//  Created by Romain GABEL on 19/05/2014.
//  Copyright (c) 2014 Romain GABEL. All rights reserved.
//

#import "Carte.h"

@implementation Carte

-(id)init{

    self = [super init];
    
    if (self) {

        
        _number = [NSNumber numberWithInt: arc4random_uniform(12) + 1] ;
        _color = (enum symboleCarte) arc4random_uniform(3);
        
        switch ([_number intValue]) {
            case 1:
                _valueCard = [NSNumber numberWithInt:11];
                break;
            case 2:
                _valueCard = [NSNumber numberWithInt:2];
                break;
            case 3:
                _valueCard = [NSNumber numberWithInt:3];
                break;
            case 4:
                _valueCard = [NSNumber numberWithInt:4];
                break;
            case 5:
                _valueCard = [NSNumber numberWithInt:5];
                break;
            case 6:
                _valueCard = [NSNumber numberWithInt:6];
                break;
            case 7:
                _valueCard = [NSNumber numberWithInt:7];
                break;
            case 8:
                _valueCard = [NSNumber numberWithInt:8];
                break;
            case 9:
                _valueCard = [NSNumber numberWithInt:9];
                break;
            case 10:
                _valueCard = [NSNumber numberWithInt:10];
                break;
            case 11:
                _valueCard = [NSNumber numberWithInt:10];
                break;
            case 12:
                _valueCard = [NSNumber numberWithInt:10];
                break;
            case 13:
                _valueCard = [NSNumber numberWithInt:10];
                break;
            default:
                break;
        }
        
        
    }
    
    return self;

}

- (id)initWithColor:(enum symboleCarte *)color_ Number:(NSNumber *)number_ Value:(NSNumber *)value_
{

    self = [super init];

    if (self) {
        
        _color = color_;
        _number = number_;
        _valueCard = value_ ;
        
    }
    
    return self;


}

- (NSString *)description
{

    
    return [NSString stringWithFormat:@"%@ de %d avec valeur = %@", _number, _color , _valueCard];

}

@end
