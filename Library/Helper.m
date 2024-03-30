//
//  Dragons.m
//  PhotoGallery
//
//  Created by Samer Ghanim on 1/19/15.
//  Copyright (c) 2014 Cyber Web Technology. All rights reserved.
//

#import "Helper.h"
//#import "Reachability.h"
#import "AppDelegate.h"
#define offlineMessage @"Dragons App requires access to the Internet in order to activate. Please make sure your network connection is active and try again"
@interface Helper ()

@end
SystemSoundID completeSound;
@implementation Helper

+ (UIColor *)colorWithHexString:(NSString *)stringToConvert
{
    NSString *noHashString = [stringToConvert stringByReplacingOccurrencesOfString:@"#" withString:@""]; // remove the #
    NSScanner *scanner = [NSScanner scannerWithString:noHashString];
    [scanner setCharactersToBeSkipped:[NSCharacterSet symbolCharacterSet]];
    unsigned hex;
    if (![scanner scanHexInt:&hex]) return nil;
    int r = (hex >> 16) & 0xFF;
    int g = (hex >> 8) & 0xFF;
    int b = (hex) & 0xFF;
    return [UIColor colorWithRed:r / 255.0f green:g / 255.0f blue:b / 255.0f alpha:1.0f];
}
#pragma mark - Dictionary
+(BOOL) loadUserDefaultsForBooleanKey:(NSString *)key {
    NSUserDefaults * userDefaults = [NSUserDefaults standardUserDefaults];
    BOOL value = [userDefaults boolForKey:key];
    return value;
}
+(void) saveDateToUserDefaults:(NSDate *)date forKey:(NSString *)key {
    NSUserDefaults * userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setObject:date forKey:key];
    [userDefaults synchronize];
}

+(void) saveUserDefaultsForKey:(NSString *)key {
    NSUserDefaults * userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults synchronize];
}

+(NSDictionary *) loadUserDefaultsForKey:(NSString *)key {
    NSUserDefaults * userDefaults = [NSUserDefaults standardUserDefaults];
    return [userDefaults dictionaryForKey:key];
}

+(id) loadObjectFromUserDefaultsForKey:(int)itemIndex withKey:(NSString *)key {
    NSUserDefaults * userDefaults = [NSUserDefaults standardUserDefaults];
    NSDictionary *albums = [userDefaults objectForKey:@"albums"];
    NSArray *response = [albums objectForKey:@"response"];
    return [[response objectAtIndex:itemIndex]objectForKey:key];
}

+(void) saveObjectFromUserDefaultsForIndex:(int)itemIndex withValue:(NSString *)value withKey:(NSString *)key {
    NSUserDefaults * userDefaults = [NSUserDefaults standardUserDefaults];
    NSString *indexKey = [NSString stringWithFormat:@"Item %i", itemIndex];
    [[userDefaults valueForKey:indexKey] setValue:value forKey:key];
    [userDefaults synchronize];
    
}

+(void) removeObjectFromUserDefaults:(NSString *)key {
    NSUserDefaults * userDefaults = [NSUserDefaults standardUserDefaults];
    if ([userDefaults objectForKey:key] != nil) {
        [userDefaults removeObjectForKey:key];
        [userDefaults synchronize];
    }
}

+(void) removeFromUserDefaultsWithObject:(id)key {
    NSUserDefaults * userDefaults = [NSUserDefaults standardUserDefaults];
    if ([userDefaults objectForKey:key] != nil) {
        [userDefaults removeObjectForKey:key];
        [userDefaults synchronize];
    }
}

+(id) loadObjectFromUserDefaultsForKey:(NSString *)key {
    NSUserDefaults * userDefaults = [NSUserDefaults standardUserDefaults];
    id data = [userDefaults objectForKey:key];
    return data;
}

+(void) saveObjectToUserDefaults:(id)object forKey:(NSString *)key {
    NSUserDefaults * userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setObject:object forKey:key];
    [userDefaults synchronize];
}
+(NSDate *) loadLastUpdatedDateFromUserDefaultsForKey:(NSString *)key {
    NSUserDefaults * userDefaults = [NSUserDefaults standardUserDefaults];
    return [userDefaults objectForKey:key];
}

-(id) loadObjectFromUserDefaultsForKey:(NSString *)keyValue {
    NSUserDefaults * userDefaults = [NSUserDefaults standardUserDefaults];
    id data = [userDefaults objectForKey:keyValue];
    return data;
}
+(void) saveUserDefaultsForBooleanKey:(BOOL)value forKey:(NSString *)key {
    NSUserDefaults * userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setBool:value forKey:key];
    [userDefaults synchronize];
}
+(BOOL) loadUserDefaultsBooleanValueForKey:(NSString *)key {
    NSUserDefaults * userDefaults = [NSUserDefaults standardUserDefaults];
    BOOL value = [userDefaults boolForKey:key];
    return value;
}

