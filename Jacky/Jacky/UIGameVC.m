//
//  UIGameVC.m
//  Jacky
//
//  Created by Romain GABEL on 19/05/2014.
//  Copyright (c) 2014 Romain GABEL. All rights reserved.
//

#import "UIGameVC.h"

enum sign{
    
    ajouter,
    enlever
    
};

@interface UIGameVC ()


@end

@implementation UIGameVC

#pragma mark Lauch View
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void) didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    _cartePlayer = [[NSMutableArray alloc] init];
    _carteCom = [[NSMutableArray alloc] init];
    _carteSplit = [[NSMutableArray alloc] init];
    
    //self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"wall.jpg"]];
    
    _userPlayer = [[Player alloc] initWithName:@"Romain"];
    _comPlayer  = [[Player alloc] initCom];
    _MoneyValue.text = [NSString stringWithFormat:@"%d", [_userPlayer money]];
    
    [_getCardButton setEnabled:false];
    [_endGameButton setEnabled:false];
    [_doubleButton setEnabled:false];
    
    _splitButton.hidden = YES;
    _miseTF.text = @"20";
   
    
}

#pragma mark Money
- (IBAction)Miser:(id)sender {

    
    
    if ([_miseTF.text intValue] > [_MoneyValue.text intValue] || [_miseTF.text intValue] == 0) {
        
        _displayWinner.text = @"You can't... ! ";
        
    }
    else
    {
        id button = sender;
        [button setEnabled:false];
        [_miseTF setEnabled:false];
        
        _scoreUser.text = @"0";
        _scoreCom.text  = @"0";
        
        [_carteCom removeAllObjects];
        [_cartePlayer removeAllObjects];
        [_carteSplit removeAllObjects];
        
        for(UIView *subview in [_carteView subviews]) {
            [subview removeFromSuperview];
        }
        for(UIView *subview in [_carteViewCom subviews]) {
            [subview removeFromSuperview];
        }
        
        [_userPlayer cleanGame];
        [_comPlayer cleanGame];
        
        [_getCardButton setEnabled:true];
        [_endGameButton setEnabled:true];
        [_doubleButton setEnabled:true];
        
        _displayWinner.hidden = YES;
        _splitButton.hidden = YES;
        
        _splitMode = NO;
        
        
        [self updateCurrency:[_miseTF.text intValue] AndSign:enlever];
        
        [self intitialiseGame];

        
    }
    
}

- (void) updateCurrency: (int) current AndSign:(enum signe *) sign
{
    int tmp = [_MoneyValue.text intValue];
    
    if (sign == ajouter) {
       
        tmp += current ;
    }
    else{
        tmp -= current ;
    }
    _MoneyValue.text = [NSString stringWithFormat:@"%d", tmp];
    NSLog(@"upd current");
    _userPlayer.money = tmp;

}

- (IBAction)doubleMise:(id)sender {
    int tmp = [_miseTF.text intValue];
    
    if (tmp > [_MoneyValue.text intValue]) {
        
        _displayWinner.text = @"Fond insufisant";
        _displayWinner.hidden = NO;
        
        return ;
    }
    
    [self updateCurrency:tmp AndSign:(enum sign*) enlever];
    
    tmp *= 2 ;
    _miseTF.text = [NSString stringWithFormat:@"%d", tmp ];
    
    
    [self getNewCards:nil];
    
}

- (void) intitialiseGame
{
    
    NSLog(@"----------------------------------------------------------");
    
    
    //[_userPlayer addCard:[[Carte alloc] init]];
    [_userPlayer addCard:[[Carte alloc] initWithColor:coeur Number:[NSNumber numberWithInt:5] Value:[NSNumber numberWithInt:5]]];
    
        NSString * nomCarte = [[[_userPlayer cartes] objectAtIndex:[_userPlayer.cartes count]-1] description];
        [_cartePlayer addObject:[[UIImageView alloc] initWithImage:[UIImage imageNamed:nomCarte]]];
    [self updCarte:1];
    
    [_comPlayer addCard:[[Carte alloc] init]];
        nomCarte = [[[_comPlayer cartes] objectAtIndex:[_comPlayer.cartes count]-1] description];
        [_carteCom addObject:[[UIImageView alloc] initWithImage:[UIImage imageNamed:nomCarte]]];
    [self updCarte:0];
    
    //[_userPlayer addCard:[[Carte alloc] init]];
    [_userPlayer addCard:[[Carte alloc] initWithColor:pique Number:[NSNumber numberWithInt:5] Value:[NSNumber numberWithInt:5]]];
        nomCarte = [[[_userPlayer cartes] objectAtIndex:[_userPlayer.cartes count]-1] description];
        [_cartePlayer addObject:[[UIImageView alloc] initWithImage:[UIImage imageNamed:nomCarte]]];
    [self updCarte:1];
    
    
    if ([[_userPlayer.cartes objectAtIndex:0] number]== [[_userPlayer.cartes objectAtIndex:1] number]) {
        _splitButton.hidden = NO;
        [_splitButton setEnabled:true];
    }
    
    
    
    [self updateScore];

}

