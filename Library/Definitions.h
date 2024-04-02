//
//  Definitions.h
//  Dragons
//
//  Created by Samer Ghanim on 1/25/15.
//  Copyright (c) 2015 Cyber Web Technology. All rights reserved.
//

#ifndef Dragons_Definitions_h
#define Dragons_Definitions_h
#define SYSTEM_VERSION_GRATERTHAN_OR_EQUALTO(v)  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedAscending)
#define COUNTRIES_API              @"https://www.cwtjo.org/countries.json"
#define SYMBOLS_API              @"https://www.cwtjo.org/symbols.json"
#define CXChange_API               @"https://v6.exchangerate-api.com/v6"
#define CXChange_KEY               @"7781b567323cc3cb1bb5b036"

#define LOGIN_API                     @"https://webapi.cwtjo.org/restfull/v1/user/login"
#define API_KEY                         @"6CBxzdYcEgNDrRhMbDpkBF7e4d4Kib46dwL9ZE5egiL0iL5Y3dzREUBSUYVUwUkN"
#define READALL                         @"http://www.cwtjo.org/VBNET/APIs/students/rest-api/items/read.php"
#define NOTIFICATION_REG_URL            @"https://webapi.cwtjo.org/restfull/v1/register/device"
#define API_URL                         @"http://cwtapps.com/CFOs/APIs/securedRequest.php"

#define NO_INTERNT                      @"الجهاز غير متصل بشبكة الإنترنت"
#define pListFile                       @"Contacts.plist"
#define plist                           @"Contacts"
#define ROOTVIEW [[[UIApplication sharedApplication] keyWindow] rootViewController]
#define IS_OS_8_OR_LATER ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0)
#define IS_RTL ([[UIApplication sharedApplication] userInterfaceLayoutDirection] == UIUserInterfaceLayoutDirectionRightToLeft)
#define uniqueIdentifier [[[UIDevice currentDevice] identifierForVendor] UUIDString]
#define sendLogPostURL                  @"http://cwtapps.com/dragons/iphone/Craches/dragonsLogCrach.php"
#define GetLocalizedNumber(rtl,num) rtl ? [Dragons englishToArabicNumbers:num] :num;
#define Email_Template(User_Name,Reset_Password_Link,Reset_Password_URL, Expiration_Time)                  [NSString stringWithFormat:@"Dear %@,<br>We received a request to reset the password for your account. To proceed with the password reset, please follow the instructions below:-<br><br>Click on the following link to reset your password:<br><a href='[%@]'>[Password Rest]</a><br><br>If you are unable to click the link above, please copy and paste the following URL into your web browser:<br>%@<br><br><b>Please Note:</b><br>This link will expire in <b>%@<b/>, so please reset your password as soon as possible.<br><br>If you did not request a password reset, please disregard this email. Your account remains secure.<br><br>If you have any questions or need further assistance, please contact our support team at <a href='mailto:currencyXchange@cwtjo.org'>currencyXchange@cwtjo.org</a>.<br><br>Thank you,<br>Cyber Web Technology", User_Name, Reset_Password_Link,Reset_Password_URL, Expiration_Time]
#endif
