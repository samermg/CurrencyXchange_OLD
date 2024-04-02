//
//  User.m
//  CurrencyXchange
//
//  Created by Samer Ghanim on 02/04/2024.
//

#import "User.h"

@implementation User
- (instancetype)init {
    self = [super init];
    if (self) {
        _userID=0;
        _username = @"";
        _firstName=@"";
        _lastName=@"";
        _email=@"";
        _appName=@"";
        _isAdmin=0;
        _lastLogin=@"";
        _createdDate=@"";
        _isValidCredentails=NO;
    }
    return self;
}
-(NSInteger)userID {
    return _userID;
}
-(NSString*)username {
    return _username;
}
-(NSString*)firstName {
    return _firstName;
}
-(NSString*)lastName {
    return _lastName;
}
-(NSString*)_email {
    return _email;
}
-(NSString*)appName {
    return _appName;
}
-(NSInteger)isAdmin {
    return _isAdmin;
}
-(NSString*)_astLogin {
    return _lastLogin;
}
-(NSString*)createdDate {
    return _createdDate;
}
-(BOOL)isValidCredentails {
    return _isValidCredentails;
}
@end
