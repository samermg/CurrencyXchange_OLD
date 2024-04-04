//
//  MailBody.h
//  CurrencyXchange
//
//  Created by Samer Ghanim on 03/04/2024.
//

#import <Foundation/Foundation.h>
@class MailBody;
@class MailServer;

NS_ASSUME_NONNULL_BEGIN

#pragma mark - Object interfaces

@interface MailBody : NSObject
@property (nonatomic, copy)   NSString *From;
@property (nonatomic, copy)   NSString *To;
@property (nonatomic, copy)   NSString *Subject;
@property (nonatomic, copy)   NSString *Body;
@property (nonatomic, assign) BOOL IsHTMLBody;
@property (nonatomic, strong) MailServer *Server;
@end

@interface MailServer : NSObject
@property (nonatomic, copy)   NSString *SMTPServer;
@property (nonatomic, assign) NSInteger SMTPPort;
@property (nonatomic, copy)   NSString *SenderEmail;
@property (nonatomic, copy)   NSString *SenderPassword;
@end

NS_ASSUME_NONNULL_END

