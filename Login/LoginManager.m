//
//  LoginManager.m
//  CurrencyXchange
//
//  Created by Samer Ghanim on 02/04/2024.
//

#import "LoginManager.h"
#import "APIClient.h"
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
    APIClient *client = [[APIClient alloc]init];
    [client setFileURL:LOGIN_API];
    [client setHTTPMethod:GET];
    [client setHttpHeaderFields:@{@"x-api-key":API_KEY}];
    [client setAdditionalParameters:@{@"username":username, @"password":password}];
    [client Login:^(NSDictionary * _Nullable results, NSError * _Nonnull error) {
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
            block(self->_loggedInUser,nil);
        } else {
            self->_isLoggedIn = NO;
            block(self->_loggedInUser,error);
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