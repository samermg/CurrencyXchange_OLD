//
//  CurrencyXchangeViewController.m
//  CurrencyXchange
//
//  Created by Samer Ghanim on 30/03/2024.
//
#import "GlobalSingleton.h"
#import "CurrencyXchangeViewController.h"
#import "LoadingIndicator.h"
#import "ListCountriesViewController.h"
#import "MainNavigationContoller.h"
#import "APIClient.h"
#import "UIViewController+Alert.h"
@interface CurrencyXchangeViewController ()<TableSelectionDelegate> {
    BOOL isFirstCall;
}
@property (weak, nonatomic) IBOutlet LoadingIndicator *loadingMe;
@property (strong,nonatomic) NSDictionary* rates;
@property (strong,nonatomic) NSArray* sourceCurrencies;
@property (strong,nonatomic) NSArray* destinationCurrencies;
@property (strong,nonatomic) NSString* baseCurrency;
@property (strong,nonatomic) NSDictionary* baseCurrencyDictionary;
@property (strong,nonatomic) NSMutableArray*symbols;


@end

@implementation CurrencyXchangeViewController
- (void)didSelectValue:(NSDictionary *)currency SenderDelegate:(CurrencyCode)sender {
    self.SenderDelegate = sender;
    if(sender == FromCurrency) {
        [self GetConversationRatesForBase:currency];
    } else {
        NSArray* keys = [currency allKeys];
        [self UpdateDestinationCurrency:[currency objectForKey:[keys objectAtIndex:0]]];
    }
}
-(void)restSessionTime {
    LoginManager *loginManager = [LoginManager sharedInstance];
    [loginManager resetTimer];
}
-(void)CheckLoginSession {
    LoginManager *loginManager = [LoginManager sharedInstance];
    // Simulate activity for 15 minutes
    
    if (![loginManager isSessionValid]) {
        [loginManager logout];
        [self showAlertWithTitle:@"Session Expired" message:@"Your session has expired due to inactivity. Please log in again." buttonTitle:@"Logout" completionHandler:^{
            [self dismissViewControllerAnimated:YES completion:nil];
        }];
    }
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Usage Login
    [self CheckLoginSession];
    isFirstCall = YES;
    _symbols = [NSMutableArray arrayWithArray:[Helper Symbols]];
    //From Currency Flag Gesture
    UITapGestureRecognizer *FromCurrencyFlagtapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(fromCurrencyFlagTapped:)];
    [self.fromCurrencyFlag addGestureRecognizer:FromCurrencyFlagtapGestureRecognizer];
    //To Currency Flag Gesture
    UITapGestureRecognizer *ToCurrencyFlagtapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(toCurrencyFlagTapped:)];
    [self.toCurrencyFlag addGestureRecognizer:ToCurrencyFlagtapGestureRecognizer];
    
    self.sourcePicker.delegate = self;
    self.destinationPicker.delegate = self;

    [_fromAmount addTarget:self action:@selector(textFieldDidChange:)
        forControlEvents:UIControlEventEditingChanged];

    [self setupSpinner];

    NSDictionary* currencyDic = @{@"USD": @{
        @"symbol": @"$",
        @"name": @"US Dollar",
        @"symbol_native": @"$",
        @"decimal_digits": @"2",
        @"rounding": @"0",
        @"code": @"USD",
        @"name_plural": @"US dollars"
    }};
    [self GetConversationRatesForBase:currencyDic];

    
    // Do any additional setup after loading the view.
}
- (void)fromCurrencyFlagTapped:(UITapGestureRecognizer *)gestureRecognizer {
    [self restSessionTime];
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil]; 
    ListCountriesViewController *ListViewController = [storyboard instantiateViewControllerWithIdentifier:@"CurrenciesVC"];
    ListViewController.CurrencyFlag = FromCurrency;
    ListViewController.UpdateFlagDelegate = self;
    ListViewController.symbols = _symbols;
    self.SenderDelegate = FromCurrency;
    [self.navigationController pushViewController:ListViewController animated:YES];
}
- (void)toCurrencyFlagTapped:(UITapGestureRecognizer *)gestureRecognizer {
    [self restSessionTime];
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    ListCountriesViewController *ListViewController = [storyboard instantiateViewControllerWithIdentifier:@"CurrenciesVC"];
    ListViewController.CurrencyFlag = ToCurrency;
    ListViewController.UpdateFlagDelegate = self;
    ListViewController.symbols = self.symbols;
    self.SenderDelegate = ToCurrency;
    
    [self.navigationController pushViewController:ListViewController animated:YES];
}
- (void)setupSpinner {
    self.loadingMe.lineWidth = 3;
    self.loadingMe.spinnerColors = @[[Helper colorWithHexString:@"0000FF"]];
    self.loadingMe.hidesWhenStopped = YES;
}
-(void)updateUI:(BOOL) status {
    
}
-(void)UpdateDestinationCurrency:(NSDictionary*)destinationCurrency {
    [self restSessionTime];
    NSString* currency = [destinationCurrency objectForKey:@"code"];
    NSInteger selectedRow = [_destinationCurrencies indexOfObject:currency];
    [_destinationPicker selectRow:selectedRow inComponent:0 animated:NO];
    _lblTo.text = currency;
    _toCurrencyName.text = [destinationCurrency objectForKey:@"name"];
    NSString *symbol = [destinationCurrency objectForKey:@"symbol_native"];
    symbol = [destinationCurrency objectForKey:@"symbol_native"];
    self.toSymbol.text = symbol;
    self.toCurrencyFlag.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@.svg", [currency lowercaseString]]];
    [self performSelector:@selector(textFieldDidChange:) withObject:_fromAmount];
}
- (void)GetConversationRatesForBase:(NSDictionary*)dictionary {
    [self restSessionTime];
    NSArray* keys = [dictionary allKeys];
    _baseCurrency = [keys objectAtIndex:0];
    _baseCurrencyDictionary = dictionary;
    if (_baseCurrency.length <3) return;
    //if ((_username.text.length>3) && (_password.text.length>3)) {
    [self updateUI:false];
    [self.loadingMe startAnimating];
    APIClient *client = [[APIClient alloc]init];
    [client setFileURL:[NSString stringWithFormat:@"%@/%@/latest/%@", CXChange_API, CXChange_KEY,_baseCurrency]];
    [client setHTTPMethod:GET];
    [client setDelegate:self];
    [client Featch];
}

