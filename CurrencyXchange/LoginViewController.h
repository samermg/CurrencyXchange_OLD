//
//  ViewController.h
//  CurrencyXchange
//
//  Created by Samer Ghanim on 29/03/2024.
//

#import <UIKit/UIKit.h>
#import "LoginViewController.h"
#import "ForgetViewController.h"
#import "LoginManager.h"
@interface LoginViewController : UIViewController <UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITextField *username;
@property (weak, nonatomic) IBOutlet UITextField *password;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UIButton *btnLogin;
- (IBAction)forgetLogin:(id)sender;

- (IBAction)login:(id)sender;
@end

