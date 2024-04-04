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
      _From = @"";
       _To = @"";
       _Subject=@"";
       _Body=@"";
       _IsHTMLBody=NO;
       _Server = [[MailServer alloc]init];
   }
   return self;
}
-(NSString*)From {
    return _From;
}
-(NSString*)To {
    return _To;
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
-(MailServer*)Server {
    return _Server;
}
@end

@implementation MailServer
- (instancetype)init {
   self = [super init];
   if (self) {
       _SMTPServer=@"";
       _SMTPPort=0;
       _SenderEmail=@"";
       _SenderPassword=@"";
   }
   return self;
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
@end
