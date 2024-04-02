//
//  UIViewController+Alert.m
//  CurrencyXchange
//
//  Created by Samer Ghanim on 02/04/2024.
//

#import "UIViewController+Alert.h"

@implementation UIViewController (Alert)

- (void)showAlertWithTitle:(NSString *)title message:(NSString *)message buttonTitle:(NSString*)buttonTitle completionHandler:(void (^)(void))completionHandler {
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title
                                                                             message:message
                                                                      preferredStyle:UIAlertControllerStyleAlert];
    if (buttonTitle.length<2) buttonTitle=@"OK";
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:buttonTitle
                                                       style:UIAlertActionStyleDefault
                                                     handler:^(UIAlertAction * _Nonnull action) {
                                                         if (completionHandler) {
                                                             completionHandler();
                                                         }
                                                     }];
    [alertController addAction:okAction];
    
    [self presentViewController:alertController animated:YES completion:nil];
}

@end
