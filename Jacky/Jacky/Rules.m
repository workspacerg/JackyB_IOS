//
//  Rules.m
//  Jacky
//
//  Created by Romain GABEL on 19/05/2014.
//  Copyright (c) 2014 Romain GABEL. All rights reserved.
//

#import "Rules.h"

@implementation Rules

+ (enum resultat) whoIsTheWinnerBetweenUser:(int)userValue AndCom:(int)comValue{

    
    if (userValue > 21) {
        return comWin;
    }
    else if (comValue > 21)
        return userWin;
    
    
    if (userValue == comValue)
        return noWiner ;
    else if (userValue > comValue)
        return userWin;
    else
        return comWin;

}

+ (BOOL)valueIsOutOfLimit: (int) value
{

    if(value > 21)
        return true;
    else
        return false;

}

@end
