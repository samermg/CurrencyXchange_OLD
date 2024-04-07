//
//  UIViewController+Alert.h
//  CurrencyXchange
//
//  Created by Samer Ghanim on 02/04/2024.
//

#import <UIKit/UIKit.h>

@interface UIViewController (Alert)

- (void)showAlertWithTitle:(NSString *)title message:(NSString *)message buttonTitle:(NSString*)buttonTitle completionHandler:(void (^)(void))completionHandler;
- (void)showConfirmationTitle:(NSString *)title message:(NSString *)message YesTitle:(NSString*)yesTitle NoTitle:(NSString*)noTitle completionHandler:(void (^)(BOOL confirmed))completionHandler;
@end
