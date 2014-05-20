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

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    _userPlayer = [[Player alloc] initWithName:@"Romain"];
    _comPlayer  = [[Player alloc] initCom];
    _MoneyValue.text = [NSString stringWithFormat:@"%d", [_userPlayer money]];
    
    [_getCardButton setEnabled:false];
    [_endGameButton setEnabled:false];
    [_doubleButton setEnabled:false];
    _miseTF.text = @"20";
   
    
}
- (IBAction)Miser:(id)sender {

    
    
    if ([_miseTF.text intValue] > [_MoneyValue.text intValue] || [_miseTF.text intValue] == 0) {
        
        _displayWinner.text = @"You can't... ! ";
        
    }
    else
    {
        id button = sender;
        [button setEnabled:false];
        _scoreUser.text = @"0";
        _scoreCom.text  = @"0";
        
        [_userPlayer cleanGame];
        [_comPlayer cleanGame];
        
        [_getCardButton setEnabled:true];
        [_endGameButton setEnabled:true];
        [_doubleButton setEnabled:true];
        
        _displayWinner.text = @"In game";
        
        _currentMise.text = _miseTF.text;
        
       // _MoneyValue.text = [NSString stringWithFormat:@"%d",[_MoneyValue.text intValue] - [_currentMise.text intValue] ];
        
        [self updateCurrency:[_currentMise.text intValue] AndSign:enlever];
        
        [self intitialiseGame];

        
    }
    
    }

- (void) intitialiseGame
{
    
    NSLog(@"----------------------------------------------------------");
    
    [_userPlayer addCard:[[Carte alloc] init]];
    [_comPlayer addCard:[[Carte alloc] init]];
    [_userPlayer addCard:[[Carte alloc] init]];
    
    [self updateScore];

}

- (void) updateScore
{
    _scoreUser.text = [[NSNumber numberWithInt:[_userPlayer getValueOfCards]] stringValue];
    _scoreCom.text  = [[NSNumber numberWithInt:[_comPlayer getValueOfCards]] stringValue];
    
    _userCartesLabel.text = @"" ;
    _comCartesLabel.text = @"" ;
    
    for (int i = 0; i < (int) [_userPlayer.cartes count ]; i++) {
        
        _userCartesLabel.text = [NSString stringWithFormat:@"%@ %@", _userCartesLabel.text, [[_userPlayer.cartes objectAtIndex:i] number]];
        
    }
    
    for (int i = 0; i < (int) [_comPlayer.cartes count ]; i++) {
        
        _comCartesLabel.text = [NSString stringWithFormat:@"%@ %@", _comCartesLabel.text, [[_comPlayer.cartes objectAtIndex:i] number]];
        
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

    if ([_userPlayer getValueOfCards] > 21 || [_comPlayer getValueOfCards] > 21 || ( [_comPlayer getValueOfCards] == [_userPlayer getValueOfCards] && ![_getCardButton isEnabled]) ||( [_comPlayer getValueOfCards] > [_userPlayer getValueOfCards] && ![_getCardButton isEnabled])) {
        return true;
    }
    else
        return false;
}

- (void )displayResult
{
    
    if ((int)_resultGame == comWin) {
        _displayWinner.text =@"Dommage";
    }
    else if ((int)_resultGame == userWin)
    {
        _displayWinner.text =@"Magic Win";
        [self updateCurrency:[_currentMise.text intValue]*2 AndSign:ajouter];
    }
    else if ((int)_resultGame == noWiner)
    {
        NSLog(@"Bonjour");
        _displayWinner.text = @"Match null";
        [self updateCurrency:[_currentMise.text intValue] AndSign:ajouter];
    }
    
    [_miseButton setEnabled:true];
    [_endGameButton setEnabled:false];
    [_getCardButton setEnabled:false];
    [_doubleButton setEnabled:false];
    
    NSLog(@"money = %d", [_userPlayer money]);
    
    
}

- (IBAction)getNewCards:(id)sender {
    [_userPlayer addCard:[[Carte alloc] init]];
    [self updateScore];
    
    
}

- (IBAction)doubleMise:(id)sender {
    int tmp = [_currentMise.text intValue];
    
    [self updateCurrency:tmp AndSign:(enum sign*)enlever];
    
    tmp *= 2 ;
    _currentMise.text = [NSString stringWithFormat:@"%d", tmp ];

    
    [self getNewCards:nil];
    
}

- (void) didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)endGameButton:(id)sender {
    
    [_getCardButton setEnabled:false];
    [_doubleButton setEnabled:false];
    
    [_comPlayer addCard:[[Carte alloc] init]];

    [self updateScore];

    
    // SI LE SCORE EST INFERIEUR A USER ON REJOUE
    if ([_scoreCom.text intValue] < [_scoreUser.text intValue]) {
        [self endGameButton:nil];
    }
}



- (void) updateCurrency: (int) current AndSign: (enum signe *) sign
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
