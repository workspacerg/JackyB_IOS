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
        [self updCarte];
    [_comPlayer addCard:[[Carte alloc] init]];
        nomCarte = [[[_comPlayer cartes] objectAtIndex:[_comPlayer.cartes count]-1] description];
        [_carteCom addObject:[[UIImageView alloc] initWithImage:[UIImage imageNamed:nomCarte]]];
        [self updCarte];
    //[_userPlayer addCard:[[Carte alloc] init]];
    [_userPlayer addCard:[[Carte alloc] initWithColor:coeur Number:[NSNumber numberWithInt:5] Value:[NSNumber numberWithInt:5]]];
        nomCarte = [[[_userPlayer cartes] objectAtIndex:[_userPlayer.cartes count]-1] description];
        [_cartePlayer addObject:[[UIImageView alloc] initWithImage:[UIImage imageNamed:nomCarte]]];
        [self updCarte];
    
    
    if ([[_userPlayer.cartes objectAtIndex:0] number]== [[_userPlayer.cartes objectAtIndex:1] number]) {
        _splitButton.hidden = NO;
    }
    
    
    
    [self updateScore];

}

#pragma mark Game
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



- (IBAction)getNewCards:(id)sender {
    [_userPlayer addCard:[[Carte alloc] init]];
    [self updateScore];
    
    NSString * nomCarte = [[[_userPlayer cartes] objectAtIndex:[_userPlayer.cartes count]-1] description];
    [_cartePlayer addObject:[[UIImageView alloc] initWithImage:[UIImage imageNamed:nomCarte]]];
    [self updCarte];
    
}
- (IBAction)endGameButton:(id)sender {
    
    [_getCardButton setEnabled:false];
    [_doubleButton setEnabled:false];
    
    [_comPlayer addCard:[[Carte alloc] init]];
    NSString * nomCarte = [[[_comPlayer cartes] objectAtIndex:[_comPlayer.cartes count]-1] description];
    [_carteCom addObject:[[UIImageView alloc] initWithImage:[UIImage imageNamed:nomCarte]]];
    [self updCarte];

    [self updateScore];

    
    // SI LE SCORE EST INFERIEUR A USER ON REJOUE
    if ([_scoreCom.text intValue] < [_scoreUser.text intValue]) {
        [self endGameButton:nil];
    }
}

- (IBAction)split:(id)sender {
    
    
    
}


#pragma mark Display
- (void) updCarte
{
    
    for (int i = 0 ; i < [_cartePlayer count]; i++) {
        
        [[_cartePlayer objectAtIndex:i] setFrame:CGRectMake(i * 40, 0, 80 , 80)];
        [self.carteView addSubview:[_cartePlayer objectAtIndex:i]];
        
    }
    
//    for (int i = 0 ; i < [_cartePlayer count]; i++) {
//        
//        [[_cartePlayer objectAtIndex:i] setFrame:CGRectMake(i * 40, 70, 70, 70)];
//        [self.carteView addSubview:[_cartePlayer objectAtIndex:i]];
//        
//    }
    
    for (int i = 0 ; i < [_carteCom count]; i++) {
        
        [[_carteCom objectAtIndex:i] setFrame:CGRectMake(i * 40, 0, 80, 80)];
        [self.carteViewCom addSubview:[_carteCom objectAtIndex:i]];
        
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
        NSLog(@"Bonjour");
        _displayWinner.text = @"Match null";
        [self updateCurrency:[_miseTF.text intValue] AndSign:ajouter];
    }
    
    [_miseButton setEnabled:true];
    [_endGameButton setEnabled:false];
    [_getCardButton setEnabled:false];
    [_doubleButton setEnabled:false];
    [_miseTF setEnabled:true];
    
    NSLog(@"money = %d", [_userPlayer money]);
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
