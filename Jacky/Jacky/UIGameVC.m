//
//  UIGameVC.m
//  Jacky
//
//  Created by Romain GABEL on 19/05/2014.
//  Copyright (c) 2014 Romain GABEL. All rights reserved.
//

#import "UIGameVC.h"

@interface UIGameVC ()

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
   
    
}
- (IBAction)Miser:(id)sender {
    id button = sender;
    [button setEnabled:false];
    
    _scoreUser.text = @"0";
    _scoreCom.text  = @"0";
    
    [_userPlayer cleanCard];
    [_comPlayer cleanCard];
    
    
    [_getCardButton setEnabled:true];
    [_endGameButton setEnabled:true];
    _currentMise.text = _miseTF.text;
    NSLog(@"Test");
    [self intitialiseGame];
}

- (void) intitialiseGame
{
    
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
        
        _displayWinner.text = @"You Loose";
        
        [_getCardButton setEnabled:false];
        [_endGameButton setEnabled:false];
        [_miseButton setEnabled:true];
    }
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
    
    
    if ([_scoreCom.text intValue] > [_scoreUser.text intValue]) {
        _displayWinner.text =@"You Loose";
    }
    if ([_scoreCom.text intValue] > 21) {
        _displayWinner.text =@"You Win";
    }
    if ([_scoreCom.text intValue] == [_scoreUser.text intValue]) {
        _displayWinner.text = @"Nobody Win";
    }
    
    [_miseButton setEnabled:true];
    [_endGameButton setEnabled:false];
    

    
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
