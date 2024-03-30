//
//  CurrencyXchangeViewController.m
//  CurrencyXchange
//
//  Created by Samer Ghanim on 30/03/2024.
//

#import "CurrencyXchangeViewController.h"

@interface CurrencyXchangeViewController ()

@end

@implementation CurrencyXchangeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.lblTitle.text=[NSString stringWithFormat:@"Welcome, %@ %@",_firstName,_lastName];
    // Do any additional setup after loading the view.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
