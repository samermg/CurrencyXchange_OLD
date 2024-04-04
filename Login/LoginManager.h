//
//  LoginManager.h
//  CurrencyXchange
//
//  Created by Samer Ghanim on 02/04/2024.
//

#import <Foundation/Foundation.h>
#import "Helper.h"
#import "User.h"
#import "APIClient.h"
typedef void (^LoginResultsBlock)(User* _Nullable LoginResults, NSError* _Nullable Error);
typedef void (^SendMalResultsBlock)(NSDictionary* _Nullable SendMailResults, NSError* _Nullable Error);
@interface LoginManager : NSObject
@property (nonatomic, assign) BOOL isLoggedIn;
@property (nonatomic, strong) NSDate * _Nullable loginTime;
@property (nonatomic, strong) User * _Nullable loggedInUser;
+ (instancetype _Nullable )sharedInstance;
- (void)loginWithUsername:(NSString *_Nullable)username password:(NSString *_Nullable)password LoginResults:(LoginResultsBlock _Nullable)block;
- (void)SendMessageToEmail:(NSString *_Nullable)emailAddress Username:(NSString *_Nullable)username SendMailResults:(SendMalResultsBlock _Nullable)block;
- (BOOL)isLoggedIn;
- (void)resetTimer;
- (void)logout;
- (BOOL)isSessionValid;
@end

