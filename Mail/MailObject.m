//
//  MailBody.m
//  CurrencyXchange
//
//  Created by Samer Ghanim on 03/04/2024.
//

#import "MailObject.h"
@implementation MailBody
- (instancetype)init {
   self = [super init];
   if (self) {
    _FromName = @"";
    _FromName = @"";
    _ToEmail = @"";
    _ToName = @"";
    _Subject=@"";
    _Body=@"";
    _IsHTMLBody=NO;
    _SMTPServer=@"";
    _SMTPPort=0;
    _SenderEmail=@"";
    _SenderPassword=@"";
    _EnableSSL = false;
   }
   return self;
}
-(NSString*)Username {
    return _Username;
}
-(NSString*)FromEmail {
    return _FromEmail;
}
-(NSString*)FromName {
    return _FromName;
}
-(NSString*)ToEmail {
    return _ToEmail;
}
-(NSString*)ToName {
    return _ToName;
}
-(NSString*)Subject {
    return _Subject;
}
-(NSString*)Body {
    return _Body;
}
-(BOOL)IsHTMLBody {
    return _IsHTMLBody;
}
-(NSString*)SMTPServer {
    return _SMTPServer;
}
-(NSInteger)SMTPPort {
    return _SMTPPort;
}
-(NSString*)SenderEmail {
    return _SenderEmail;
}
-(NSString*)SenderPassword {
    return _SenderPassword;
}
-(BOOL)EnableSSL {
    return _EnableSSL;
}
@end
