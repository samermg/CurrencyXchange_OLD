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
@interface CurrencyXchangeViewController ()<TableSelectionDelegate> {
    BOOL isFirstCall;
}
@property (weak, nonatomic) IBOutlet LoadingIndicator *loadingMe;
@property (strong,nonatomic) NSDictionary* rates;
@property (strong,nonatomic) NSArray* sourceCurrencies;
@property (strong,nonatomic) NSArray* filteredCurrencies;
@property (strong,nonatomic) NSArray* destinationCurrencies;
@property (strong,nonatomic) NSString* baseCurrency;
@property (strong,nonatomic) NSDictionary* baseCurrencyDictionary;
@property (strong,nonatomic) NSMutableArray*symbols;
typedef void (^ResultsBlock)(NSDictionary*currency, int index);

@end

@implementation CurrencyXchangeViewController
- (void)didSelectValue:(NSDictionary *)currency SenderDelegate:(CurrencyCode)sender {
    self.SenderDelegate = sender;
    [self GetConversationRatesForBase:currency forCurrency:@"USD"];
}

- (void)viewDidLoad {
    [super viewDidLoad];
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
    [self GetConversationRatesForBase:currencyDic forCurrency:@"USD"];

    
    // Do any additional setup after loading the view.
}
- (void)fromCurrencyFlagTapped:(UITapGestureRecognizer *)gestureRecognizer {
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil]; 
    ListCountriesViewController *ListViewController = [storyboard instantiateViewControllerWithIdentifier:@"CurrenciesVC"];
    ListViewController.CurrencyFlag = FromCurrency;
    ListViewController.UpdateFlagDelegate = self;
    ListViewController.rates = self.rates;
    self.SenderDelegate = FromCurrency;
    [self.navigationController pushViewController:ListViewController animated:YES];
}
- (void)toCurrencyFlagTapped:(UITapGestureRecognizer *)gestureRecognizer {
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    ListCountriesViewController *ListViewController = [storyboard instantiateViewControllerWithIdentifier:@"CurrenciesVC"];
    ListViewController.CurrencyFlag = ToCurrency;
    ListViewController.UpdateFlagDelegate = self;
    ListViewController.rates = self.rates;
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
- (void)GetConversationRatesForBase:(NSDictionary*)dictionary forCurrency:(NSString*)currency {
    /*
     @"USD":
            @{
                @"symbol": @"$",
                @"name": @"US Dollar",
                @"symbol_native": @"$",
                @"decimal_digits": @"2",
                @"rounding": @"0",
                @"code": @"USD",
                @"name_plural": @"US dollars"
            }
     */

    _baseCurrency = currency;
    _baseCurrencyDictionary = dictionary;
    if (currency.length <3) return;
    //if ((_username.text.length>3) && (_password.text.length>3)) {
    [self updateUI:false];
    [self.loadingMe startAnimating];
    APIClient *client = [[APIClient alloc]init];
    [client setFileURL:[NSString stringWithFormat:@"%@/%@/latest/%@", CXChange_API, CXChange_KEY,currency]];
    [client setHTTPMethod:GET];
    [client setDelegate:self];
    [client Featch];
    //}
    //else {
    
    //    [self showAlert:@"Login" andWithMessage:@"Please provide your login credentials"];
    //}
}
- (NSInteger)getObjectIndex:(NSArray *)array byName:(NSString *)theName {
    NSInteger idx = 0;
    for (NSString* key in array) {
        if ([key isEqualToString:theName])
            return idx;
        ++idx;
    }
    return NSNotFound;
}
- (void)getObjectIndexFromDictionary:(NSArray *)array forKey:(NSString *)keyValue andFiledName:(NSString*)field andResultBloch:(ResultsBlock)block {
    int idx = 0;
    for (NSDictionary* item in array) {
        NSDictionary* currency = [item objectForKey:keyValue];
        if ([[currency objectForKey:field] isEqualToString:keyValue])
            block ([item objectForKey:keyValue], idx);
        ++idx;
    }
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
        _filteredCurrencies = [[NSArray alloc]initWithArray:_sourceCurrencies];
        _destinationCurrencies = [[NSArray alloc]initWithArray:keys];
        [_sourcePicker reloadComponent:0];
        [_destinationPicker reloadComponent:0];
        
        // Select the row in Source component (column)
        __block NSDictionary* RateCurrency;
        __block NSInteger indexItem;
        [self getObjectIndexFromDictionary:_symbols forKey:_baseCurrency andFiledName:@"code" andResultBloch:^(NSDictionary *currency, int index) {
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
            // Select the row in Destination component (column)
            NSInteger selectedRow = 52; // Change this to the index of the row you want to select
            NSString*destCurrency = self.destinationCurrencies[selectedRow];
            [_destinationPicker selectRow:selectedRow inComponent:0 animated:animated];
            _lblTo.text = destCurrency;
            RateCurrency = [_symbols objectAtIndex:selectedRow];
            _toCurrencyName.text = [[RateCurrency objectForKey:destCurrency] objectForKey:@"name"];
            symbol = [[RateCurrency objectForKey:destCurrency] objectForKey:@"symbol_native"];
            self.toSymbol.text = symbol;
            //if (self.SenderDelegate == ToCurrency) {
                self.toCurrencyFlag.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@.svg", [destCurrency lowercaseString]]];
            //}
            isFirstCall = NO;
        }
        [self performSelector:@selector(textFieldDidChange:) withObject:_fromAmount];
    } else {
        [self showAlert:@"Currency Exchange" andWithMessage:@"Something went wrong! Please attempt your action again later."];
    }
    [self updateUI:true];
    [self.loadingMe stopAnimating];
}

- (void)APIRequest:(APIClient * _Nullable)call didFinishRequestWithError:(NSString * _Nullable)error {
    [self.loadingMe stopAnimating];
    [self showAlert:@"Currency Exchange" andWithMessage:error.description];
}
#pragma End APIClient Delegate Methods
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
    _toAmount.text = [self formateNumber:converted];
}
-(NSString*)formateNumber:(double)number {
    NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
    formatter.numberStyle = NSNumberFormatterDecimalStyle;
    formatter.maximumFractionDigits = 3; // Set the maximum number of decimal places
    NSString *formattedString = [formatter stringFromNumber:@(number)];
    return formattedString;
}
#pragma mark - UISearchBarDelegate

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText {
    [self filterDataWithSearchQuery:_fromSearch.text];
}
- (BOOL)keyExistsInDictionary:(NSDictionary *)dictionary forKey:(NSString *)key {
    NSArray *allKeys = [dictionary allKeys];
    BOOL isKeyFound = [allKeys containsObject:key];
    return isKeyFound;
}
    
