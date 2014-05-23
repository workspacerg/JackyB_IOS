//
//  FisrtResponderVC.m
//  InterfaceTest
//
//  Created by Romain GABEL on 21/05/2014.
//  Copyright (c) 2014 Romain GABEL. All rights reserved.
//

#import "FisrtResponderVC.h"


@interface FisrtResponderVC ()

@property (nonatomic)  NSMutableArray * carteCom;
@property (nonatomic)  NSMutableArray * cartePlayer;

@end

@implementation FisrtResponderVC

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
    _cartePlayer = [[NSMutableArray alloc] init];
    _carteCom = [[NSMutableArray alloc] init];
    
    
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"wall2.png"]];
    
    
//    UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"1Coeur.png"]];
//    imageView.frame = CGRectMake(0, 400, 100, 100);
//    
//    //[self.view addSubview:imageView];
//    
//
//    UIImageView *imageView2 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"2Coeur.png"]];
//    
//    imageView2.frame = CGRectMake(40, 400, 100, 100);
//    
//    //[self.view addSubview:imageView2];
//    
//    UIImageView *imageView3 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"3Coeur.png"]];
//    
//    imageView3.frame = CGRectMake(80, 400, 100, 100);
//    
//   // [self.view addSubview:imageView3];
    
    

    
//    [_cartePlayer addObject:[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"3Coeur.png"]]];
//    [_cartePlayer addObject:[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"1Coeur.png"]]];
//    [_cartePlayer addObject:[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"3Coeur.png"]]];
//    [_cartePlayer addObject:[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"2Coeur.png"]]];
//    
//    
//
//    
//    [_carteCom addObject:[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"1Coeur.png"]]];
//    [_carteCom addObject:[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"2Coeur.png"]]];

    [self updCarte];

    
    
}

- (IBAction)getCarte:(id)sender {
    
    [_cartePlayer addObject:[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"3Coeur.png"]]];
    
    [self updCarte];

}

- (void) updCarte
{

    for (int i = 0 ; i < [_cartePlayer count]; i++) {
        
        [[_cartePlayer objectAtIndex:i] setFrame:CGRectMake(i * 40, 400, 100, 100)];
        [self.view addSubview:[_cartePlayer objectAtIndex:i]];
        
    }
    
    for (int i = 0 ; i < [_carteCom count]; i++) {
            
            [[_carteCom objectAtIndex:i] setFrame:CGRectMake(i * 40, 300, 100, 100)];
            [self.view addSubview:[_carteCom objectAtIndex:i]];
            
        }


}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