+(void) setUserDefaultsBooleanValue:(BOOL)value forKey:(NSString *)key {
    NSUserDefaults * userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setBool:value forKey:key];
    [userDefaults synchronize];
}
+(void)setUserDefaultsFloatValue:(float)floatValue forKey:(NSString *)key{
    NSUserDefaults * userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setFloat:floatValue forKey:key];
    [userDefaults synchronize];
}
+(void)setUserDefaultsIntValue:(int)intValue forKey:(NSString *)key{
    NSUserDefaults * userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setInteger:intValue forKey:key];
    [userDefaults synchronize];
}
+(float)loadUserDefaultsFloatValueForKey:(NSString *)key{
    NSUserDefaults * userDefaults = [NSUserDefaults standardUserDefaults];
    return [userDefaults floatForKey:key];
}

+(int)loadUserDefaultsIntValueForKey:(NSString *)key{
    NSUserDefaults * userDefaults = [NSUserDefaults standardUserDefaults];
    return (int)[userDefaults integerForKey:key];
}
#pragma mark - Date Format
#pragma Format Date Ex. @"dd/MM/yyyy HH:mm"
#pragma Show time in 24 hours; set twelveHourEnabled:YES
#pragma Show Time Zone AM or PM set showTimeZone:YES
+ (NSString *)formatDate:(NSDate *)dateToFormat formatString:(NSString *)format twelveHourEnabled:(BOOL)enabled showTimeZone:(BOOL)showZone {
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    
    
    //Show Time in 12 / 24 hours mode
    if (enabled) {
        format = [format stringByReplacingOccurrencesOfString:@"HH:" withString:@"hh:"];
    } else {
        format = [format stringByReplacingOccurrencesOfString:@"hh:" withString:@"HH:"];
    }
    
    //Include AM / PM in format // Date formatString should not include 'a'
    if ([format rangeOfString:@" a"].location != NSNotFound) {//Found
        if (!showZone)
            format = [format stringByReplacingOccurrencesOfString:@" a" withString:@""];
    } else {
        if (showZone)
            format = [format stringByAppendingString:@" a"];
    }
    //NSLog(@"Date: %@",format);
    [formatter setDateFormat:format];
    
    //NSLog(@"Date: %@",[formatter stringFromDate:dateToFormat]);
    return [formatter stringFromDate:dateToFormat];
}
+ (NSString *)timeFormatted:(int)totalSeconds forElapsed:(BOOL)isElapsed{
    
    int seconds = totalSeconds % 60;
    int minutes = (totalSeconds / 60) % 60;
    int hours = totalSeconds / 3600;
    int day = totalSeconds / (60 * 60 * 24);;
    
    if (!isElapsed)
        return [NSString stringWithFormat:@"%02d:%02d:%02d",hours, minutes, seconds];
    else
        if (day>0)
            return [NSString stringWithFormat:@"%03d %02d:%02d:%02d",day, hours, minutes, seconds];
        else
            return [NSString stringWithFormat:@"%02d:%02d", minutes, seconds];
}
+ (NSDate *)convertStringToDate:(NSString*)dateString {
    //"2015-02-12 09:40:20 +0000";
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"yyyy-MM-dd HH:mm:ss Z"];
    return [dateFormat dateFromString:dateString];
}
+(NSString*)englishToArabicDate:(NSString *)date {
    NSArray*d = [[NSArray alloc]initWithArray:[date componentsSeparatedByString:@"-"]];
    
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"dd/MM/yyyy"];
    return [Helper englishToArabicNumbers:[NSString stringWithFormat:@"%@/%@/%@", d[0],d[1],d[2]]];
}
+(NSInteger)getDayFromDate:(NSDate*)date {
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *components = [calendar components: NSCalendarUnitDay fromDate:date];
    return  [components day];
}
+(NSInteger)getMonthFromDate:(NSDate *)date {
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *components = [calendar components: NSCalendarUnitMonth fromDate:date];
    return  [components month];
}

