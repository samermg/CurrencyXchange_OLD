//
//  MailBody.h
//  CurrencyXchange
//
//  Created by Samer Ghanim on 03/04/2024.
//

#import <Foundation/Foundation.h>
@class MailBody;

NS_ASSUME_NONNULL_BEGIN

#pragma mark - Object interfaces
/*
 {
   "username": "samer",
   "fromEmail": "string",
   "fromName": "string",
   "toEmail": "string",
   "toName": "string",
   "subject": "string",
   "body": "string",
   "isHTMLBody": true,
   "smtpServer": "string",
   "smtpPort": 0,
   "senderEmail": "string",
   "senderPassword": "string",
   "enableSSL": true
 }
 */
@interface MailBody : NSObject
@property (nonatomic, copy)   NSString *Username;
@property (nonatomic, copy)   NSString *FromEmail;
@property (nonatomic, copy)   NSString *FromName;
@property (nonatomic, copy)   NSString *ToEmail;
@property (nonatomic, copy)   NSString *ToName;
@property (nonatomic, copy)   NSString *Subject;
@property (nonatomic, copy)   NSString *Body;
@property (nonatomic, assign) BOOL IsHTMLBody;
@property (nonatomic, copy)   NSString *SMTPServer;
@property (nonatomic, assign) NSInteger SMTPPort;
@property (nonatomic, copy)   NSString *SenderEmail;
@property (nonatomic, copy)   NSString *SenderPassword;
@property (nonatomic, assign) BOOL EnableSSL;
@end

NS_ASSUME_NONNULL_END

