//
//  CurrencyXchangeViewController.h
//  CurrencyXchange
//
//  Created by Samer Ghanim on 30/03/2024.
//

#import <UIKit/UIKit.h>
#import "Helper.h"
#import "ListCountriesViewController.h"
#import "LoginViewController.h"
NS_ASSUME_NONNULL_BEGIN

@interface CurrencyXchangeViewController : UIViewController <APIClientDelegate, UISearchBarDelegate, UIPickerViewDelegate>
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
@property (weak, nonatomic) IBOutlet UISearchBar *fromSearch;
@property (weak, nonatomic) IBOutlet UIButton *btnSelecte;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *btnLogout;
@property (weak, nonatomic) IBOutlet UILabel *fromSymbol;
@property (weak, nonatomic) IBOutlet UILabel *fromCurrencyName;
@property (weak, nonatomic) IBOutlet UILabel *toCurrencyName;

@property (weak, nonatomic) IBOutlet UILabel *toSymbol;


- (IBAction)selectTapped:(id)sender;
- (IBAction)logoutTapped:(id)sender;

@end

NS_ASSUME_NONNULL_END
