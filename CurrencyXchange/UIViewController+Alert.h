//
//  UIViewController+Alert.h
//  CurrencyXchange
//
//  Created by Samer Ghanim on 02/04/2024.
//

#import <UIKit/UIKit.h>

@interface UIViewController (Alert)

- (void)showAlertWithTitle:(NSString *)title message:(NSString *)message buttonTitle:(NSString*)buttonTitle completionHandler:(void (^)(void))completionHandler;
@end