#pragma APIClient Delegate Methods
- (void)APIRequest:(APIClient * _Nullable)load didFinishRequestWithContent:(NSDictionary * _Nullable)data {
    NSMutableArray* keys = [NSMutableArray array];
    BOOL operationSuccessful = [[data objectForKey:@"result"]  isEqual: @"success"];
    if (operationSuccessful) {
        _rates = [NSDictionary dictionaryWithDictionary:[data objectForKey:@"conversion_rates"]];
        for (int i = 0; i<_symbols.count; i++) {
            NSMutableDictionary* item = [[NSMutableDictionary alloc] initWithDictionary:[_symbols objectAtIndex:i]];
            NSDictionary* key = [[item allKeys] objectAtIndex:0];
            double _rate= [[_rates objectForKey:key] doubleValue];
            NSNumber *rate = [NSNumber numberWithDouble:_rate];
            NSMutableDictionary *newItem = [[NSMutableDictionary alloc]initWithDictionary:[item objectForKey:key]];
            [newItem removeObjectForKey:@"rate"];
            [newItem setObject:rate forKey:@"rate"];
            [item setObject:newItem forKey:key];
            [keys addObject:key];
            [_symbols replaceObjectAtIndex:i withObject:item];

        }
        _sourceCurrencies = [[NSArray alloc]initWithArray:keys];
        _destinationCurrencies = [[NSArray alloc]initWithArray:keys];
        [_sourcePicker reloadComponent:0];
        [_destinationPicker reloadComponent:0];
        
        // Select the row in Source component (column)
        __block NSDictionary* RateCurrency;
        __block NSInteger indexItem;
        [Helper getObjectIndexFromDictionary:_symbols forKey:_baseCurrency andFiledName:@"code" andResultBloch:^(NSDictionary *currency, int index) {
            indexItem = index;
            RateCurrency = currency;
        }];
        NSString* rateKey   = [self.sourceCurrencies objectAtIndex:indexItem];
        BOOL animated = FALSE; // Set to YES if you want the selection to be animated
        [_sourcePicker selectRow:indexItem inComponent:0 animated:animated];
        _lblFrom.text = rateKey;
        if (self.SenderDelegate == FromCurrency) {
            self.fromCurrencyFlag.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@.svg", [rateKey lowercaseString]]];
        }
        
        _fromCurrencyName.text = [RateCurrency objectForKey:@"name"];
        NSString *symbol = [RateCurrency objectForKey:@"symbol_native"];
        self.fromSymbol.text = symbol;
        
        if (isFirstCall) {
            NSInteger selectedRow = 52; // Change this to the index of the row you want to select
            NSString*destCurrency = self.destinationCurrencies[selectedRow];
            [self UpdateDestinationCurrency:[[_symbols objectAtIndex:52] objectForKey:destCurrency]];
            isFirstCall = NO;
        } else {
            [self performSelector:@selector(textFieldDidChange:) withObject:_fromAmount];
        }
        
    } else {
        [self showAlertWithTitle:@"Currency Exchange" message:@"Something went wrong! Please attempt your action again later." buttonTitle:@"OK" completionHandler:nil];
    }
    [self updateUI:true];
    [self.loadingMe stopAnimating];
}

