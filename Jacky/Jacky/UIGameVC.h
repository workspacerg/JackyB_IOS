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

#pragma mark Property Player
@property (nonatomic) Player * userPlayer;
@property (nonatomic) Player * comPlayer;

#pragma mark Property Money
@property (weak, nonatomic) IBOutlet UILabel *MoneyValue;
@property (weak, nonatomic) IBOutlet UITextField *miseTF;
@property (weak, nonatomic) IBOutlet UIButton *miseButton;

#pragma mark Property Game Button
@property (weak, nonatomic) IBOutlet UIButton *getCardButton;
@property (weak, nonatomic) IBOutlet UIButton *doubleButton;
@property (weak, nonatomic) IBOutlet UIButton *endGameButton;
@property (weak, nonatomic) IBOutlet UIButton *splitButton;

#pragma mark Property Affichage
@property (nonatomic) enum resultat * resultGame;
@property (weak, nonatomic) IBOutlet UILabel *displayWinner;
@property (weak, nonatomic) IBOutlet UILabel *scoreUser;
@property (weak, nonatomic) IBOutlet UILabel *scoreCom;
@property (weak, nonatomic) IBOutlet UIView *carteView;
@property (weak, nonatomic) IBOutlet UIView *carteViewCom;
@property (nonatomic)  NSMutableArray * carteCom;
@property (nonatomic)  NSMutableArray * cartePlayer;

#pragma mark Property DEBUG
@property (weak, nonatomic) IBOutlet UILabel *userCartesLabel;
@property (weak, nonatomic) IBOutlet UILabel *comCartesLabel;

#pragma mark Instance Méthode
- (IBAction)Miser:(id)sender ;
- (IBAction)endGameButton:(id)sender;
- (void) updateScore;

@end
