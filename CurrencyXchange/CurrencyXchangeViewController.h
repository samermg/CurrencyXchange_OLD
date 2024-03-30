//
//  CurrencyXchangeViewController.h
//  CurrencyXchange
//
//  Created by Samer Ghanim on 30/03/2024.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface CurrencyXchangeViewController : UIViewController
@property (nonatomic, strong) NSString* firstName;
@property (nonatomic, strong) NSString* lastName;
@property (weak, nonatomic) IBOutlet UILabel *lblTitle;

@end

NS_ASSUME_NONNULL_END
