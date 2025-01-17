//
//  ViewController.m
//  CurrencyXchange
//
//  Created by Samer Ghanim on 29/03/2024.
//

#import "CurrencyXchangeViewController.h"
#import "LoginViewController.h"
#import "LoadingIndicator.h"
#import "UIViewController+Alert.h"
#import "MainNavigationContoller.h"
#import "Helper.h"

@interface LoginViewController ()
@property (weak, nonatomic) IBOutlet LoadingIndicator  *loadingMe;

@end

@implementation LoginViewController
-(void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:self];
    LoginManager *loginManager = [LoginManager sharedInstance];
    if (!loginManager.isLoginRequired) {
        [self showMainViewController:NO];
    }
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.username.delegate = self;
    self.password.delegate = self;
    [self setImageBackground];
    [self setupSpinner];
    UIColor *customColor = [UIColor whiteColor];
    
    // Set border color for username and password fields
    self.username.layer.borderColor = customColor.CGColor;
    
    self.password.layer.borderColor = customColor.CGColor;
    
    // Set border width for username and password fields
    self.username.layer.borderWidth = 0.5;
    self.password.layer.borderWidth = 0.5;
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
- (IBAction)login:(id)sender {
    if ((_username.text.length>3) && (_password.text.length>3)) {
        [self updateUI:false];
        [self.loadingMe startAnimating];
        // Usage Example
        
        // User login
        __block NSString* name = self.username.text;
        __block NSString *pass = self.password.text;
        dispatch_queue_t dwnQueue = dispatch_queue_create("StartQ", NULL);
        dispatch_async(dwnQueue, ^ {
            LoginManager *loginManager = [LoginManager sharedInstance];
            [loginManager loginWithUsername:name password:pass LoginResults:^(User * _Nullable LoginResults, NSError* _Nonnull Error) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    [self updateUI:true];
                    if (Error != nil) {
                        [self.loadingMe stopAnimating];
                        [self showAlert:[Error localizedDescription] andWithMessage:[Error localizedFailureReason]];
                    } else {
                        if (LoginResults.isValidCredentails) {
                            self.username.text=@"";
                            self.password.text = @"";
                            [self.loadingMe stopAnimating];
                            [self showMainViewController:YES];
                        }
                    }
                    
                });
            }];
            
        });
        // Check if session is valid
        
        
        // Simulate activity for 15 minutes
       
    } else {
        [self showAlertWithTitle:@"Login" message:@"Please provide your login credentials" buttonTitle:@"OK" completionHandler:nil];
    }
}

- (IBAction)forgetLogin:(id)sender {
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil]; // Assuming your storyboard name is "Main"
    ForgetViewController *ForgetVC = [storyboard instantiateViewControllerWithIdentifier:@"ForgetVC"]; // Make sure to set the Storyboard ID in the storyboard
    // Present home view controller
    [self presentViewController:ForgetVC animated:YES completion:nil];
}

-(void)updateUI:(BOOL) status {
    [self.btnLogin setEnabled:status];
    [self.username setEnabled:status];
    [self.password setEnabled:status];
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
-(void)showMainViewController:(BOOL)animation {
    [self dismissViewControllerAnimated:YES completion:nil];
    
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil]; // Assuming your storyboard name is "Main"
    MainNavigationContoller *mainNavigationController = [storyboard instantiateViewControllerWithIdentifier:@"MainNav"];
    
    //MainNavigationContoller *viewControllerToPresent = [[MainNavigationContoller alloc] init];
    mainNavigationController.modalPresentationStyle = UIModalPresentationFullScreen;
    mainNavigationController.modalPresentationCapturesStatusBarAppearance = YES;
    [self presentViewController:mainNavigationController animated:animation completion:nil];
    
    //[self presentViewController:mainNavigationController animated:YES completion:nil];
}
- (void)showCurrencyXchangeViewController:(NSString*)first last:(NSString*)last{
    // Instantiate home view controller from storyboard
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil]; // Assuming your storyboard name is "Main"
    CurrencyXchangeViewController *CurrencyXVC = [storyboard instantiateViewControllerWithIdentifier:@"HomeVC"]; // Make sure to set the Storyboard ID in the storyboard
    CurrencyXVC.firstName=first;
    CurrencyXVC.lastName=last;
    // Present home view controller
    [self presentViewController:CurrencyXVC animated:YES completion:nil];
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


@end