+(NSInteger)getYearFromDate:(NSDate*)date{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *components = [calendar components: NSCalendarUnitYear fromDate:date];
    return  [components year];
}
+ (NSString *)convertToHiniNumber:(NSString *)numberToConver {
    NSDecimalNumber *someNumber = [NSDecimalNumber decimalNumberWithString:numberToConver];
    NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
    NSLocale *gbLocale = [[NSLocale alloc] initWithLocaleIdentifier:@"ar"];
    [formatter setLocale:gbLocale];
    NSLog(@"%@", [formatter stringFromNumber:someNumber]); // Prints in Arabic
    return [NSString stringWithFormat:@"%@",someNumber];
}
+ (NSString*)prayTimeName:(int)index forLanguage:(int)language {
    NSString *prayNameEN, *prayNameAR;
    switch (index) {
        case 0:
            prayNameEN = @"Fajir";
            prayNameAR = @"الفجر";
            break;
        case 1:
            prayNameEN = @"Sunrise";
            prayNameAR = @"الشروق";
            break;
        case 2:
            prayNameEN = @"Zuhur";
            prayNameAR = @"الظهر";
            break;
        case 3:
            prayNameEN = @"Asr";
            prayNameAR = @"العصر";
            break;
        case 4:
            prayNameEN = @"Maghrib";
            prayNameAR = @"المغرب";
            break;
        case 6:
            prayNameEN = @"Isha";
            prayNameAR = @"العشاء";
            break;
            
        default:
            prayNameEN = nil;
            prayNameAR = nil;
            break;
    }
    return (language == 0) ? prayNameAR : prayNameEN;
}

#pragma mark - File Systems

+ (NSString *)getPathFromResourcesForFile:(NSString*)fileName {
    
    NSString *file = [[NSBundle mainBundle] pathForResource:fileName ofType:@"plist"];
    
    if (file) {
        return file;
    } else {
        return nil;
    }
}
+ (NSString *)getPathDirectory:(NSString *)file {
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *plistPath = [[paths objectAtIndex:0] stringByAppendingPathComponent:file];
    NSLog(@"%@", plistPath);
    return plistPath;
}
+ (NSString *) appDataPath: (NSString *)fileName forExtention:(NSString *)extention {
    NSString* path = [[NSBundle mainBundle] pathForResource:fileName ofType:extention];
    
    //Check if file exists
    NSFileManager *fileManager = [NSFileManager defaultManager];
    BOOL fileExist = [fileManager fileExistsAtPath:path];
    
    if (fileExist) {
        return path;
    } else {
        NSLog(@"File does not exist");
        return nil;
    }
}
+ (NSString*)getAppCacheFolder{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
    NSURL *cachesDirectory = [NSURL fileURLWithPath:[paths objectAtIndex:0]];
    
    return  [cachesDirectory path];

}
+ (NSString *) applicationDocumentsDirectory
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *basePath = ([paths count] > 0) ? [paths objectAtIndex:0] : nil;
    return basePath;
}
+ (void)saveData:(NSDictionary*)data inFile:(NSString*) fileName {
    // Open the plist from the filesystem.
    NSString* plistFilePath = [self getPathDirectory:fileName];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    if ([fileManager fileExistsAtPath:plistFilePath] == YES) {
        //This is not writing to PLIST file
//        BOOL success = [data writeToFile:plistFilePath atomically:YES];
//        NSLog(@"Success = %d", success);
        [data writeToFile:plistFilePath atomically:YES];
        NSString* today = [self formatDate:[NSDate date] formatString:@"yyyy/MM/dd" twelveHourEnabled:YES showTimeZone:NO];
        [Helper saveObjectToUserDefaults:today forKey:@"LastUpdate"];
    }
    
}
+ (void)doOnce:(NSString *)PathfileToCopy forFile:(NSString*)fileName {
    
    //Set Default Athan Days
    [self setUserDefaultsIntValue:(int)2 forKey:@"Athan"];
    
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSError *error;
    
    BOOL success = [fileManager fileExistsAtPath:PathfileToCopy];
    if(!success){
        //file does not exist. So look into mainBundle
        NSString *defaultPath = [self getPathFromResourcesForFile:pListFile];
        if ([fileManager fileExistsAtPath:PathfileToCopy] == NO) {
            [fileManager copyItemAtPath:defaultPath toPath:PathfileToCopy error:&error];
        }
        //NSLog(@"%@", [error description]);
    }
}

+ (void)saveMessageData:(NSMutableArray*)data inFile:(NSString*) fileName {
    // Open the plist from the filesystem.
    NSString* plistFilePath = [self getPathDirectory:fileName];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    if ([fileManager fileExistsAtPath:plistFilePath] == YES) {
        //This is not writing to PLIST file
        BOOL success = [data writeToFile:plistFilePath atomically:YES];
        NSLog(@"Success = %d", success);
    }
    
}
+ (NSDictionary*)loadDataFromPlist {
    NSString *dataPath = [[NSBundle mainBundle] pathForResource:plist ofType:@"plist"];
    NSDictionary*data = [NSDictionary dictionaryWithContentsOfFile:dataPath];
    return data;
}