- (void)APIRequest:(APIClient * _Nullable)call didFinishRequestWithError:(NSString * _Nullable)error {
    [self.loadingMe stopAnimating];
    [self showAlertWithTitle:@"Currency Exchange" message:error.description buttonTitle:@"OK" completionHandler:nil];
}
#pragma End APIClient Delegate Methods

#pragma TextFileds Events
// Implement the textFieldDidChange: method to handle the value changed event
- (void)textFieldDidChange:(UITextField *)textField {
    // Handle the value changed event here
    NSString *amoutInString = textField.text;
    //NSInteger selectedRowInSource = [_sourcePicker selectedRowInComponent:0];
    NSInteger selectedRowInDestination = [_destinationPicker selectedRowInComponent:0];
    double amount = [amoutInString doubleValue];
    NSString* rateKey   = self.destinationCurrencies[selectedRowInDestination];
    double rateValue = [[_rates valueForKey:rateKey] doubleValue];
    double converted = amount * rateValue;
    _toAmount.text = [Helper formateNumber:converted];
}
#pragma Surce Currencies Delegate Methods
- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view {
    UILabel *label = (UILabel *)view;
    
    if (!label) {
        label = [[UILabel alloc] init];
        label.textAlignment = NSTextAlignmentCenter; // Set text alignment
        label.textColor = (pickerView == _sourcePicker) ? [UIColor systemOrangeColor] : [UIColor systemBlueColor]; // Set font color
        label.font = [UIFont systemFontOfSize:17]; // Set font size
    }
    NSString *title;
    if (pickerView == self.sourcePicker) {
        title= _sourceCurrencies[row];
    } else if (pickerView == self.destinationPicker) {
        title= _destinationCurrencies[row];
    }
    // Customize the row content (assuming you have an array of strings named data)
    label.text = title;
    
    return label;
}
// Number of components in the pickerView
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    if (pickerView == self.sourcePicker) {
        return 1;
    } else if (pickerView == self.destinationPicker) {
        return 1;
    }
    return 1;
}

// Number of rows in the pickerView
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    if (pickerView == self.sourcePicker) {
        return _sourceCurrencies.count;
    } else if (pickerView == self.destinationPicker) {
        return self.destinationCurrencies.count;
    }
    return 0;
}
// Title for each row in the pickerView
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    if (pickerView == self.sourcePicker) {
        return _sourceCurrencies[row];
    } else if (pickerView == self.destinationPicker) {
        return _destinationCurrencies[row];
    }
    return 0;
}
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    NSString *selectedData;
    NSString* flag;
    NSDictionary*symolDic;
    
    if (pickerView == self.sourcePicker) {
        selectedData = self.sourceCurrencies[row];
        flag = [[NSString stringWithFormat:@"%@.svg",selectedData] lowercaseString];
        NSDictionary* currencyDic = [_symbols objectAtIndex:row];
        symolDic = [[_symbols objectAtIndex:row] objectForKey:selectedData];
        
        _fromCurrencyName.text = [symolDic objectForKey:@"name"];
        _lblFrom.text = selectedData;
        NSString *symbol = [symolDic objectForKey:@"symbol_native"];
        self.fromSymbol.text = symbol;
        self.fromCurrencyFlag.image = [UIImage imageNamed:flag];
        [self GetConversationRatesForBase:currencyDic] ;
    } else if (pickerView == self.destinationPicker) {
        selectedData = self.destinationCurrencies[row];
        symolDic = [[_symbols objectAtIndex:row] objectForKey:selectedData];
        _toCurrencyName.text = [symolDic objectForKey:@"name"];
        _lblTo.text=selectedData;
        NSString *symbol = [symolDic objectForKey:@"symbol_native"];
        self.toSymbol.text = symbol;
        flag = [[NSString stringWithFormat:@"%@.svg",selectedData] lowercaseString];
        self.toCurrencyFlag.image = [UIImage imageNamed:flag];
        
        [self performSelector:@selector(textFieldDidChange:) withObject:_fromAmount];
    }
}
- (IBAction)logoutTapped:(id)sender {
    LoginManager *loginManager = [LoginManager sharedInstance];
    [loginManager logout];
    [self dismissViewControllerAnimated:YES completion:nil];
    [self showLoginViewController];
}
- (void)showLoginViewController{
    // Instantiate home view controller from storyboard
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil]; // Assuming your storyboard name is "Main"
    LoginViewController *LoginVC = [storyboard instantiateViewControllerWithIdentifier:@"LoginVC"]; // Make sure to set the Storyboard ID in the storyboard
    // Present home view controller
    [self presentViewController:LoginVC animated:YES completion:nil];
}

@end
