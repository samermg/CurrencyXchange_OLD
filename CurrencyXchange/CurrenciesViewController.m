//
//  ViewController.m
//  CurrencyXchange
//
//  Created by Samer Ghanim on 29/03/2024.
//

#import "CurrenciesViewController.h"
#import "LoadingIndicator.h"
#import "Helper.h"
#import "APIClient.h"
@interface CurrenciesViewController ()
@property (weak, nonatomic) IBOutlet LoadingIndicator  *loadingMe;

@end

@implementation CurrenciesViewController

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
    self.username.layer.borderWidth = 1.0;
    self.password.layer.borderWidth = 1.0;
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
        APIClient *client = [[APIClient alloc]init];
        [client setFileURL:LOGIN_API];
        [client setHTTPMethod:GET];
        [client setDelegate:self];
        [client setHttpHeaderFields:@{@"x-api-key":API_KEY}];
        [client setAdditionalParameters:@{@"username":self.username.text, @"password":self.password.text}];
        [client Login];
    }
    else {
        [self showAlert:@"Login" andWithMessage:@"Please provide your login credentials"];
    }
    
}
-(void)updateUI:(BOOL) status {
    [self.btnLogin setEnabled:status];
    [self.username setEnabled:status];
    [self.password setEnabled:status];
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
#pragma APIClient Delegate Methods
- (void)APIRequest:(APIClient * _Nullable)load didFinishRequestWithContent:(NSDictionary * _Nullable)data {
    [self.loadingMe stopAnimating];
    NSDictionary* validation = [NSDictionary dictionaryWithDictionary:[data objectForKey:@"validation"]];
    BOOL isValidLogin = ([[validation objectForKey:@"status"]  isEqual: @"SUCCESS"]) ? TRUE : FALSE;
    
    if (isValidLogin) {
        NSDictionary* user = [NSDictionary dictionaryWithDictionary:[data objectForKey:@"user"]];
        //NSString*userID = [user objectForKey:@"userID"];
        NSString*first = [user objectForKey:@"firstName"];
        NSString*last = [user objectForKey:@"lastName"];
        [self showAlert:@"Login" andWithMessage:[NSString stringWithFormat:@"[%@]  Login - Welcome, %@ %@", isValidLogin? @"Valid" : @"Invalid", first,last]];
    } else {
        [self showAlert:@"Login" andWithMessage:@"Incorrect username or password. Please verify your credentials."];
    }
    //NSLog(@"%@",data);
    [self updateUI:true];
}
- (void)APIRequest:(APIClient * _Nullable)call didFinishRequestWithError:(NSString * _Nullable)error {
    [self.loadingMe stopAnimating];
    [self showAlert:@"Login" andWithMessage:error.description];
}

@end
