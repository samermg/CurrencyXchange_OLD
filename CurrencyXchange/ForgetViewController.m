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
    } else {
        [self showAlert:@"Login" andWithMessage:@"Please provide your Account Details"];
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
