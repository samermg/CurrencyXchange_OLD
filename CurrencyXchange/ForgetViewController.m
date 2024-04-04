//
//  ViewController.m
//  CurrencyXchange
//
//  Created by Samer Ghanim on 29/03/2024.
//

#import "LoginViewController.h"
#import "ForgetViewController.h"
#import "LoadingIndicator.h"
#import "MainNavigationContoller.h"

#import "Helper.h"
@interface ForgetViewController ()
@property (weak, nonatomic) IBOutlet LoadingIndicator *loadingMe;
@end

@implementation ForgetViewController
-(void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:self];
    //[self showMainViewController];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.username.delegate = self;
    self.email.delegate = self;
    [self setImageBackground];
    [self setupSpinner];
    UIColor *customColor = [UIColor whiteColor];
    
    // Set border color for username and password fields
    self.username.layer.borderColor = customColor.CGColor;
    self.email.layer.borderColor = customColor.CGColor;
    
    // Set border width for username and password fields
    self.username.layer.borderWidth = 0.5;
    self.email.layer.borderWidth = 0.5;
    // Do any additional setup after loading the view.
}
- (void)setupSpinner {
    self.loadingMe.lineWidth = 3;
    self.loadingMe.spinnerColors = @[[Helper colorWithHexString:@"FFFFFF"]];
    self.loadingMe.hidesWhenStopped = YES;
}
- (void)setImageBackground {
    UIImage *background = [UIImage imageNamed:@"design/login-6"];
    
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:self.view.bounds];
    imageView.contentMode = UIViewContentModeScaleAspectFill;
    imageView.clipsToBounds = YES;
    imageView.image = background;
    imageView.center = self.view.center;
    [self.view addSubview:imageView];
    [self.view sendSubviewToBack:imageView];
}
- (IBAction)verify:(id)sender {
    if ((_username.text.length>3) && (_email.text.length>3)) {
        [self updateUI:false];
        [self.loadingMe startAnimating];
        // User login
        __block NSString* name = self.username.text;
        __block NSString *email = self.email.text;
        dispatch_queue_t dwnQueue = dispatch_queue_create("StartQ", NULL);
        dispatch_async(dwnQueue, ^ {
            LoginManager *loginManager = [LoginManager sharedInstance];
            [loginManager SendMessageToEmail:email Username:name SendMailResults:^(NSDictionary * _Nullable SendMailResults, NSError * _Nullable Error) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    [self updateUI:true];
                    if (Error != nil) {
                        [self.loadingMe stopAnimating];
                        [self showAlert:[Error localizedDescription] andWithMessage:[Error localizedFailureReason]];
                    } else {
                        if ([[SendMailResults objectForKey:@"status"] isEqual:@"SUCCESS"]) {
                            self.username.text=@"";
                            self.email.text = @"";
                            [self showAlertWithTitle:@"Forget Password" message:@"" buttonTitle:@"OK" completionHandler:^{
                                [self.loadingMe stopAnimating];
                                [self dismissViewControllerAnimated:YES completion:nil];

                            }];
                        }
                    }
                    
                });
            }];
        });
    } else {
        [self showAlertWithTitle:@"Login" message:@"Please provide your Account details" buttonTitle:@"OK" completionHandler:nil];
    }
}

- (IBAction)backLogin:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)updateUI:(BOOL) status {
    [self.btnVerify setEnabled:status];
    [self.username setEnabled:status];
    [self.email setEnabled:status];
}

#pragma UITextFiled
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
}

#pragma End APIClient Delegate Methods
-(void)showMainViewController {
    [self dismissViewControllerAnimated:YES completion:nil];
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil]; // Assuming your storyboard name is "Main"
    MainNavigationContoller *mainNavigationController = [storyboard instantiateViewControllerWithIdentifier:@"MainNav"];
    
    [self presentViewController:mainNavigationController animated:YES completion:nil];
}
- (void)showCurrencyXchangeViewController:(NSString*)first last:(NSString*)last{
    // Instantiate home view controller from storyboard
    /*
     UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil]; // Assuming your storyboard name is "Main"
     CurrencyXchangeViewController *CurrencyXVC = [storyboard instantiateViewControllerWithIdentifier:@"HomeVC"]; // Make sure to set the Storyboard ID in the storyboard
     CurrencyXVC.firstName=first;
     CurrencyXVC.lastName=last;
     // Present home view controller
     [self presentViewController:CurrencyXVC animated:YES completion:nil];
     */
}

-(void)showAlert:(NSString*)title andWithMessage:(NSString*)message {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:title message:message  preferredStyle:UIAlertControllerStyleAlert];
    //Button 1
    UIAlertAction *actionOK = [UIAlertAction actionWithTitle:@"Ok" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        //code for performing acctions to be excuted when click Button1
        NSLog(@"Button 1 Pressed");
    }];
    [alert addAction:actionOK];
    [self presentViewController:alert animated:YES completion:nil];
}
- (void)sendEmail {
    if ([MFMailComposeViewController canSendMail]) {
        NSString* email = Email_Template(@"Samer Ghanim", @"http://www.cwtjo.org/currency/xchange/user/password/reset/link.php", @"http://www.cwtjo.org/currency/xchange/user/password/reset/link.php", @"24 Hours");
        MFMailComposeViewController *mailComposeViewController = [[MFMailComposeViewController alloc] init];
        mailComposeViewController.mailComposeDelegate = self;
        [mailComposeViewController setToRecipients:@[@"samermg@hotmail.com"]];
        [mailComposeViewController setSubject:@"CurrencyXchange Password Reset"];
        [mailComposeViewController setMessageBody:email isHTML:YES];
        [self presentViewController:mailComposeViewController animated:YES completion:nil];
    } else {
        // Handle the case where the device can't send email (e.g., show an alert)
        NSLog(@"Device cannot send email");
    }
}

#pragma mark - MFMailComposeViewControllerDelegate

- (void)mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error {
    if (result == MFMailComposeResultSent) {
        NSLog(@"Email sent successfully");
    }
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
