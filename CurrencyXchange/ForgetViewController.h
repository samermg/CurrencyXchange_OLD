//
//  ViewController.h
//  CurrencyXchange
//
//  Created by Samer Ghanim on 29/03/2024.
//

#import <UIKit/UIKit.h>
#import <MessageUI/MessageUI.h>
#import "ForgetViewController.h"
#import "UIViewController+Alert.h"
#import "LoginManager.h"

@interface ForgetViewController : UIViewController <UITextFieldDelegate, MFMailComposeViewControllerDelegate>
@property (weak, nonatomic) IBOutlet UITextField *username;
@property (weak, nonatomic) IBOutlet UITextField *email;

@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UIButton *btnVerify;
- (IBAction)backLogin:(id)sender;

- (IBAction)verify:(id)sender;
@end

