//
//  User.h
//  CurrencyXchange
//
//  Created by Samer Ghanim on 02/04/2024.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface User : NSObject
@property (nonatomic, assign) NSInteger userID;
@property (nonatomic, copy)   NSString *username;
@property (nonatomic, copy)   NSString *firstName;
@property (nonatomic, copy)   NSString *lastName;
@property (nonatomic, copy)   NSString *email;
@property (nonatomic, copy)   NSString *appName;
@property (nonatomic, copy)   NSString *createdDate;
@property (nonatomic, copy)   NSString *lastLogin;
@property (nonatomic, assign) NSInteger isAdmin;
@property (nonatomic, assign) BOOL isValidCredentails;
@end

NS_ASSUME_NONNULL_END
