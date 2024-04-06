//
//  LoginManager.m
//  CurrencyXchange
//
//  Created by Samer Ghanim on 02/04/2024.
//

#import "LoginManager.h"
#import "APIClient.h"
#import "MailObject.h"
#import "NSObject+DictionaryRepresentation.h"
@implementation LoginManager {
    NSTimer *sessionTimer;
}

+ (instancetype)sharedInstance {
    static LoginManager *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[self alloc] init];
    });
    return sharedInstance;
}
- (instancetype)init {
    self = [super init];
    if (self) {
        _isLoggedIn = NO;
        _loggedInUser=nil;
    }
    return self;
}
- (void)loginWithUsername:(NSString *_Nullable)username password:(NSString *_Nullable)password LoginResults:(LoginResultsBlock _Nullable)block{
    //user/login
    APIClient *client = [[APIClient alloc]init];
    [client setFileURL:LOGIN_API];
    [client setHTTPMethod:GET];
    [client setHttpHeaderFields:@{@"x-api-key":API_KEY}];
    [client setAdditionalParameters:@{@"username":username, @"password":password}];
    [client Execute:^(NSDictionary * _Nullable results, NSError * _Nonnull error) {
        id user = [results objectForKey:@"user"];
        if (user != [NSNull null]) {
            self->_loggedInUser = [[User alloc]init];
            self->_loggedInUser.userID = [[user objectForKey:@"userID"] integerValue];
            self->_loggedInUser.username = [user objectForKey:@"username"];
            self->_loggedInUser.firstName = [user objectForKey:@"firstname"];
            self->_loggedInUser.email = [user objectForKey:@"lastName"];
            self->_loggedInUser.firstName = [user objectForKey:@"email"];
            self->_loggedInUser.appName = [user objectForKey:@"appName"];
            self->_loggedInUser.isAdmin = [[user objectForKey:@"isAdmin"] integerValue];
            self->_loggedInUser.createdDate = [user objectForKey:@"createdDate"];
            self->_loggedInUser.lastLogin = [user objectForKey:@"lastLogin"];
            self->_loggedInUser.isValidCredentails = [[user objectForKey:@"validCredentails"] boolValue];
            self->_isLoggedIn = self->_loggedInUser.isValidCredentails;
            self->_loginTime = [NSDate date];
            block(self->_loggedInUser,error);
        } else {
            self->_isLoggedIn = NO;
            block(self->_loggedInUser,error);
        }
        
    }];
}
- (void)requestPasswordResetForUser:(NSString *)username email:(NSString *)email ResetResults:(ResetResultsBlock)block {
    //RESET_PASSWORD_API
    APIClient *client = [[APIClient alloc]init];
    [client setFileURL:GUID_API];
    [client setHTTPMethod:GET];
    [client setHttpHeaderFields:@{@"x-api-key":API_KEY}];
    [client setAdditionalParameters:@{@"username":username}];
    [client Execute:^(NSDictionary * _Nullable results, NSError * _Nonnull error) {
        block(results,error);
    }];
    
}
- (void)SendMessageToEmail:(NSString *)emailAddress Username:(NSString *)username GUID:(NSString*)GUID SendMailResults:(SendMalResultsBlock)block {
    APIClient *client = [[APIClient alloc]init];
    [client setFileURL:PASSWORD_RESET_API];
    [client setHTTPMethod:POST];
    [client setHttpHeaderFields:@{@"x-api-key":API_KEY}];
    NSString* resetPasswordURL = [NSString stringWithFormat:@"https://exchanger.cwtjo.org/?un=%@&uid=%@",username, GUID];
    NSString *Body = Email_Template(username, resetPasswordURL, resetPasswordURL, @"24 Hours");
    
    
    NSMutableDictionary* mail = [[NSMutableDictionary alloc]init];
    [mail setObject:username forKey:@"username"];
    [mail setValue:@"currencyXchanger@cwtjo.org" forKey:@"fromEmail"];
    [mail setObject:@"Currency Xchanger" forKey:@"fromName"];
    [mail setValue:emailAddress forKey:@"toEmail"];
    [mail setValue:@"eXchanger User" forKey:@"toName"];
    [mail setValue:@"Password Reset" forKey:@"subject"];
    [mail setValue:Body forKey:@"body"];
    [mail setValue:@YES forKey:@"isHTMLBody"];
    [mail setValue:@"mail.cwtjo.org" forKey:@"smtpServer"];
    NSNumber *numberValue = [NSNumber numberWithInt:25];
    [mail setValue:numberValue forKey:@"smtpPort"];
    [mail setValue:@"currencyXchanger@cwtjo.org" forKey:@"senderEmail"];
    [mail setValue:@"$Samer1974$" forKey:@"senderPassword"];
    [mail setValue:@NO forKey:@"enableSSL"];

    [client setAdditionalParameters:mail];
    [client ExecutePOST:^(NSDictionary * _Nullable results, NSError * _Nonnull error) {
        if (results != nil) {
            block(results,error);
        } else {
            block(results,error);
        }
    }];
}
- (void)resetTimer {
    // Invalidate previous timer
    [sessionTimer invalidate];
    
    // Start a new timer
    sessionTimer = [NSTimer scheduledTimerWithTimeInterval:(20 * 60)  // 20 minutes
                                                     target:self
                                                   selector:@selector(logoutDueToInactivity)
                                                   userInfo:nil
                                                    repeats:NO];
}
- (void)logoutDueToInactivity {
    [self logout];
    NSLog(@"Session expired due to inactivity.");
}
- (void)logout {
    _isLoggedIn = NO;
    _loggedInUser = nil;
    NSLog(@"User logged out");
}

- (BOOL)isSessionValid {
    if (_isLoggedIn) {
        NSDate *currentTime = [NSDate date];
        NSTimeInterval elapsedTime = [currentTime timeIntervalSinceDate:_loginTime];
        if (elapsedTime <= (20 * 60)) { // 20 minutes in seconds
            return YES;
        } else {
            [self logout];
            return NO;
        }
    }
    return NO;
}

@end
