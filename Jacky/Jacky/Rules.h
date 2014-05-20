//
//  Rules.h
//  Jacky
//
//  Created by Romain GABEL on 19/05/2014.
//  Copyright (c) 2014 Romain GABEL. All rights reserved.
//

#import <Foundation/Foundation.h>

enum resultat{

    comWin,
    userWin,
    noWiner
    
};

@interface Rules : NSObject

+ (enum resultat) whoIsTheWinnerBetweenUser: (int) userValue AndCom : (int) comValue;
+ (BOOL) valueIsOutOfLimit: (int) value;
@end
