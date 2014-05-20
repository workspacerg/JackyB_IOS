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
    _MoneyValue.text = [[_userPlayer money] stringValue];
    
    [_getCardButton setEnabled:false];
    [_endGameButton setEnabled:false];
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
        
        _displayWinner.text = @"In game";
        
        _currentMise.text = _miseTF.text;
        
        _MoneyValue.text = [NSString stringWithFormat:@"%d",[_MoneyValue.text intValue] - [_currentMise.text intValue] ]  ;
        
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
    
    if ([Rules valueIsOutOfLimit:[_scoreUser.text intValue]]) {
        
        if ([_userPlayer joker] > 0) {
            
            NSLog(@"I use joker");
            [_userPlayer useJoker];
            [self updateScore];
            
        }
        else{

            [self looseGame];
            [_getCardButton setEnabled:false];
            [_endGameButton setEnabled:false];
            [_miseButton setEnabled:true];
        }
        
    }
    
    if([_scoreUser.text intValue] == 21)
    {
        [_getCardButton setEnabled:false];
        NSLog(@"21 tout pile");
    }
    
    [self theGameItOver];
    
}

- (void) theGameIsOver{


}

- (IBAction)getNewCards:(id)sender {
    [_userPlayer addCard:[[Carte alloc] init]];
    [self updateScore];
    
}


- (void) didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)endGameButton:(id)sender {
    
    [_getCardButton setEnabled:false];
    
    [_comPlayer addCard:[[Carte alloc] init]];

    [self updateScore];
    
    if ([_scoreCom.text intValue] < [_scoreUser.text intValue]) {
        [self endGameButton:nil];
    }
    else{
        
        if ([_scoreCom.text intValue] > [_scoreUser.text intValue]) {
            [self looseGame];
        }
        if ([_scoreCom.text intValue] > 21) {
            if ([_comPlayer joker] > 0) {
                NSLog(@"Com use joker");
                [_comPlayer useJoker];
                [self updateScore];
                if ([_scoreCom.text intValue] > 21) {
                    [self winGame];
                }
                else
                {
                    [self endGameButton:nil];

                }
            }
            else{
                [self winGame];
            }
            
        }
        if ([_scoreCom.text intValue] == [_scoreUser.text intValue]) {
            [self nobodyWin];
        }
        
        [_miseButton setEnabled:true];
        [_endGameButton setEnabled:false];
    }
}

-(void) winGame
{
    _displayWinner.text =@"You Win";
    [self updateCurrency:[_currentMise.text intValue]*2 AndSign:ajouter];
    
}

-(void) looseGame
{
    _displayWinner.text =@"You Loose";
}

-(void) nobodyWin
{
    _displayWinner.text = @"Nobody Win";
    [self updateCurrency:[_currentMise.text intValue] AndSign:ajouter];
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
