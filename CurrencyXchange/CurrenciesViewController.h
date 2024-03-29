//
//  ViewController.h
//  CurrencyXchange
//
//  Created by Samer Ghanim on 29/03/2024.
//

#import <UIKit/UIKit.h>
#import "APIClient.h"
@interface CurrenciesViewController : UIViewController <UITextFieldDelegate, APIClientDelegate>
@property (weak, nonatomic) IBOutlet UITextField *username;
@property (weak, nonatomic) IBOutlet UITextField *password;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UIButton *btnLogin;

- (IBAction)login:(id)sender;
@end