#pragma mark - Hexa Color Creation
+ (UIColor *)getUIColorFromHexString:(NSString *)hexStr alpha:(CGFloat)alpha
{
    // Convert hex string to an integer
    unsigned int hexint = [self intFromHexString:hexStr];
    
    // Create color object, specifying alpha as well
    UIColor *color =
    [UIColor colorWithRed:((CGFloat) ((hexint & 0xFF0000) >> 16))/255
                    green:((CGFloat) ((hexint & 0xFF00) >> 8))/255
                     blue:((CGFloat) (hexint & 0xFF))/255
                    alpha:alpha];
    
    return color;
}
+ (unsigned int)intFromHexString:(NSString *)hexStr
{
    unsigned int hexInt = 0;
    
    // Create scanner
    NSScanner *scanner = [NSScanner scannerWithString:hexStr];
    
    // Tell scanner to skip the # character
    [scanner setCharactersToBeSkipped:[NSCharacterSet characterSetWithCharactersInString:@"#"]];
    
    // Scan hex value
    [scanner scanHexInt:&hexInt];
    
    return hexInt;
}
+ (NSString *)hexStringFromColor:(UIColor *)color {
    const CGFloat *components = CGColorGetComponents(color.CGColor);
    
    CGFloat r = components[0];
    CGFloat g = components[1];
    CGFloat b = components[2];
    
    return [NSString stringWithFormat:@"#%02lX%02lX%02lX",
            lroundf(r * 255),
            lroundf(g * 255),
            lroundf(b * 255)];
}
+ (UIColor*)getRandomColor {
    CGFloat redLevel    = rand() / (float) RAND_MAX;
    CGFloat greenLevel  = rand() / (float) RAND_MAX;
    CGFloat blueLevel   = rand() / (float) RAND_MAX;
    
    return [UIColor colorWithRed: redLevel green: greenLevel blue: blueLevel alpha: 1.0];
}
+ (UIColor*)getButtonBkColor:(int)index colorName:(NSString *__autoreleasing *)colorName textColor:(UIColor *__autoreleasing *)textColor tableViewHeaderBackgroundColor:(UIColor**)headerColor tableViewHeaderTextColor:(UIColor**)headerTextColor {
    UIColor* color=nil;
    switch (index) {
        case 0:
            color           = [UIColor lightGrayColor];
            *colorName      = @"رمادي";
            *textColor      = [UIColor whiteColor];
            *headerColor    = [UIColor blackColor];
            *headerTextColor= [UIColor whiteColor];
            break;
        case 1:
            color           = [UIColor redColor];
            *colorName      = @"أحمر";
            *textColor      = [UIColor whiteColor];
            *headerColor    = [UIColor blackColor];
            *headerTextColor= [UIColor whiteColor];
            break;
        case 2:
            color           =  [UIColor blueColor];
            *colorName      = @"أزرق";
            *textColor      = [UIColor whiteColor];
            *headerColor    = [UIColor blackColor];
            *headerTextColor= [UIColor whiteColor];
            break;
        case 3:
            color           = [UIColor whiteColor];
            *colorName      = @"أبيض";
            *textColor      = [UIColor blackColor];
            *headerColor    = [UIColor blackColor];
            *headerTextColor= [UIColor whiteColor];
            break;
        case 4:
            color           = [UIColor yellowColor];
            *colorName      = @"أصفر";
            *textColor      = [UIColor blackColor];
            *headerColor    = [UIColor blackColor];
            *headerTextColor= [UIColor whiteColor];
            break;
        case 5:
            color           = [UIColor orangeColor];
            *colorName      = @"برتقالي";
            *textColor      = [UIColor blackColor];
            *headerColor    = [UIColor blackColor];
            *headerTextColor= [UIColor whiteColor];
            break;
        case 6:
            color           = [UIColor greenColor];
            *colorName      = @"أخضر";
            *textColor      = [UIColor blackColor];
            *headerColor    = [UIColor blackColor];
            *headerTextColor= [UIColor whiteColor];
            break;
        case 7:
            color           = [UIColor purpleColor];
            *colorName      = @"أرجواني";
            *textColor      = [UIColor whiteColor];
            *headerColor    = [UIColor blackColor];
            *headerTextColor= [UIColor whiteColor];
            break;
        case 8:
            color           = [UIColor brownColor];
            *colorName      = @"بني";
            *textColor      = [UIColor whiteColor];
            *headerColor    = [UIColor blackColor];
            *headerTextColor= [UIColor whiteColor];
            break;
        case 9:
            color           = [UIColor blackColor];
            *colorName      = @"أسود";
            *textColor      = [UIColor whiteColor];
            *headerColor    = [self getUIColorFromHexString:@"3B3131" alpha:1.0f];//[UIColor darkGrayColor];
            *headerTextColor= [UIColor whiteColor];
            break;
    }
    return color;
}
#pragma mark - Strings
+(NSString*)appName {
    NSDictionary *bundleInfo = [[NSBundle mainBundle] infoDictionary];
    return [bundleInfo objectForKey:@"CFBundleDisplayName"];
}
+(NSString *)deviceName {
        struct utsname systemInfo;
        uname(&systemInfo);
    
        return [NSString stringWithCString:systemInfo.machine
                                  encoding:NSUTF8StringEncoding];
}
+(NSString *)appVersion {
    return [NSString stringWithFormat:@"%@", [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"]];
}

+(NSString*)iosVersion {
    return [[UIDevice currentDevice] systemVersion];
}

+(NSString *) randomStringWithLength: (int) len {
    NSString* letters = @"0123456789";
    NSMutableString *randomString = [NSMutableString stringWithCapacity: len];

    for (int i=0; i<len; i++) {
         [randomString appendFormat: @"%C", [letters characterAtIndex: arc4random_uniform((unsigned)[letters length])]];
    }

    return randomString;
}
+ (NSString *)formatValue:(int)value forDigits:(int)zeros {
    NSString *format = [NSString stringWithFormat:@"%%0%dd", zeros];
    return [NSString stringWithFormat:format,value];
}
+ (NSString*)englishToArabicNumbers:(NSString*)numericString {
    NSMutableString *s = [NSMutableString stringWithString:numericString];
    NSString *arabic = @"0123456789";
    NSString *western = @"٠١٢٣٤٥٦٧٨٩";
    for (uint i = 0; i<arabic.length; i++) {
        NSString *a = [arabic substringWithRange:NSMakeRange(i, 1)];
        NSString *w = [western substringWithRange:NSMakeRange(i, 1)];
        [s replaceOccurrencesOfString:a withString:w
                              options:NSCaseInsensitiveSearch
                                range:NSMakeRange(0, s.length)];
    }
    return [NSString stringWithString:s];
}
+ (NSString*)arabicToEnglishNumbers:(NSString*)numericString {
    NSMutableString *s = [NSMutableString stringWithString:numericString];
    NSString *arabic = @"٠١٢٣٤٥٦٧٨٩";
    NSString *western = @"0123456789";
    for (uint i = 0; i<arabic.length; i++) {
        NSString *a = [arabic substringWithRange:NSMakeRange(i, 1)];
        NSString *w = [western substringWithRange:NSMakeRange(i, 1)];
        [s replaceOccurrencesOfString:a withString:w
                              options:NSCaseInsensitiveSearch
                                range:NSMakeRange(0, s.length)];
    }
    return [NSString stringWithString:s];
}
+(NSString*)bundleID {
    return [[NSBundle mainBundle] bundleIdentifier];
}
+(NSURL*)getAudioFileURLFor:(NSString *)fileName andExtention:(NSString *)extention {
    if (fileName!=nil && extention!=nil) {
        // Do any additional setup after loading the view, typically from a nib.
        NSURL* url = [[NSBundle mainBundle] URLForResource:fileName withExtension:@"caf"];
        NSAssert(url, @"URL is valid.");
        return url;
    } else {
        return nil;
    }
}
+(NSString*)formatTime:(int)totalSeconds {
    if (totalSeconds != 0) {
        int seconds = totalSeconds % 60;
        int minutes = (totalSeconds / 60) % 60;
        int hours = totalSeconds / 3600;
        NSString* time = nil;
        if (hours>0) {
            time = [NSString stringWithFormat:@"%02d:%02d:%02d",hours, minutes, seconds];
        } else {
            time = [NSString stringWithFormat:@"%02d:%02d", minutes, seconds];
        }
        return time;
    } else {
        return @"00:00:00";
    }
}
+(NSString*)doubleToString:(double)number withPrecision:(int)precision {
    NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
    formatter.minimumFractionDigits = precision;
    formatter.maximumFractionDigits = precision;
    return [formatter stringFromNumber:@(number)];
}
+ (NSDate*)convertTOUTCDate:(NSString*)timeString {
    NSDate* prayDateForCalculation = [NSDate date];
    NSCalendar *calendar = [NSCalendar autoupdatingCurrentCalendar];
    
    // set components for time 7:00 a.m.
    NSDateFormatter* dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setTimeZone:[NSTimeZone timeZoneWithAbbreviation:@"UTC"]]; // Prevent adjustment to user's local time zone.
    [dateFormatter setDateFormat:@"yyyy-MM-dd'T'HH:mm:SS.SSS'Z'"];
    NSString* dateTimeInIsoFormatForZuluTimeZone = [dateFormatter stringFromDate:prayDateForCalculation];
    NSDate *curr=[dateFormatter dateFromString:dateTimeInIsoFormatForZuluTimeZone];
    NSDateComponents *componentsForFireDate = [calendar components:(NSCalendarUnitDay | NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond ) fromDate: curr];
    
    NSString* amPm      = [[timeString componentsSeparatedByString:@" "] objectAtIndex:1];
    NSArray* times      = [timeString componentsSeparatedByString:@":"];
    NSInteger hour      = [[times objectAtIndex:0] integerValue];
    NSInteger minute    = [[times objectAtIndex:1] integerValue];
    if ([amPm isEqualToString:@"pm"]) {
        hour+=12;
    }
    
    [componentsForFireDate setHour:hour];
    [componentsForFireDate setMinute:minute];
    [componentsForFireDate setSecond:0];
    
    return [calendar dateFromComponents:componentsForFireDate];
}
+ (NSString*) translateFromWindowsTimezone: (NSString*) timezoneName {
    NSDictionary *timezoneDictionary = [NSDictionary dictionaryWithObjectsAndKeys:
                                        @"Australia/Darwin", @"AUS Central Standard Time",
                                        @"Asia/Kabul", @"Afghanistan Standard Time",
                                        @"America/Anchorage", @"Alaskan Standard Time",
                                        @"Asia/Riyadh", @"Arab Standard Time",
                                        @"Asia/Baghdad", @"Arabic Standard Time",
                                        @"America/Buenos_Aires", @"Argentina Standard Time",
                                        @"America/Halifax", @"Atlantic Standard Time",
                                        @"Asia/Baku", @"Azerbaijan Standard Time",
                                        @"Atlantic/Azores",@"Azores Standard Time",
                                        @"America/Bahia", @"Bahia Standard Time",
                                        @"Asia/Dhaka", @"Bangladesh Standard Time",
                                        @"America/Regina", @"Canada Central Standard Time",
                                        @"Atlantic/Cape_Verde", @"Cape Verde Standard Time",
                                        @"Asia/Yerevan", @"Caucasus Standard Time",
                                        @"Australia/Adelaide", @"Cen. Australia Standard Time",
                                        @"America/Guatemala", @"Central America Standard Time",
                                        @"Asia/Almaty", @"Central Asia Standard Time",
                                        @"America/Cuiaba", @"Central Brazilian Standard Time",
                                        @"Europe/Budapest", @"Central Europe Standard Time",
                                        @"Europe/Warsaw", @"Central European Standard Time",
                                        @"Pacific/Guadalcanal", @"Central Pacific Standard Time",
                                        @"America/Chicago", @"Central Standard Time",
                                        @"America/Mexico_City", @"Central Standard Time (Mexico)",
                                        @"Asia/Shanghai", @"China Standard Time",
                                        @"Etc/GMT+12", @"Dateline Standard Time",
                                        @"Africa/Nairobi", @"E. Africa Standard Time",
                                        @"Australia/Brisbane", @"E. Australia Standard Time",
                                        @"Asia/Nicosia", @"E. Europe Standard Time",
                                        @"America/Sao_Paulo", @"E. South America Standard Time",
                                        @"America/New_York", @"Eastern Standard Time",
                                        @"Africa/Cairo", @"Egypt Standard Time",
                                        @"Asia/Yekaterinburg", @"Ekaterinburg Standard Time",
                                        @"Europe/Kiev", @"FLE Standard Time",
                                        @"Pacific/Fiji", @"Fiji Standard Time",
                                        @"Europe/London", @"GMT Standard Time",
                                        @"Europe/Bucharest", @"GTB Standard Time",
                                        @"Asia/Tbilisi", @"Georgian Standard Time",
                                        @"America/Godthab", @"Greenland Standard Time",
                                        @"Atlantic/Reykjavik", @"Greenwich Standard Time",
                                        @"Pacific/Honolulu", @"Hawaiian Standard Time",
                                        @"Asia/Calcutta", @"India Standard Time",
                                        @"Asia/Tehran", @"Iran Standard Time",
                                        @"Asia/Jerusalem", @"Israel Standard Time",
                                        @"Asia/Amman", @"Jordan Standard Time",
                                        @"Europe/Kaliningrad", @"Kaliningrad Standard Time",
                                        @"Asia/Seoul", @"Korea Standard Time",
                                        @"Indian/Mauritius", @"Mauritius Standard Time",
                                        @"Asia/Beirut", @"Middle East Standard Time",
                                        @"America/Montevideo", @"Montevideo Standard Time",
                                        @"Africa/Casablanca", @"Morocco Standard Time",
                                        @"America/Denver", @"Mountain Standard Time",
                                        @"America/Chihuahua", @"Mountain Standard Time (Mexico)",
                                        @"Asia/Rangoon", @"Myanmar Standard Time",
                                        @"Asia/Novosibirsk", @"N. Central Asia Standard Time",
                                        @"Africa/Windhoek", @"Namibia Standard Time",
                                        @"Asia/Katmandu", @"Nepal Standard Time",
                                        @"Pacific/Auckland", @"New Zealand Standard Time",
                                        @"America/St_Johns", @"Newfoundland Standard Time",
                                        @"Asia/Irkutsk", @"North Asia East Standard Time",
                                        @"Asia/Krasnoyarsk", @"North Asia Standard Time",
                                        @"America/Santiago", @"Pacific SA Standard Time",
                                        @"America/Los_Angeles", @"Pacific Standard Time",
                                        @"America/Santa_Isabel", @"Pacific Standard Time (Mexico)",
                                        @"Asia/Karachi", @"Pakistan Standard Time",
                                        @"America/Asuncion", @"Paraguay Standard Time",
                                        @"Europe/Paris", @"Romance Standard Time",
                                        @"Europe/Moscow", @"Russian Standard Time",
                                        @"America/Cayenne", @"SA Eastern Standard Time",
                                        @"America/Bogota", @"SA Pacific Standard Time",
                                        @"America/La_Paz", @"SA Western Standard Time",
                                        @"Asia/Bangkok", @"SE Asia Standard Time",
                                        @"Pacific/Apia", @"Samoa Standard Time",
                                        @"Asia/Singapore", @"Singapore Standard Time",
                                        @"Africa/Johannesburg", @"South Africa Standard Time",
                                        @"Asia/Colombo", @"Sri Lanka Standard Time",
                                        @"Asia/Damascus", @"Syria Standard Time",
                                        @"Asia/Taipei", @"Taipei Standard Time",
                                        @"Australia/Hobart", @"Tasmania Standard Time",
                                        @"Asia/Tokyo", @"Tokyo Standard Time",
                                        @"Pacific/Tongatapu", @"Tonga Standard Time",
                                        @"Europe/Istanbul", @"Turkey Standard Time",
                                        @"America/Indianapolis", @"US Eastern Standard Time",
                                        @"America/Phoenix", @"US Mountain Standard Time",
                                        @"Etc/GMT", @"UTC",
                                        @"Etc/GMT-12", @"UTC+12",
                                        @"Etc/GMT+2", @"UTC-02",
                                        @"Etc/GMT+11", @"UTC-11",
                                        @"Asia/Ulaanbaatar", @"Ulaanbaatar Standard Time",
                                        @"America/Caracas", @"Venezuela Standard Time",
                                        @"Asia/Vladivostok", @"Vladivostok Standard Time",
                                        @"Australia/Perth", @"W. Australia Standard Time",
                                        @"Africa/Lagos", @"W. Central Africa Standard Time",
                                        @"Europe/Berlin", @"W. Europe Standard Time",
                                        @"Asia/Tashkent", @"West Asia Standard Time",
                                        @"Pacific/Port_Moresby", @"West Pacific Standard Time",
                                        @"Asia/Yakutsk", @"Yakutsk Standard Time", nil];
    return [timezoneDictionary objectForKey:timezoneName];
}
#pragma mark - Label
+ (UILabel*)changeColorInLable:(UILabel*)label forText:(NSString *)string withColor:(UIColor*)color {

    NSMutableAttributedString *relationtext = [[NSMutableAttributedString alloc] initWithAttributedString: label.attributedText];
    NSRange range = [label.text rangeOfString:string];
    if (range.location != NSNotFound) {
        [relationtext addAttribute:NSForegroundColorAttributeName value:color                                 range:NSMakeRange(range.location, [string length])];
            [label setAttributedText: relationtext];
        }
    return label;
}
+ (CGFloat)calculateHeightForLabel:(UILabel*)label includingText:(NSString*)textAR withFontName:(NSString*)fontName andFontSize:(CGFloat)fontSize {
    NSMutableParagraphStyle *paragraphStyleAR;
    paragraphStyleAR = [[NSMutableParagraphStyle alloc] init];
    
    paragraphStyleAR.lineBreakMode = NSLineBreakByWordWrapping;
    paragraphStyleAR.alignment = NSTextAlignmentRight;
    paragraphStyleAR.lineSpacing = 1;
    
    
    NSDictionary *attributes = @{NSFontAttributeName: [UIFont fontWithName:fontName size:fontSize], NSParagraphStyleAttributeName:paragraphStyleAR};
    
    [label setText: textAR];
    [label setFont:[UIFont fontWithName:fontName size:fontSize]];
    CGRect rect = [textAR boundingRectWithSize:CGSizeMake(label.frame.size.width, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:attributes context:nil];
    
    return rect.size.height;
}
+ (CGFloat)calculateHeightForTextView:(UITextView*)textView includingText:(NSString*)textAR withFontName:(NSString*)fontName andFontSize:(CGFloat)fontSize {
        NSMutableParagraphStyle *paragraphStyleAR;
        paragraphStyleAR = [[NSMutableParagraphStyle alloc] init];
        
        paragraphStyleAR.lineBreakMode = NSLineBreakByWordWrapping;
        paragraphStyleAR.alignment = NSTextAlignmentRight;
        paragraphStyleAR.lineSpacing = 1;
        
        
        NSDictionary *attributes = @{NSFontAttributeName: [UIFont fontWithName:fontName size:fontSize], NSParagraphStyleAttributeName:paragraphStyleAR};
        
        [textView setText: textAR];
        [textView setFont:[UIFont fontWithName:fontName size:fontSize]];
        CGRect rect = [textAR boundingRectWithSize:CGSizeMake(textView.frame.size.width, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:attributes context:nil];
        
        return rect.size.height;
}
+ (CGSize)frameForText:(NSString*)text sizeWithFont:(UIFont*)font constrainedToSize:(CGSize)size lineBreakMode:(NSLineBreakMode)lineBreakMode  {
    
    NSMutableParagraphStyle * paragraphStyle = [[NSMutableParagraphStyle defaultParagraphStyle] mutableCopy];
    paragraphStyle.lineBreakMode = lineBreakMode;
    
    NSDictionary * attributes = @{NSFontAttributeName:font,
                                  NSParagraphStyleAttributeName:paragraphStyle
                                  };
    
    CGRect textRect = [text boundingRectWithSize:size
                                         options:NSStringDrawingUsesLineFragmentOrigin
                                      attributes:attributes
                                         context:nil];
    
    //Contains both width & height ... Needed: The height
    return textRect.size;
}

#pragma mark - Calculations
+ (float)convertToCelsius:(int)tempreture {
    //Celsius is (fahrenheit - 32) / 1.8
    return (tempreture-32) / 1.8;
}
+ (float)convertToFahrenheit:(int)tempreture {
    //Celsius is (fahrenheit - 32) / 1.8
    return (tempreture*1.8) + 32;
}


+ (NSData *)base64DataFromString: (NSString *)string
{
    unsigned long ixtext, lentext;
    unsigned char ch, inbuf[4], outbuf[3];
    short i, ixinbuf;
    Boolean flignore, flendtext = false;
    const unsigned char *tempcstring;
    NSMutableData *theData;
    
    if (string == nil)
    {
        return [NSData data];
    }
    
    ixtext = 0;
    
    tempcstring = (const unsigned char *)[string UTF8String];
    
    lentext = [string length];
    
    theData = [NSMutableData dataWithCapacity: lentext];
    
    ixinbuf = 0;
    
    while (true)
    {
        if (ixtext >= lentext)
        {
            break;
        }
        
        ch = tempcstring [ixtext++];
        
        flignore = false;
        
        if ((ch >= 'A') && (ch <= 'Z'))
        {
            ch = ch - 'A';
        }
        else if ((ch >= 'a') && (ch <= 'z'))
        {
            ch = ch - 'a' + 26;
        }
        else if ((ch >= '0') && (ch <= '9'))
        {
            ch = ch - '0' + 52;
        }
        else if (ch == '+')
        {
            ch = 62;
        }
        else if (ch == '=')
        {
            flendtext = true;
        }
        else if (ch == '/')
        {
            ch = 63;
        }
        else
        {
            flignore = true;
        }
        
        if (!flignore)
        {
            short ctcharsinbuf = 3;
            Boolean flbreak = false;
            
            if (flendtext)
            {
                if (ixinbuf == 0)
                {
                    break;
                }
                
                if ((ixinbuf == 1) || (ixinbuf == 2))
                {
                    ctcharsinbuf = 1;
                }
                else
                {
                    ctcharsinbuf = 2;
                }
                
                ixinbuf = 3;
                
                flbreak = true;
            }
            
            inbuf [ixinbuf++] = ch;
            
            if (ixinbuf == 4)
            {
                ixinbuf = 0;
                
                outbuf[0] = (inbuf[0] << 2) | ((inbuf[1] & 0x30) >> 4);
                outbuf[1] = ((inbuf[1] & 0x0F) << 4) | ((inbuf[2] & 0x3C) >> 2);
                outbuf[2] = ((inbuf[2] & 0x03) << 6) | (inbuf[3] & 0x3F);
                
                for (i = 0; i < ctcharsinbuf; i++)
                {
                    [theData appendBytes: &outbuf[i] length: 1];
                }
            }
            
            if (flbreak)
            {
                break;
            }
        }
    }
    
    return theData;
}
@end