- (void)filterDataWithSearchQuery:(NSString*)query {
    query = [query uppercaseString];
    if (query.length == 0) {
        self.filteredCurrencies = self.sourceCurrencies; // Reset to original data if search query is empty
    } else {
        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF CONTAINS[c] %@", query];
        self.filteredCurrencies = [self.sourceCurrencies filteredArrayUsingPredicate:predicate];
        [self.sourcePicker reloadAllComponents];
        if (query.length==3) {
            BOOL isKeyFound = [self keyExistsInDictionary:_rates forKey:query];
            if (isKeyFound) {
                //[self GetConversationRatesForBase:query];
            }
        }
    }
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
        if (_fromSearch.text.length == 0) {
            title= _sourceCurrencies[row];
        } else {
            title = _filteredCurrencies[row];
        }
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
        if (_fromSearch.text.length == 0) {
            return _sourceCurrencies.count;
        } else {
            return _filteredCurrencies.count;
        }
    } else if (pickerView == self.destinationPicker) {
        return self.destinationCurrencies.count;
    }
    return 0;
}
// Title for each row in the pickerView
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    if (pickerView == self.sourcePicker) {
        if (_fromSearch.text.length == 0) {
            return _sourceCurrencies[row];
        } else {
            return _filteredCurrencies[row];
        }
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
        symolDic = [[_symbols objectAtIndex:row] objectForKey:selectedData];
        _fromCurrencyName.text = [symolDic objectForKey:@"name"];
        _lblFrom.text = selectedData;
        NSString *symbol = [symolDic objectForKey:@"symbol_native"];
        self.fromSymbol.text = symbol;
        self.fromCurrencyFlag.image = [UIImage imageNamed:flag];
        [self GetConversationRatesForBase:symolDic forCurrency:selectedData] ;
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
- (IBAction)selectTapped:(id)sender {
    [[GlobalSingleton sharedInstance] setCurrenciesRates:_rates];
}
@end
