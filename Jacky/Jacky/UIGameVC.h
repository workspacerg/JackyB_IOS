//
//  UIGameVC.h
//  Jacky
//
//  Created by Romain GABEL on 19/05/2014.
//  Copyright (c) 2014 Romain GABEL. All rights reserved.
//

#import <UIKit/UIKit.h>
#include "Player.h"
#include "Rules.h"



@interface UIGameVC : UIViewController

@property (nonatomic) Player * userPlayer;
@property (nonatomic) Player * comPlayer;


@property (weak, nonatomic) IBOutlet UILabel *displayWinner;
@property (weak, nonatomic) IBOutlet UIButton *getCardButton;
@property (weak, nonatomic) IBOutlet UILabel *MoneyValue;
@property (weak, nonatomic) IBOutlet UILabel *scoreUser;
@property (weak, nonatomic) IBOutlet UILabel *scoreCom;
@property (weak, nonatomic) IBOutlet UITextField *miseTF;
@property (weak, nonatomic) IBOutlet UILabel *currentMise;
@property (weak, nonatomic) IBOutlet UIButton *miseButton;
@property (weak, nonatomic) IBOutlet UIButton *endGameButton;
@property (nonatomic) enum resultat * resultGame;
@property (weak, nonatomic) IBOutlet UIButton *doubleButton;


@property (weak, nonatomic) IBOutlet UILabel *userCartesLabel;
@property (weak, nonatomic) IBOutlet UILabel *comCartesLabel;



- (IBAction)Miser:(id)sender ;
- (IBAction)endGameButton:(id)sender;
- (void) updateScore;

@end
