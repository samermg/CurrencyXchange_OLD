//
//  Dragons.h
//  PhotoGallery
//
//  Created by Samer Ghanim on 1/19/15.
//  Copyright (c) 2014 Cyber Web Technology. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Definitions.h"
#import <AudioToolbox/AudioServices.h>
#ifdef __IPHONE_8_0
#define GregorianCalendar NSCalendarIdentifierGregorian
#else
#define GregorianCalendar NSGregorianCalendar
#endif
@interface Helper : NSObject
typedef enum {
        GET,
        POST
    } HttpMethod;
typedef enum {
        FromCurrency,
        ToCurrency
    } CurrencyCode;
+ (UIColor *)colorWithHexString:(NSString *)stringToConvert;
// Dictionary Static Methods
+(void) saveUserDefaultsForBooleanKey:(BOOL)value forKey:(NSString *)key;
+(BOOL) loadUserDefaultsForBooleanKey:(NSString *)key;
+(void) saveDateToUserDefaults:(NSDate *)date forKey:(NSString *)key;
+(void) saveUserDefaultsForKey:(NSString *)key;
+(NSDictionary *) loadUserDefaultsForKey:(NSString *)key;
+(id) loadObjectFromUserDefaultsForKey:(int)itemIndex withKey:(NSString *)key;
+(void) saveObjectFromUserDefaultsForIndex:(int)itemIndex withValue:(NSString *)value withKey:(NSString *)key;
+(void) removeObjectFromUserDefaults:(NSString *)key;
+(void) removeFromUserDefaultsWithObject:(id)key;
+(id) loadObjectFromUserDefaultsForKey:(NSString *)key;
+(void) saveObjectToUserDefaults:(id)object forKey:(NSString *)key;
+(NSDate *) loadLastUpdatedDateFromUserDefaultsForKey:(NSString *)key;
+(BOOL) loadUserDefaultsBooleanValueForKey:(NSString *)key;
+(void) setUserDefaultsBooleanValue:(BOOL)value forKey:(NSString *)key;
+(void) setUserDefaultsFloatValue:(float)floatValue forKey:(NSString *)key;
+(float) loadUserDefaultsFloatValueForKey:(NSString *)key;
+(void)setUserDefaultsIntValue:(int)intValue forKey:(NSString *)key;
+(int)loadUserDefaultsIntValueForKey:(NSString *)key;
+(NSString*)doubleToString:(double)number withPrecision:(int)precision;
//Date
+(NSString *)formatDate:(NSDate *)dateToFormat formatString:(NSString *)format twelveHourEnabled:(BOOL)enabled showTimeZone:(BOOL)showZone;
+(NSString *)timeFormatted:(int)totalSeconds forElapsed:(BOOL)isElapsed;
+(NSDate *)convertStringToDate:(NSString*)dateString;
+(NSString*)englishToArabicDate:(NSString*)date;
+(NSInteger)getDayFromDate:(NSDate*)date;
+(NSInteger)getMonthFromDate:(NSDate*)date;
+(NSInteger)getYearFromDate:(NSDate*)date;
+(NSDate*)convertTOUTCDate:(NSString*)timeString;
+(NSString*)translateFromWindowsTimezone: (NSString*) timezoneName;

//File Systems
+(NSString*)bundleID;
+ (NSString *)getPathFromResourcesForFile:(NSString*)fileName;
+(NSString *)getPathDirectory:(NSString *)file;
+(NSString*) appDataPath: (NSString *)fileName forExtention:(NSString *)extention;
+(NSString*) applicationDocumentsDirectory;
+(NSString*)getAppCacheFolder;
+(NSURL*)getAudioFileURLFor:(NSString*)fileName andExtention:(NSString*)extention;

+ (void)doOnce:(NSString *)PathfileToCopy forFile:(NSString*)fileName;
+(void)saveData:(NSDictionary*)data inFile:(NSString*) fileName;
+(void)saveMessageData:(NSMutableArray*)data inFile:(NSString*) fileName;
+(NSDictionary*)loadDataFromPlist;
//Color
+(UIColor *)getUIColorFromHexString:(NSString *)hexStr alpha:(CGFloat)alpha;
+(unsigned int)intFromHexString:(NSString *)hexStr;
+(NSString *)hexStringFromColor:(UIColor *)color;
+(UIColor*)getRandomColor;
+(UIColor*)getButtonBkColor:(int)index colorName:(NSString **)colorName textColor:(UIColor**)textColor tableViewHeaderBackgroundColor:(UIColor**)headerColor tableViewHeaderTextColor:(UIColor**)headerTextColor;

//Strings
+(NSString*)appName;
+(NSString*)deviceName;
+(NSString *)appVersion;
+(NSString*)iosVersion;
+(NSString*)randomStringWithLength:(int) len;
+ (NSString*)formatValue:(int)value forDigits:(int)zeros;
+ (NSString*)englishToArabicNumbers:(NSString*)numericString;
+ (NSString*)arabicToEnglishNumbers:(NSString*)numericString;
+ (NSString *)convertToHiniNumber:(NSString *)numberToConver;
+ (NSString*)prayTimeName:(int)index forLanguage:(int)language; //0 AR 1 EN
+ (NSString*)formatTime:(int)seconds;
//Label
+(CGFloat)calculateHeightForLabel:(UILabel*)label includingText:(NSString*)textAR withFontName:(NSString*)fontName andFontSize:(CGFloat)fontSize;
+ (CGFloat)calculateHeightForTextView:(UITextView*)textView includingText:(NSString*)textAR withFontName:(NSString*)fontName andFontSize:(CGFloat)fontSize;
+ (CGSize)frameForText:(NSString*)text sizeWithFont:(UIFont*)font constrainedToSize:(CGSize)size lineBreakMode:(NSLineBreakMode)lineBreakMode;
+ (UILabel*)changeColorInLable:(UILabel*)label forText:(NSString *)string withColor:(UIColor*)color;

//Calculations
+ (float)convertToCelsius:(int)tempreture;
+ (float)convertToFahrenheit:(int)tempreture;



//Data
+ (NSData *)base64DataFromString: (NSString *)string;
+ (NSArray*)Countries;
+ (NSArray*)Symbols;
@end