#pragma mark Game
- (void) updateScore
{
    _scoreUser.text = [[NSNumber numberWithInt:[_userPlayer getValueOfCards]] stringValue];
    _scoreCom.text  = [[NSNumber numberWithInt:[_comPlayer getValueOfCards]] stringValue];
    _scoreSplit.text = [[NSNumber numberWithInt:[_splitPLayer getValueOfCards]] stringValue];
    
    
    _userCartesLabel.text = @"" ;
    _comCartesLabel.text = @"" ;
    
    for (int i = 0; i < (int) [_userPlayer.cartes count ]; i++) {
        
        _userCartesLabel.text = [NSString stringWithFormat:@"%@ %@", _userCartesLabel.text, [[_userPlayer.cartes objectAtIndex:i] number]];
        
    }
    
    for (int i = 0; i < (int) [_comPlayer.cartes count ]; i++) {
        
        _comCartesLabel.text = [NSString stringWithFormat:@"%@ %@", _comCartesLabel.text, [[_comPlayer.cartes objectAtIndex:i] number]];
        
    }
    
    if (_splitMode == YES) {
        _scoreSplit.text = [[NSNumber numberWithInt:[_splitPLayer getValueOfCards]] stringValue];
    }
    
    
    
    if([_scoreUser.text intValue] == 21)
    {
        [_getCardButton setEnabled:false];
        [_doubleButton setEnabled:false];
    }
    
    if ([self theGameIsOver]) {
        _resultGame = [Rules whoIsTheWinnerBetweenUser:[_userPlayer getValueOfCards] AndCom:[_comPlayer getValueOfCards]];
        [self displayResult];
    }
    
    
}

- (BOOL) theGameIsOver{
    
    NSLog(@"Com value%d",[_comPlayer getValueOfCards]);
    
    
    // On arrete le jeu si,
        // com >= 17
        // user > 21
        // user = com et l'utilisateur ne peut pas reprendre des cartes.
        // com > user et l'utilisateur ne peut pas reprendre des cartes.
    
    
    if ( [_comPlayer getValueOfCards] >= 17) {
        return true;
    }
    
    if ( [_userPlayer getValueOfCards] > 21){
        return true;
    }
    
    if ( [_comPlayer getValueOfCards] == [_userPlayer getValueOfCards] && ![_getCardButton isEnabled] ){
        return true;
    }
    
    if ( [_comPlayer getValueOfCards] > [_userPlayer getValueOfCards] && ![_getCardButton isEnabled] ){
        return true;
    }
    
    return false;
}



- (IBAction)getNewCards:(id)sender {
    
    [_userPlayer addCard:[[Carte alloc] init]];
    [self updateScore];
    
    NSString * nomCarte = [[[_userPlayer cartes] objectAtIndex:[_userPlayer.cartes count]-1] description];
    [_cartePlayer addObject:[[UIImageView alloc] initWithImage:[UIImage imageNamed:nomCarte]]];
    [self updCarte:1];
    
    if (_splitMode == YES) {
        [_splitPLayer addCard:[[Carte alloc] init]];
        [self updateScore];
       
        nomCarte = [[[_splitPLayer cartes] objectAtIndex:[_splitPLayer.cartes count]-1] description];
        [_carteSplit addObject:[[UIImageView alloc] initWithImage:[UIImage imageNamed:nomCarte]]];
        [self updCarte:2];
        
    }
    else
    {
        _splitButton.hidden = YES;
    }
    
}
- (IBAction)endGameButton:(id)sender {
    
    [_getCardButton setEnabled:false];
    [_doubleButton setEnabled:false];
    
    [_comPlayer addCard:[[Carte alloc] init]];
    NSString * nomCarte = [[[_comPlayer cartes] objectAtIndex:[_comPlayer.cartes count]-1] description];
    [_carteCom addObject:[[UIImageView alloc] initWithImage:[UIImage imageNamed:nomCarte]]];
    [self updCarte:0];

    [self updateScore];

    
    // SI LE SCORE EST INFERIEUR A USER ON REJOUE
    if (![self theGameIsOver]) {
        [self endGameButton:nil];
    }
}

