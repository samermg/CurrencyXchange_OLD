//
//  CurrencyXchangeViewController.h
//  CurrencyXchange
//
//  Created by Samer Ghanim on 30/03/2024.
//

#import <UIKit/UIKit.h>
#import "Helper.h"
#import "APIClient.h"
#import "ListCountriesViewController.h"
#import "LoginViewController.h"
#import "LoginManager.h"
typedef void (^CompletionHandler)(void);
@interface CurrencyXchangeViewController : UIViewController <UIPickerViewDelegate,UIPickerViewDataSource, APIClientDelegate, UITextFieldDelegate>
@property (nonatomic, strong) NSString* firstName;
@property (nonatomic, strong) NSString* lastName;
@property (weak, nonatomic) IBOutlet UIPickerView *sourcePicker;
@property (weak, nonatomic) IBOutlet UIPickerView *destinationPicker;
@property CurrencyCode SenderDelegate;
@property (weak, nonatomic) IBOutlet UITextField *fromAmount;
@property (weak, nonatomic) IBOutlet UITextField *toAmount;
@property (weak, nonatomic) IBOutlet UILabel *lblFrom;
@property (weak, nonatomic) IBOutlet UILabel *lblTo;
@property (weak, nonatomic) IBOutlet UIImageView *fromCurrencyFlag;
@property (weak, nonatomic) IBOutlet UIImageView *toCurrencyFlag;
@property (weak, nonatomic) IBOutlet UIButton *btnSwap;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *btnLogout;
@property (weak, nonatomic) IBOutlet UILabel *fromSymbol;
@property (weak, nonatomic) IBOutlet UILabel *fromCurrencyName;
@property (weak, nonatomic) IBOutlet UILabel *toCurrencyName;
@property (weak, nonatomic) IBOutlet UILabel *lblSlagon;

@property (weak, nonatomic) IBOutlet UILabel *toSymbol;

- (IBAction)logoutTapped:(id)sender;
- (IBAction)swapCurrencies:(id)sender;

@end


