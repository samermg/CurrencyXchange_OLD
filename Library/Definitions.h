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

#endif