- (IBAction)split:(id)sender {
    
    _splitPLayer = [[Player alloc] initWithName:@"Split"];
    
    // Money
    int tmp = [_miseTF.text intValue];
    if (tmp > [_MoneyValue.text intValue]) {
        
        _displayWinner.text = @"Fond insufisant";
        _displayWinner.hidden = NO;
        _splitButton.hidden = YES;
        
        return ;
    }
    
    [self updateCurrency:tmp AndSign:(enum sign*) enlever];
    tmp *= 2 ;
    _miseTF.text = [NSString stringWithFormat:@"%d", tmp ];
    
    //Split of
    _splitMode  = YES;
    [_splitButton setEnabled:false];
    [_splitPLayer.cartes addObject:[_userPlayer.cartes objectAtIndex:1]];
    [_userPlayer.cartes removeObjectAtIndex:1];
    
    NSString * nomCarte = [[[_splitPLayer cartes] objectAtIndex:[_splitPLayer.cartes count]-1] description];
    [_carteSplit addObject:[[UIImageView alloc] initWithImage:[UIImage imageNamed:nomCarte]]];
    
    //NSLog(@"SplitMode ON");
    [[_carteView.subviews objectAtIndex:1] removeFromSuperview];
    
    [[_carteSplit objectAtIndex:[_carteSplit count]-1] setFrame:CGRectMake(([_carteSplit count]- 1) * 40, 80, 80 , 80)];
    [self.carteView addSubview:[_carteSplit objectAtIndex:[_carteSplit count]-1]];
    
    //NSLog(@"Count cartes %lu", (unsigned long)[_splitPLayer.cartes count]);
    //NSLog(@"Count split  %lu", (unsigned long)[_userPlayer.cartes count]);
    
    
    
    [self updateScore];
    
}


#pragma mark Display
- (void) updCarte:(int) Joueur
{
    
    if (_splitMode == NO) {
        //ComPlayer
        if (Joueur == 0) {
            [[_carteCom objectAtIndex:[_carteCom count]-1] setFrame:CGRectMake(([_carteCom count]- 1) * 40, 0, 80 , 80)];
            [self.carteViewCom addSubview:[_carteCom objectAtIndex:[_carteCom count]-1]];
        }
        else
        {
            [[_cartePlayer objectAtIndex:[_cartePlayer count]-1] setFrame:CGRectMake(([_cartePlayer count]- 1) * 40, 0, 80 , 80)];
            [self.carteView addSubview:[_cartePlayer objectAtIndex:[_cartePlayer count]-1]];
        }
    }
    else{
    
        if (Joueur == 0) {
            [[_carteCom objectAtIndex:[_carteCom count]-1] setFrame:CGRectMake(([_carteCom count]- 1) * 40 , 0, 80 , 80)];
            [self.carteViewCom addSubview:[_carteCom objectAtIndex:[_carteCom count]-1]];
        }
        else if (Joueur == 1)
        {
            [[_cartePlayer objectAtIndex:[_cartePlayer count]-1] setFrame:CGRectMake(([_cartePlayer count]- 1) * 40 - 40, 0, 80 , 80)];
            [self.carteView addSubview:[_cartePlayer objectAtIndex:[_cartePlayer count]-1]];
        }
        else
        {
            [[_carteSplit objectAtIndex:[_carteSplit count]-1] setFrame:CGRectMake(([_carteSplit count]- 1) * 40, 80, 80 , 80)];
            [self.carteView addSubview:[_carteSplit objectAtIndex:[_carteSplit count]-1]];
        
        }
        
    
    }
    
}

- (void )displayResult
{
    
    if ((int)_resultGame == comWin) {
        _displayWinner.text =[NSString stringWithFormat:@"Vous perdez %d €", [_miseTF.text intValue]];
    }
    else if ((int)_resultGame == userWin)
    {
        _displayWinner.text =@"Gagné !!!! ";
        [self updateCurrency:[_miseTF.text intValue]*2 AndSign:ajouter];
    }
    else if ((int)_resultGame == noWiner)
    {
    
        _displayWinner.text = @"Match null";
        [self updateCurrency:[_miseTF.text intValue] AndSign:ajouter];
    }
    
    [_miseButton setEnabled:true];
    [_endGameButton setEnabled:false];
    [_getCardButton setEnabled:false];
    [_doubleButton setEnabled:false];
    [_miseTF setEnabled:true];
    
    //NSLog(@"money = %d", [_userPlayer money]);
        _displayWinner.hidden = NO;
    
    _miseTF.text = @"20";
}



/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
