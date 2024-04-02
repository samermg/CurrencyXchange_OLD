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
+ (NSDictionary*)SupportedSymboles {
    NSDictionary* symboles = @{@"AGLD@":@"Adventure Gold@",@"FJD@":@"Fiji Dollar@",@"MXN@":@"Mexican Peso@",@"TET@":@"Tectum@",@"LVL@":@"Latvian Lats@",@"SCR@":@"Seychellois Rupee@",@"CDF@":@"Congolese Franc@",@"BBD@":@"Barbadian Dollar@",@"HNL@":@"Honduran Lempira@",@"UGX@":@"Uganda Shilling@",@"GLM@":@"Golem@",@"KUJI@":@"Kujira@",@"RAY@":@"Raydium@",@"NEAR@":@"NEAR Protocol@",@"BTC.B@":@"Bitcoin Avalanche Bridged@",@"AIOZ@":@"Aioz Network@",@"AUDIO@":@"Audius@",@"WLD@":@"Worldcoin@",@"HNT@":@"Helium@",@"ETHFI@":@"ether.fi@",@"CDT@":@"Blox@",@"FDUSD@":@"First Digital USD@",@"FARM@":@"Harvest Finance@",@"SDG@":@"Sudanese Pound@",@"KUB@":@"Bitkub@",@"NPXS@":@"Pundi X [OLD]@",@"IQD@":@"Iraqi Dinar@",@"GMD@":@"Gambian Dalasi@",@"RBN@":@"Ribbon FInance@",@"ZRX@":@"ZRX 0x@",@"BCH@":@"Bitcoin Cash@",@"MYR@":@"Malaysian Ringgit@",@"AI@":@"Sleepless AI@",@"FKP@":@"Falkland Islands Pound@",@"JST@":@"JUST@",@"HOT@":@"Holo@",@"XOF@":@"West African CFA Franc@",@"GMT@":@"Stepn@",@"SWETH@":@"Swell Ethereum@",@"AR@":@"Arweave@",@"GMX@":@"GMX@",@"SEI@":@"Sei@",@"SEK@":@"Swedish Krona@",@"GNF@":@"Guinean Franc@",@"MZN@":@"Mozambican Metical@",@"QAR@":@"Qatari Rial@",@"JTO@":@"Jito@",@"WEMIX@":@"WEMIX@",@"CFG@":@"Centrifuge@",@"IRR@":@"Iranian Rial@",@"GNO@":@"Gnosis@",@"GNT@":@"GreenTrust@",@"FLR@":@"FLARE@",@"GNS@":@"Gains Network@",@"XPD@":@"Palladium (troy ounce)@",@"THB@":@"Thai Baht@",@"XPF@":@"CFP Franc@",@"VANRY@":@"Vanar Chain@",@"BIGTIME@":@"Big Time@",@"ABT@":@"Arcblock@",@"BDT@":@"Bangladeshi Taka@",@"T@":@"Threshold@",@"CFX@":@"Conflux@",@"LYD@":@"Libyan Dinar@",@"CDAI@":@"Compound Dai@",@"BDX@":@"Beldex@",@"BABYDOGE@":@"Baby Doge Coin@",@"KWD@":@"Kuwaiti Dinar@",@"VELO@":@"Velo@",@"SFP@":@"SafePal@",@"DIA@":@"Dia@",@"XPT@":@"Platinum (troy ounce)@",@"PORK@":@"PepeFork@",@"ISK@":@"Iceland Krona@",@"JUP@":@"Jupiter@",@"ACH@":@"Alchemy Pay@",@"RSS3@":@"RSS3@",@"LYX@":@"LUKSO@",@"MINA@":@"Mina@",@"TIA@":@"Celestia@",@"VTHO@":@"VeThor Token@",@"SGB@":@"Songbird@",@"PAB@":@"Panamanian Balboa@",@"ACS@":@"ACryptoS@",@"SGD@":@"Singapore Dollar@",@"STRD@":@"Stride@",@"WOO@":@"WOO Network@",@"REI@":@"REI Network@",@"BLUR@":@"Blur@",@"REN@":@"renBTC@",@"ELA@":@"Elastos@",@"REP@":@"Augur@",@"STRK@":@"Starknet@",@"ADA@":@"Cardano@",@"ELF@":@"aelf@",@"REQ@":@"Request@",@"STORJ@":@"Storj@",@"CHF@":@"Swiss Franc@",@"HRK@":@"Croatian Kuna@",@"RARI@":@"Rarible@",@"DJF@":@"Djibouti Franc@",@"ELG@":@"Escoin@",@"RARE@":@"SuperRare@",@"LADYS@":@"Milady Meme Coin@",@"PAXG@":@"PAX Gold@",@"PAX@":@"Paxos Standard Token@",@"XRD@":@"Radix@",@"CHR@":@"Chromia@",@"VND@":@"Vietnamese Dong@",@"$WEN@":@"Wen@",@"WAVES@":@"Waves@",@"CHZ@":@"Chiliz@",@"KYD@":@"Cayman Islands Dollar@",@"XRP@":@"Ripple@",@"FLOKI@":@"FLOKI@",@"JASMY@":@"Jasmy@",@"SHP@":@"Saint Helena Pound@",@"INDEX@":@"Index Cooperative@",@"BGB@":@"Bitget Token@",@"TJS@":@"Tajikistani Somoni@",@"AED@":@"UAE Dirham@",@"FIDA@":@"Bonfida@",@"SAND@":@"The Sandbox@",@"DKK@":@"Danish Krone@",@"WCFG@":@"Wrapped Centrifuge@",@"ZWD@":@"Zimbabwean Dollar@",@"OCEAN@":@"Ocean Protocol@",@"BGN@":@"Bulgarian Lev@",@"UMA@":@"Universal Market Access@",@"FOX@":@"Shapeshift FOX Token@",@"ZWL@":@"Zimbabwean Dollar@",@"TUSD@":@"TrueUSD@",@"HTG@":@"Haitian Gourde@",@"RGT@":@"Rari Governance Token@",@"BHD@":@"Bahraini Dinar@",@"ENJ@":@"Enjin Coin@",@"OAS@":@"Oasys@",@"TKX@":@"Tokenize Xchange@",@"COVAL@":@"COVAL@",@"CGLD@":@"Celo Gold@",@"KZT@":@"Kazakhstani Tenge@",@"YFII@":@"DFI.Money@",@"DIMO@":@"DIMO@",@"GRT@":@"The Graph@",@"HBTC@":@"Huobi BTC@",@"AFN@":@"Afghan Afghani@",@"TFUEL@":@"Theta Fuel@",@"ENS@":@"Ethereum Name Service@",@"UNI@":@"Uniswap@",@"DEGEN@":@"Degen (BASE)@",@"FX@":@"Function X@",@"XTS@":@"Xaviera Techno Solutions@",@"HUF@":@"Hungarian Forint@",@"CKB@":@"Nervos Network@",@"LUNC@":@"Terra Luna Classic@",@"BIF@":@"Burundian Franc@",@"XTZ@":@"Tezos@",@"LUNA@":@"Terra@",@"AURORA@":@"Aurora@",@"GF@":@"GuildFi@",@"AGI@":@"Delysium@",@"EOS@":@"EOS@",@"GST@":@"Green Satoshi Token@",@"FORT@":@"Forta@",@"SWFTC@":@"SwftCoin@",@"BIT@":@"BitDAO@",@"GT@":@"GateToken@",@"RIF@":@"RSK Infrastructure Framework@",@"WHRH@":@"White Rhinoceros@",@"NAD@":@"Namibian Dollar@",@"SKK@":@"Slovak Koruna@",@"FRXETH@":@"Frax Finance - Frax Ether@",@"SKL@":@"SKALE Network@",@"TMM@":@"Turkmenistan Manat@",@"SLERF@":@"SLERF@",@"GTC@":@"Gitcoin@",@"PEN@":@"Peruvian Sol@",@"UOS@":@"Ultra@",@"WST@":@"Samoan Tālā@",@"SHPING@":@"Shping Coin@",@"TMT@":@"Turkmenistani Manat@",@"CLF@":@"Chilean Unit of Account (UF)@",@"BRETT@":@"Brett@",@"EUROC@":@"Euro Coin@",@"GTQ@":@"Guatemalan Quetzal@",@"CLP@":@"Chilean Peso@",@"DNT@":@"District0x@",@"TND@":@"Tunisian Dinar@",@"HT@":@"Huobi Token@",@"CLV@":@"Clover Finance@",@"SLE@":@"Sierra Leonean Leone@",@"FLOW@":@"Flow@",@"UPI@":@"Pawtocol@",@"SLL@":@"Sierra Leonean Leone@",@"$MYRO@":@"Myro@",@"XVS@":@"Venus@",@"MEME@":@"Memecoin@",@"SLP@":@"Smooth Love Potion@",@"LYXE@":@"LUKSO (Old)@",@"ID@":@"SPACE ID@",@"DOP@":@"Dominican Peso@",@"UQC@":@"Uquid Coin@",@"DOT@":@"Polkadot@",@"IQ@":@"IQ@",@"SFUND@":@"Seedify.fund@",@"OSAK@":@"Osaka Protocol@",@"1INCH@":@"1inch@",@"MAD@":@"Moroccan Dirham@",@"TON@":@"Toncoin@",@"TOP@":@"Tongan Paʻanga@",@"PGK@":@"Papua New Guinean Kina@",@"TOR@":@"TOR@",@"FNSA@":@"FINSCHIA@",@"GYEN@":@"GYEN@",@"BLD@":@"Agoric@",@"UNFI@":@"Unifi Protocol DAO@",@"CNH@":@"Chinese Yuan Renminbi Offshore@",@"APEX@":@"ApeX Protocol@",@"FTM@":@"Fantom@",@"NCT@":@"Polyswarm@",@"EVER@":@"Everscale@",@"WLUNA@":@"Wrapped LUNA@",@"POWR@":@"Powerledger@",@"ERN@":@"Eritrean Nakfa@",@"FTN@":@"Fasttoken@",@"MAV@":@"Maverick Protocol@",@"CORGIAI@":@"CorgiAI@",@"VOXEL@":@"Voxies@",@"RLC@":@"iExec RLC@",@"ARKM@":@"Arkham@",@"CNY@":@"Chinese Yuan Renminbi@",@"ATOM@":@"Cosmos@",@"SAVAX@":@"BENQI Liquid Staked AVAX@",@"QUICK@":@"QuickSwap@",@"PENDLE@":@"Pendle@",@"BLZ@":@"Bluzelle@",@"BOBA@":@"Boba Network@",@"TONE@":@"TE-FOOD@",@"BMD@":@"Bermudian Dollar@",@"SNT@":@"Status Network@",@"PHP@":@"Philippine Piso@",@"SNX@":@"Synthetix Network@",@"RLY@":@"Rally@",@"OX_OLD@":@"Open Exchange Token@",@"COQ@":@"Coq Inu@",@"COP@":@"Colombian Peso@",@"USD@":@"US Dollar@",@"API3@":@"API3@",@"HOPR@":@"HOPR@",@"ROSE@":@"Oasis Network@",@"AKT@":@"Akash Network@",@"GLMR@":@"Moonbeam@",@"SATS@":@"SATS (Ordinals)@",@"ORAI@":@"Oraichain@",@"XYO@":@"XYO Network@",@"PORTAL@":@"Portal@",@"SOL@":@"Solana@",@"ETB@":@"Ethiopian Birr@",@"GXC@":@"GXChain@",@"ETC@":@"Ethereum Classic@",@"SOS@":@"Somali Shilling@",@"VUV@":@"Vanuatu Vatu@",@"BNB@":@"BNB@",@"LAK@":@"Laotian Kip@",@"OGN@":@"Origin Token@",@"UST@":@"TerraUSD@",@"CELR@":@"Celer Network@",@"ETH@":@"Ethereum@",@"BND@":@"Brunei Dollar@",@"NEO@":@"Neo@",@"CELO@":@"Celo@",@"KLAY@":@"Klaytn@",@"AUCTION@":@"Bounce Token AUCTION@",@"MANTA@":@"Manta Network@",@"BADGER@":@"Badger DAO@",@"MULTI@":@"Multichain@",@"AERO@":@"Aerodrome Finance@",@"ALL@":@"Albanian Lek@",@"MAVIA@":@"Heroes of Mavia@",@"HIGH@":@"Highstreet@",@"SPA@":@"Sperax@",@"TRB@":@"Tellor@",@"ALT@":@"AltLayer@",@"BNT@":@"Bancor Network@",@"ORDI@":@"Ordinals@",@"SHDW@":@"Shadow Token@",@"GYD@":@"Guyana Dollar@",@"BOB@":@"Bolivian Boliviano@",@"MDL@":@"Moldovan Leu@",@"OHM@":@"Olympus@",@"TRU@":@"TrueFi@",@"AMD@":@"Armenian Dram@",@"DREP@":@"Drep [new]@",@"ETHDYDX@":@"dYdX@",@"TRY@":@"Turkish Lira@",@"LBP@":@"Lebanese Pound@",@"TRX@":@"TRON@",@"MDT@":@"Measurable Data Token@",@"NFT@":@"APENFT@",@"AERGO@":@"Aergo@",@"EUR@":@"Euro@",@"AMP@":@"Amp@",@"ORCA@":@"Orca@",@"CQT@":@"Covalent@",@"USTC@":@"TerraClassicUSD@",@"MX@":@"MX Token@",@"RON@":@"Romanian Leu@",@"NGN@":@"Nigerian Naira@",@"CRC@":@"Costa Rican Colon@",@"PKR@":@"Pakistani Rupee@",@"LUSD@":@"Liquity USD@",@"ANG@":@"Netherlands Antillean Guilder@",@"EGLD@":@"Elrond@",@"KAS@":@"Kaspa@",@"TRUMP@":@"MAGA@",@"MEW@":@"cat in a dogs world@",@"SPELL@":@"Spell Token@",@"PUNDIX@":@"Pundi X (New)@",@"FXS@":@"Frax Share@",@"LCX@":@"LCX@",@"CRO@":@"Cronos@",@"AEVO@":@"Aevo@",@"PLA@":@"PlayDapp@",@"SRD@":@"Surinamese Dollar@",@"TTD@":@"Trinidad and Tobago Dollar@",@"SFRXETH@":@"Frax Staked Ether@",@"CRV@":@"Curve DAO Token@",@"MNDE@":@"Marinade@",@"NU@":@"NuCypher@",@"ANT@":@"Aragon@",@"BAKE@":@"BakeryToken@",@"FLUX@":@"Flux@",@"TOPIA@":@"HYTOPIA@",@"RPL@":@"Rocket Pool@",@"AOA@":@"Angolan Kwanza@",@"PLN@":@"Polish Zloty@",@"AZERO@":@"Aleph Zero@",@"LDO@":@"Lido DAO Token@",@"QNT@":@"Quant@",@"MAGIC@":@"MAGIC@",@"ALICE@":@"My Neighbor Alice@",@"PLU@":@"Pluton@",@"SEAM@":@"Seamless@",@"MUSD@":@"mStableUSD@",@"OM@":@"MANTRA@",@"ETHW@":@"EthereumPoW@",@"MUSE@":@"Muse@",@"ETHX@":@"Stader ETHx@",@"OP@":@"Optimism@",@"CANTO@":@"CANTO@",@"MGA@":@"Malagasy Ariary@",@"OKB@":@"OKB@",@"OX@":@"Open Exchange Token@",@"SSP@":@"South Sudanese Pound@",@"NEON@":@"Neon EVM@",@"CTC@":@"Creditcoin@",@"NIO@":@"Nicaraguan Córdoba@",@"APE@":@"ApeCoin@",@"LEO@":@"UNUS SED LEO@",@"SSV@":@"SSV Network@",@"OKT@":@"OKT Chain@",@"ETH2@":@"Ethereum 2.0@",@"PAAL@":@"PAAL AI@",@"KCS@":@"KuCoin Token@",@"BUSD@":@"Binance USD@",@"ARPA@":@"ARPA Chain@",@"BRL@":@"Brazilian Real@",@"MCO2@":@"Moss Carbon Credit@",@"APL@":@"Apollo@",@"ALCX@":@"Alchemix@",@"00@":@"00 Token@",@"ALEX@":@"ALEX Lab@",@"MATIC@":@"Polygon@",@"STD@":@"São Tomé and Príncipe Dobra@",@"APT@":@"Aptos@",@"CTX@":@"Cryptex Finance@",@"STG@":@"Stargate Finance@",@"PNG@":@"Pangolin@",@"TVK@":@"Terra Virtua Kolect@",@"IOTX@":@"IoTeX@",@"SHIB@":@"Shiba Inu@",@"KDA@":@"Kadena@",@"ZAR@":@"South African Rand@",@"STN@":@"São Tomé and Príncipe Dobra@",@"CUC@":@"Cuban Convertible Peso@",@"BSD@":@"Bahamian Dollar@",@"STX@":@"Stacks@",@"QI@":@"BENQI@",@"PYTH@":@"Pyth Network@",@"CUP@":@"Cuban Peso@",@"TWD@":@"New Taiwan Dollar@",@"RSD@":@"Serbian Dinar@",@"FRAX@":@"Frax@",@"BSV@":@"Bitcoin SV@",@"IOST@":@"IOST@",@"SUI@":@"Sui@",@"CAKE@":@"PancakeSwap@",@"MSOL@":@"Marinade Staked SOL@",@"WBETH@":@"Wrapped Beacon ETH@",@"OMG@":@"Omisego@",@"METH@":@"Mantle Staked Ether@",@"OMI@":@"ECOMI@",@"BAND@":@"Band Protocol@",@"PYUSD@":@"PayPal USD@",@"ASTR@":@"Astar@",@"BTC@":@"Bitcoin@",@"NKN@":@"NKN@",@"TWT@":@"Trust Wallet Token@",@"UYU@":@"Uruguayan Peso@",@"RSR@":@"Reserve Rights@",@"ARB@":@"Arbitrum@",@"CVC@":@"Civic@",@"IOTA@":@"IOTA@",@"VARA@":@"Vara Network @",@"CVE@":@"Cape Verdean Escudo@",@"BTG@":@"Bitcoin Gold@",@"OMR@":@"Omani Rial@",@"MIR@":@"Mirror Protocol@",@"KES@":@"Kenyan Shilling@",@"ARK@":@"Ark@",@"LOKA@":@"League of Kingdoms Arena@",@"BTN@":@"Bhutanese Ngultrum@",@"RONIN@":@"Ronin@",@"SVC@":@"Salvadoran Colón@",@"ARS@":@"Argentine Peso@",@"BTT@":@"BitTorrent@",@"CVX@":@"Convex Finance@",@"ONE@":@"Harmony@",@"RENDER@":@"Render@",@"CETH@":@"Compound Ether@",@"ANKR@":@"Ankr Network@",@"SUSHI@":@"SushiSwap@",@"ALGO@":@"Algorand@",@"SYLO@":@"Sylo@",@"UZS@":@"Uzbekistani Som@",@"SC@":@"Siacoin@",@"WBTC@":@"Wrapped Bitcoin@",@"ONT@":@"Ontology@",@"DYM@":@"Dymension@",@"DYP@":@"DeFi Yield Protocol@",@"ASM@":@"Assemble Protocol@",@"RUB@":@"Russian Ruble@",@"AST@":@"AirSwap@",@"MANA@":@"Mana Coin Decentraland@",@"MKD@":@"Macedonian Denar@",@"CSPR@":@"Casper@",@"ATA@":@"Automata Network@",@"DZD@":@"Algerian Dinar@",@"QSP@":@"Quantstamp@",@"NMR@":@"Numeraire Network@",@"JEP@":@"Jersey Pound@",@"MKR@":@"Maker@",@"KGS@":@"Kyrgyzstani Som@",@"LIT@":@"Litentry@",@"ICP@":@"Internet Computer@",@"ZEC@":@"ZCash@",@"XAF@":@"Central African CFA franc@",@"NEST@":@"NEST Protocol@",@"ICX@":@"ICON@",@"XAG@":@"Silver (troy ounce)@",@"POLYX@":@"Polymesh@",@"XAI@":@"Xai@",@"ZEN@":@"Horizen@",@"DESO@":@"Decentralized Social@",@"LOOM@":@"Loom Network@",@"DOGE@":@"Dogecoin@",@"HBAR@":@"Hedera@",@"RVN@":@"Ravencoin@",@"PRO@":@"Propy@",@"TZS@":@"Tanzanian Shilling@",@"XAU@":@"Gold (troy ounce)@",@"MLN@":@"Enzyme@",@"PRQ@":@"PARSIQ@",@"ONDO@":@"Ondo@",@"PEPE@":@"Pepe@",@"AUD@":@"Australian Dollar@",@"KHR@":@"Cambodian Riel@",@"IDR@":@"Indonesian Rupiah@",@"XBA@":@"XBank@",@"CTSI@":@"Cartesi@",@"BWP@":@"Botswanan Pula@",@"COMAI@":@"Commune AI@",@"RWF@":@"Rwandan Franc@",@"KAVA@":@"Kava@",@"C98@":@"Coin98@",@"OSMO@":@"Osmosis@",@"NTRN@":@"Neutron@",@"SYN@":@"Synapse@",@"MMK@":@"Burmese Kyat@",@"NOK@":@"Norwegian Krone@",@"SYP@":@"Syrian Pound@",@"CRPT@":@"Crypterium@",@"GAJ@":@"Gaj Finance@",@"STRAX@":@"Stratis@",@"LKR@":@"Sri Lankan Rupee@",@"GAL@":@"Project Galaxy@",@"NOS@":@"Nosana@",@"CZK@":@"Czech Koruna@",@"GAS@":@"Gas@",@"XCD@":@"East Caribbean Dollar@",@"BOME@":@"BOOK OF MEME@",@"VR@":@"Victoria VR@",@"XCH@":@"Chia@",@"SYNC@":@"Syncus@",@"AVT@":@"Aventus@",@"THETA@":@"Theta Network@",@"PANDORA@":@"Pandora@",@"XCN@":@"Chain@",@"SZL@":@"Swazi Lilangeni@",@"YER@":@"Yemeni Rial@",@"LSETH@":@"Liquid Staked Ethereum@",@"ORN@":@"Orion Protocol@",@"NEXO@":@"Nexo@",@"MASK@":@"Mask Network@",@"AWG@":@"Aruban Florin@",@"NPR@":@"Nepalese Rupee@",@"AAVE@":@"Aave@",@"MNT@":@"Mongolian Tögrög@",@"PRIME@":@"Echelon Prime@",@"GBP@":@"Pound Sterling@",@"BONK@":@"Bonk@",@"BYN@":@"New Belarusian Ruble@",@"XDC@":@"XDC Network@",@"PERP@":@"Perpetual Protocol@",@"BYR@":@"Belarusian Ruble@",@"BONE@":@"Bone ShibaSwap@",@"GBX@":@"Penny Sterling@",@"BOND@":@"BarnBridge@",@"YFI@":@"Yearn Finance@",@"MOG@":@"MOG Coin@",@"CWBTC@":@"Compound Wrapped BTC@",@"XDR@":@"Special Drawing Rights@",@"POPCAT@":@"Popcat@",@"WBT@":@"WhiteBIT Coin@",@"LQTY@":@"Liquity@",@"OLAS@":@"Autonolas@",@"TIME@":@"Chrono.tech@",@"BICO@":@"Biconomy@",@"ALUSD@":@"Alchemix USD@",@"BZD@":@"Belize Dollar@",@"MOP@":@"Macau Pataca@",@"PIXEL@":@"Pixels@",@"MONA@":@"Monavale@",@"ZETA@":@"ZetaChain@",@"AXL@":@"Axelar@",@"CHEEL@":@"Cheelee@",@"XEC@":@"eCash@",@"YGG@":@"Yield Guild Games@",@"PEOPLE@":@"ConstitutionDAO@",@"AXS@":@"Axie Infinity@",@"ZIL@":@"Zilliqa@",@"HONEY@":@"Hivemapper@",@"XEM@":@"NEM@",@"WEETH@":@"Wrapped eETH@",@"TRAC@":@"OriginTrail@",@"MPL@":@"Maple@",@"0X0@":@"0x0.ai: AI Smart Contract@",@"COMP@":@"Compound@",@"WAXL@":@"Axelar@",@"HFT@":@"Hashflow@",@"WAMPL@":@"Wrapped Ampleforth@",@"OOKI@":@"Ooki Protocol@",@"RUNE@":@"THORChain@",@"DEXT@":@"DEXTools@",@"FORTH@":@"Ampleforth Governance Token@",@"BORA@":@"BORA@",@"GHST@":@"Aavegotchi@",@"KMF@":@"Comorian Franc@",@"MATH@":@"MATH@",@"IDEX@":@"IDEX@",@"GEL@":@"Georgian Lari@",@"DEXE@":@"DeXe@",@"VNST@":@"VNST Stablecoin@",@"AVAX@":@"Avalanche@",@"RSETH@":@"Kelp DAO Restaked ETH@",@"EETH@":@"ether.fi Staked ETH@",@"AZN@":@"Azerbaijani Manat@",@"AMPL@":@"Ampleforth@",@"UAH@":@"Ukrainian Hryvnia@",@"KNC@":@"Kyber Network Crystals@",@"PROM@":@"Prom@",@"ALEPH@":@"Aleph.im@",@"GFI@":@"Goldfinch@",@"MRO@":@"Mauritanian Ouguiya@",@"MRS@":@"Metars Genesis@",@"LPT@":@"Livepeer (LPT)@",@"MRU@":@"Mauritanian Ouguiya@",@"GODS@":@"Gods Unchained@",@"EDUM@":@"EDUM@",@"BORG@":@"SwissBorg@",@"PYG@":@"Paraguayan Guaraní@",@"JMD@":@"Jamaican Dollar@",@"XAUT@":@"Tether Gold@",@"PYR@":@"Vulcan Forged PYR@",@"BTRST@":@"Braintrust@",@"MKUSD@":@"Prisma mkUSD@",@"WAXP@":@"WAX@",@"DAG@":@"Constellation@",@"SUKU@":@"SUKU@",@"DAI@":@"DAI@",@"GGP@":@"Guernsey Pound@",@"GRIN@":@"Grin@",@"DAO@":@"DAO Maker@",@"DAR@":@"Mines of Dalarnia@",@"FET@":@"Fetch.ai@",@"CBETH@":@"Coinbase Wrapped Staked ETH@",@"VEF@":@"Venezuelan Bolívar Fuerte@",@"ZMK@":@"Zambian Kwacha@",@"LRC@":@"Loopring@",@"ALPH@":@"Alephium@",@"REPV2@":@"REPv2@",@"LRD@":@"Liberian Dollar@",@"MOBILE@":@"Helium Mobile@",@"CORE@":@"Core@",@"TAO@":@"Bittensor@",@"MTL@":@"Maltese Lira@",@"VET@":@"VeChain@",@"VES@":@"Venezuelan Bolívar@",@"ZMW@":@"Zambian Kwacha@",@"USDT@":@"Tether@",@"OXT@":@"Orchid Network@",@"DASH@":@"Digital Cash@",@"POKT@":@"Pocket Network@",@"USDP@":@"Pax Dollar@",@"ILS@":@"New Israeli Sheqel@",@"ILV@":@"Illuvium@",@"GHS@":@"Ghanaian Cedi@",@"KPW@":@"North Korean Won@",@"EDU@":@"Open Campus@",@"MEDIA@":@"Media Network@",@"LSD@":@"L7DEX@",@"JOD@":@"Jordanian Dinar@",@"GUSD@":@"Gemini US Dollar@",@"HKD@":@"Hong Kong Dollar@",@"JOE@":@"JOE@",@"LSL@":@"Lesotho Loti@",@"LSK@":@"Lisk@",@"KEEP@":@"Keep Network@",@"CAD@":@"Canadian Dollar@",@"CAF@":@"Childrens Aid Foundation@",@"EEK@":@"Estonian Kroon@",@"MUR@":@"Mauritius Rupee@",@"IMP@":@"Isle of Man Pound@",@"GIP@":@"Gibraltar Pound@",@"BEAM@":@"Beam@",@"DCR@":@"Decred@",@"IMX@":@"Immutable X@",@"WIF@":@"dogwifhat@",@"USDE@":@"Ethena USDe@",@"USDD@":@"USDD@",@"LTC@":@"Litecoin@",@"USDC@":@"USDC@",@"METIS@":@"MetisDAO@",@"XMON@":@"XMON@",@"STETH@":@"Lido Staked Ether@",@"RETH@":@"Rocket Pool ETH@",@"NXM@":@"Nexus Mutual@",@"INJ@":@"Injective@",@"KRL@":@"Kryll@",@"LTL@":@"Lithuanian Litas@",@"SAR@":@"Saudi Riyal@",@"VGX@":@"Voyager Token@",@"MVR@":@"Maldivian Rufiyaa@",@"TRIBE@":@"Tribe@",@"DYDX@":@"dYdX@",@"AGIX@":@"SingularityNET@",@"MUBI@":@"Multibit@",@"INR@":@"Indian Rupee@",@"INV@":@"Inverse Finance@",@"POND@":@"Marlin@",@"KRW@":@"South Korean Won@",@"JPY@":@"Japanese Yen@",@"SBD@":@"Solomon Islands Dollar@",@"STSOL@":@"Lido for Solana@",@"XLM@":@"Stellar@",@"DDX@":@"DerivaDAO@",@"LINK@":@"Chainlink@",@"DORA@":@"Dora Factory@",@"QTUM@":@"Qtum@",@"MWK@":@"Malawian Kwacha@",@"SUPER@":@"SuperFarm@",@"POLS@":@"Polkastarter@",@"KSM@":@"Kusama@",@"FIL@":@"Filecoin@",@"POLY@":@"Polymath@",@"RNDR@":@"Render Token@",@"BAL@":@"Balancer@",@"BAM@":@"Bosnia-Herzegovina Convertible Mark@",@"GALA@":@"Gala@",@"EGP@":@"Egyptian Pound@",@"FIS@":@"Stafi@",@"RAD@":@"Radicle@",@"BAT@":@"Basic Attention Token@",@"MXC@":@"MXC@",@"NZD@":@"New Zealand Dollar@",@"MOVR@":@"Moonriver@",@"TEL@":@"Telcoin@",@"RAI@":@"Rai Reflex Index@",@"XMR@":@"Monero@",@"COTI@":@"COTI@"};
    return  symboles;
}
+ (NSArray*)Symbols {
    
    NSArray *symbole = @[
        @{@"USD": @{
                @"symbol": @"$",
                @"name": @"US Dollar",
                @"symbol_native": @"$",
                @"decimal_digits": @"2",
                @"rounding": @"0",
                @"code": @"USD",
                @"name_plural": @"US dollars",
                @"rate": @"0"
                }},
        @{@"CAD": @{
                @"symbol": @"CA$",
                @"name": @"Canadian Dollar",
                @"symbol_native": @"$",
                @"decimal_digits": @"2",
                @"rounding": @"0",
                @"code": @"CAD",
                @"name_plural": @"Canadian dollars",
                @"rate": @"0"
                }},
        @{@"EUR": @{
                @"symbol": @"€",
                @"name": @"Euro",
                @"symbol_native": @"€",
                @"decimal_digits": @"2",
                @"rounding": @"0",
                @"code": @"EUR",
                @"name_plural": @"euros",
                @"rate": @"0"
                }},
        @{@"AED": @{
                @"symbol": @"AED",
                @"name": @"United Arab Emirates Dirham",
                @"symbol_native": @"د.إ.‏",
                @"decimal_digits": @"2",
                @"rounding": @"0",
                @"code": @"AED",
                @"name_plural": @"UAE dirhams",
                @"rate": @"0"
                }},
        @{@"AFN": @{
                @"symbol": @"Af",
                @"name": @"Afghan Afghani",
                @"symbol_native": @"؋",
                @"decimal_digits": @"0",
                @"rounding": @"0",
                @"code": @"AFN",
                @"name_plural": @"Afghan Afghanis",
                @"rate": @"0"
                }},
        @{@"ALL": @{
                @"symbol": @"ALL",
                @"name": @"Albanian Lek",
                @"symbol_native": @"Lek",
                @"decimal_digits": @"0",
                @"rounding": @"0",
                @"code": @"ALL",
                @"name_plural": @"Albanian lekë",
                @"rate": @"0"
                }},
        @{@"AMD": @{
                @"symbol": @"AMD",
                @"name": @"Armenian Dram",
                @"symbol_native": @"դր.",
                @"decimal_digits": @"0",
                @"rounding": @"0",
                @"code": @"AMD",
                @"name_plural": @"Armenian drams",
                @"rate": @"0"
                }},
        @{@"ARS": @{
                @"symbol": @"AR$",
                @"name": @"Argentine Peso",
                @"symbol_native": @"$",
                @"decimal_digits": @"2",
                @"rounding": @"0",
                @"code": @"ARS",
                @"name_plural": @"Argentine pesos",
                @"rate": @"0"
                }},
        @{@"AUD": @{
                @"symbol": @"AU$",
                @"name": @"Australian Dollar",
                @"symbol_native": @"$",
                @"decimal_digits": @"2",
                @"rounding": @"0",
                @"code": @"AUD",
                @"name_plural": @"Australian dollars",
                @"rate": @"0"
                }},
        @{@"AZN": @{
                @"symbol": @"man.",
                @"name": @"Azerbaijani Manat",
                @"symbol_native": @"ман.",
                @"decimal_digits": @"2",
                @"rounding": @"0",
                @"code": @"AZN",
                @"name_plural": @"Azerbaijani manats",
                @"rate": @"0"
                }},
        @{@"BAM": @{
                @"symbol": @"KM",
                @"name": @"Bosnia-Herzegovina Convertible Mark",
                @"symbol_native": @"KM",
                @"decimal_digits": @"2",
                @"rounding": @"0",
                @"code": @"BAM",
                @"name_plural": @"Bosnia-Herzegovina convertible marks",
                @"rate": @"0"
                }},
        @{@"BDT": @{
                @"symbol": @"Tk",
                @"name": @"Bangladeshi Taka",
                @"symbol_native": @"৳",
                @"decimal_digits": @"2",
                @"rounding": @"0",
                @"code": @"BDT",
                @"name_plural": @"Bangladeshi takas",
                @"rate": @"0"
                }},
        @{@"BGN": @{
                @"symbol": @"BGN",
                @"name": @"Bulgarian Lev",
                @"symbol_native": @"лв.",
                @"decimal_digits": @"2",
                @"rounding": @"0",
                @"code": @"BGN",
                @"name_plural": @"Bulgarian leva",
                @"rate": @"0"
                }},
        @{@"BHD": @{
                @"symbol": @"BD",
                @"name": @"Bahraini Dinar",
                @"symbol_native": @"د.ب.‏",
                @"decimal_digits": @"3",
                @"rounding": @"0",
                @"code": @"BHD",
                @"name_plural": @"Bahraini dinars",
                @"rate": @"0"
                }},
        @{@"BIF": @{
                @"symbol": @"FBu",
                @"name": @"Burundian Franc",
                @"symbol_native": @"FBu",
                @"decimal_digits": @"0",
                @"rounding": @"0",
                @"code": @"BIF",
                @"name_plural": @"Burundian francs",
                @"rate": @"0"
                }},
        @{@"BND": @{
                @"symbol": @"BN$",
                @"name": @"Brunei Dollar",
                @"symbol_native": @"$",
                @"decimal_digits": @"2",
                @"rounding": @"0",
                @"code": @"BND",
                @"name_plural": @"Brunei dollars",
                @"rate": @"0"
                }},
        @{@"BOB": @{
                @"symbol": @"Bs",
                @"name": @"Bolivian Boliviano",
                @"symbol_native": @"Bs",
                @"decimal_digits": @"2",
                @"rounding": @"0",
                @"code": @"BOB",
                @"name_plural": @"Bolivian bolivianos",
                @"rate": @"0"
                }},
        @{@"BRL": @{
                @"symbol": @"R$",
                @"name": @"Brazilian Real",
                @"symbol_native": @"R$",
                @"decimal_digits": @"2",
                @"rounding": @"0",
                @"code": @"BRL",
                @"name_plural": @"Brazilian reals",
                @"rate": @"0"
                }},
        @{@"BWP": @{
                @"symbol": @"BWP",
                @"name": @"Botswanan Pula",
                @"symbol_native": @"P",
                @"decimal_digits": @"2",
                @"rounding": @"0",
                @"code": @"BWP",
                @"name_plural": @"Botswanan pulas",
                @"rate": @"0"
                }},
        @{@"BYN": @{
                @"symbol": @"Br",
                @"name": @"Belarusian Ruble",
                @"symbol_native": @"руб.",
                @"decimal_digits": @"2",
                @"rounding": @"0",
                @"code": @"BYN",
                @"name_plural": @"Belarusian rubles",
                @"rate": @"0"
                }},
        @{@"BZD": @{
                @"symbol": @"BZ$",
                @"name": @"Belize Dollar",
                @"symbol_native": @"$",
                @"decimal_digits": @"2",
                @"rounding": @"0",
                @"code": @"BZD",
                @"name_plural": @"Belize dollars",
                @"rate": @"0"
                }},
        @{@"CDF": @{
                @"symbol": @"CDF",
                @"name": @"Congolese Franc",
                @"symbol_native": @"FrCD",
                @"decimal_digits": @"2",
                @"rounding": @"0",
                @"code": @"CDF",
                @"name_plural": @"Congolese francs",
                @"rate": @"0"
                }},
        @{@"CHF": @{
                @"symbol": @"CHF",
                @"name": @"Swiss Franc",
                @"symbol_native": @"CHF",
                @"decimal_digits": @"2",
                @"rounding": @"0.05",
                @"code": @"CHF",
                @"name_plural": @"Swiss francs",
                @"rate": @"0"
                }},
        @{@"CLP": @{
                @"symbol": @"CL$",
                @"name": @"Chilean Peso",
                @"symbol_native": @"$",
                @"decimal_digits": @"0",
                @"rounding": @"0",
                @"code": @"CLP",
                @"name_plural": @"Chilean pesos",
                @"rate": @"0"
                }},
        @{@"CNY": @{
                @"symbol": @"CN¥",
                @"name": @"Chinese Yuan",
                @"symbol_native": @"CN¥",
                @"decimal_digits": @"2",
                @"rounding": @"0",
                @"code": @"CNY",
                @"name_plural": @"Chinese yuan",
                @"rate": @"0"
                }},
        @{@"COP": @{
                @"symbol": @"CO$",
                @"name": @"Colombian Peso",
                @"symbol_native": @"$",
                @"decimal_digits": @"0",
                @"rounding": @"0",
                @"code": @"COP",
                @"name_plural": @"Colombian pesos",
                @"rate": @"0"
                }},
        @{@"CRC": @{
                @"symbol": @"₡",
                @"name": @"Costa Rican Colón",
                @"symbol_native": @"₡",
                @"decimal_digits": @"0",
                @"rounding": @"0",
                @"code": @"CRC",
                @"name_plural": @"Costa Rican colóns",
                @"rate": @"0"
                }},
        @{@"CVE": @{
                @"symbol": @"CV$",
                @"name": @"Cape Verdean Escudo",
                @"symbol_native": @"CV$",
                @"decimal_digits": @"2",
                @"rounding": @"0",
                @"code": @"CVE",
                @"name_plural": @"Cape Verdean escudos",
                @"rate": @"0"
                }},
        @{@"CZK": @{
                @"symbol": @"Kč",
                @"name": @"Czech Republic Koruna",
                @"symbol_native": @"Kč",
                @"decimal_digits": @"2",
                @"rounding": @"0",
                @"code": @"CZK",
                @"name_plural": @"Czech Republic korunas",
                @"rate": @"0"
                }},
        @{@"DJF": @{
                @"symbol": @"Fdj",
                @"name": @"Djiboutian Franc",
                @"symbol_native": @"Fdj",
                @"decimal_digits": @"0",
                @"rounding": @"0",
                @"code": @"DJF",
                @"name_plural": @"Djiboutian francs",
                @"rate": @"0"
                }},
        @{@"DKK": @{
                @"symbol": @"Dkr",
                @"name": @"Danish Krone",
                @"symbol_native": @"kr",
                @"decimal_digits": @"2",
                @"rounding": @"0",
                @"code": @"DKK",
                @"name_plural": @"Danish kroner",
                @"rate": @"0"
                }},
        @{@"DOP": @{
                @"symbol": @"RD$",
                @"name": @"Dominican Peso",
                @"symbol_native": @"RD$",
                @"decimal_digits": @"2",
                @"rounding": @"0",
                @"code": @"DOP",
                @"name_plural": @"Dominican pesos",
                @"rate": @"0"
                }},
        @{@"DZD": @{
                @"symbol": @"DA",
                @"name": @"Algerian Dinar",
                @"symbol_native": @"د.ج.‏",
                @"decimal_digits": @"2",
                @"rounding": @"0",
                @"code": @"DZD",
                @"name_plural": @"Algerian dinars",
                @"rate": @"0"
                }},
        @{@"EGP": @{
                @"symbol": @"EGP",
                @"name": @"Egyptian Pound",
                @"symbol_native": @"ج.م.‏",
                @"decimal_digits": @"2",
                @"rounding": @"0",
                @"code": @"EGP",
                @"name_plural": @"Egyptian pounds",
                @"rate": @"0"
                }},
        @{@"ERN": @{
                @"symbol": @"Nfk",
                @"name": @"Eritrean Nakfa",
                @"symbol_native": @"Nfk",
                @"decimal_digits": @"2",
                @"rounding": @"0",
                @"code": @"ERN",
                @"name_plural": @"Eritrean nakfas",
                @"rate": @"0"
                }},
        @{@"ETB": @{
                @"symbol": @"Br",
                @"name": @"Ethiopian Birr",
                @"symbol_native": @"Br",
                @"decimal_digits": @"2",
                @"rounding": @"0",
                @"code": @"ETB",
                @"name_plural": @"Ethiopian birrs",
                @"rate": @"0"
                }},
        @{@"GBP": @{
                @"symbol": @"£",
                @"name": @"British Pound Sterling",
                @"symbol_native": @"£",
                @"decimal_digits": @"2",
                @"rounding": @"0",
                @"code": @"GBP",
                @"name_plural": @"British pounds sterling",
                @"rate": @"0"
                }},
        @{@"GEL": @{
                @"symbol": @"GEL",
                @"name": @"Georgian Lari",
                @"symbol_native": @"GEL",
                @"decimal_digits": @"2",
                @"rounding": @"0",
                @"code": @"GEL",
                @"name_plural": @"Georgian laris",
                @"rate": @"0"
                }},
        @{@"GHS": @{
                @"symbol": @"GH₵",
                @"name": @"Ghanaian Cedi",
                @"symbol_native": @"GH₵",
                @"decimal_digits": @"2",
                @"rounding": @"0",
                @"code": @"GHS",
                @"name_plural": @"Ghanaian cedis",
                @"rate": @"0"
                }},
        @{@"GNF": @{
                @"symbol": @"FG",
                @"name": @"Guinean Franc",
                @"symbol_native": @"FG",
                @"decimal_digits": @"0",
                @"rounding": @"0",
                @"code": @"GNF",
                @"name_plural": @"Guinean francs",
                @"rate": @"0"
                }},
        @{@"GTQ": @{
                @"symbol": @"GTQ",
                @"name": @"Guatemalan Quetzal",
                @"symbol_native": @"Q",
                @"decimal_digits": @"2",
                @"rounding": @"0",
                @"code": @"GTQ",
                @"name_plural": @"Guatemalan quetzals",
                @"rate": @"0"
                }},
        @{@"HKD": @{
                @"symbol": @"HK$",
                @"name": @"Hong Kong Dollar",
                @"symbol_native": @"$",
                @"decimal_digits": @"2",
                @"rounding": @"0",
                @"code": @"HKD",
                @"name_plural": @"Hong Kong dollars",
                @"rate": @"0"
                }},
        @{@"HNL": @{
                @"symbol": @"HNL",
                @"name": @"Honduran Lempira",
                @"symbol_native": @"L",
                @"decimal_digits": @"2",
                @"rounding": @"0",
                @"code": @"HNL",
                @"name_plural": @"Honduran lempiras",
                @"rate": @"0"
                }},
        @{@"HRK": @{
                @"symbol": @"kn",
                @"name": @"Croatian Kuna",
                @"symbol_native": @"kn",
                @"decimal_digits": @"2",
                @"rounding": @"0",
                @"code": @"HRK",
                @"name_plural": @"Croatian kunas",
                @"rate": @"0"
                }},
        @{@"HUF": @{
                @"symbol": @"Ft",
                @"name": @"Hungarian Forint",
                @"symbol_native": @"Ft",
                @"decimal_digits": @"0",
                @"rounding": @"0",
                @"code": @"HUF",
                @"name_plural": @"Hungarian forints",
                @"rate": @"0"
                }},
        @{@"IDR": @{
                @"symbol": @"Rp",
                @"name": @"Indonesian Rupiah",
                @"symbol_native": @"Rp",
                @"decimal_digits": @"0",
                @"rounding": @"0",
                @"code": @"IDR",
                @"name_plural": @"Indonesian rupiahs",
                @"rate": @"0"
                }},
        @{@"ILS": @{
                @"symbol": @"₪",
                @"name": @"Israeli New Sheqel",
                @"symbol_native": @"₪",
                @"decimal_digits": @"2",
                @"rounding": @"0",
                @"code": @"ILS",
                @"name_plural": @"Israeli new sheqels",
                @"rate": @"0"
                }},
        @{@"INR": @{
                @"symbol": @"Rs",
                @"name": @"Indian Rupee",
                @"symbol_native": @"টকা",
                @"decimal_digits": @"2",
                @"rounding": @"0",
                @"code": @"INR",
                @"name_plural": @"Indian rupees",
                @"rate": @"0"
                }},
        @{@"IQD": @{
                @"symbol": @"IQD",
                @"name": @"Iraqi Dinar",
                @"symbol_native": @"د.ع.‏",
                @"decimal_digits": @"0",
                @"rounding": @"0",
                @"code": @"IQD",
                @"name_plural": @"Iraqi dinars",
                @"rate": @"0"
                }},
        @{@"IRR": @{
                @"symbol": @"IRR",
                @"name": @"Iranian Rial",
                @"symbol_native": @"﷼",
                @"decimal_digits": @"0",
                @"rounding": @"0",
                @"code": @"IRR",
                @"name_plural": @"Iranian rials",
                @"rate": @"0"
                }},
        @{@"ISK": @{
                @"symbol": @"Ikr",
                @"name": @"Icelandic Króna",
                @"symbol_native": @"kr",
                @"decimal_digits": @"0",
                @"rounding": @"0",
                @"code": @"ISK",
                @"name_plural": @"Icelandic krónur",
                @"rate": @"0"
                }},
        @{@"JMD": @{
                @"symbol": @"J$",
                @"name": @"Jamaican Dollar",
                @"symbol_native": @"$",
                @"decimal_digits": @"2",
                @"rounding": @"0",
                @"code": @"JMD",
                @"name_plural": @"Jamaican dollars",
                @"rate": @"0"
                }},
        @{@"JOD": @{
                @"symbol": @"JD",
                @"name": @"Jordanian Dinar",
                @"symbol_native": @"د.أ.‏",
                @"decimal_digits": @"3",
                @"rounding": @"0",
                @"code": @"JOD",
                @"name_plural": @"Jordanian dinars",
                @"rate": @"0"
                }},
        @{@"JPY": @{
                @"symbol": @"¥",
                @"name": @"Japanese Yen",
                @"symbol_native": @"￥",
                @"decimal_digits": @"0",
                @"rounding": @"0",
                @"code": @"JPY",
                @"name_plural": @"Japanese yen",
                @"rate": @"0"
                }},
        @{@"KES": @{
                @"symbol": @"Ksh",
                @"name": @"Kenyan Shilling",
                @"symbol_native": @"Ksh",
                @"decimal_digits": @"2",
                @"rounding": @"0",
                @"code": @"KES",
                @"name_plural": @"Kenyan shillings",
                @"rate": @"0"
                }},
        @{@"KHR": @{
                @"symbol": @"KHR",
                @"name": @"Cambodian Riel",
                @"symbol_native": @"៛",
                @"decimal_digits": @"2",
                @"rounding": @"0",
                @"code": @"KHR",
                @"name_plural": @"Cambodian riels",
                @"rate": @"0"
                }},
        @{@"KMF": @{
                @"symbol": @"CF",
                @"name": @"Comorian Franc",
                @"symbol_native": @"FC",
                @"decimal_digits": @"0",
                @"rounding": @"0",
                @"code": @"KMF",
                @"name_plural": @"Comorian francs",
                @"rate": @"0"
                }},
        @{@"KRW": @{
                @"symbol": @"₩",
                @"name": @"South Korean Won",
                @"symbol_native": @"₩",
                @"decimal_digits": @"0",
                @"rounding": @"0",
                @"code": @"KRW",
                @"name_plural": @"South Korean won",
                @"rate": @"0"
                }},
        @{@"KWD": @{
                @"symbol": @"KD",
                @"name": @"Kuwaiti Dinar",
                @"symbol_native": @"د.ك.‏",
                @"decimal_digits": @"3",
                @"rounding": @"0",
                @"code": @"KWD",
                @"name_plural": @"Kuwaiti dinars",
                @"rate": @"0"
                }},
        @{@"KZT": @{
                @"symbol": @"KZT",
                @"name": @"Kazakhstani Tenge",
                @"symbol_native": @"тңг.",
                @"decimal_digits": @"2",
                @"rounding": @"0",
                @"code": @"KZT",
                @"name_plural": @"Kazakhstani tenges",
                @"rate": @"0"
                }},
        @{@"LBP": @{
                @"symbol": @"L.L.",
                @"name": @"Lebanese Pound",
                @"symbol_native": @"ل.ل.‏",
                @"decimal_digits": @"0",
                @"rounding": @"0",
                @"code": @"LBP",
                @"name_plural": @"Lebanese pounds",
                @"rate": @"0"
                }},
        @{@"LKR": @{
                @"symbol": @"SLRs",
                @"name": @"Sri Lankan Rupee",
                @"symbol_native": @"SL Re",
                @"decimal_digits": @"2",
                @"rounding": @"0",
                @"code": @"LKR",
                @"name_plural": @"Sri Lankan rupees",
                @"rate": @"0"
                }},
        @{@"LYD": @{
                @"symbol": @"LD",
                @"name": @"Libyan Dinar",
                @"symbol_native": @"د.ل.‏",
                @"decimal_digits": @"3",
                @"rounding": @"0",
                @"code": @"LYD",
                @"name_plural": @"Libyan dinars",
                @"rate": @"0"
                }},
        @{@"MAD": @{
                @"symbol": @"MAD",
                @"name": @"Moroccan Dirham",
                @"symbol_native": @"د.م.‏",
                @"decimal_digits": @"2",
                @"rounding": @"0",
                @"code": @"MAD",
                @"name_plural": @"Moroccan dirhams",
                @"rate": @"0"
                }},
        @{@"MDL": @{
                @"symbol": @"MDL",
                @"name": @"Moldovan Leu",
                @"symbol_native": @"MDL",
                @"decimal_digits": @"2",
                @"rounding": @"0",
                @"code": @"MDL",
                @"name_plural": @"Moldovan lei",
                @"rate": @"0"
                }},
        @{@"MGA": @{
                @"symbol": @"MGA",
                @"name": @"Malagasy Ariary",
                @"symbol_native": @"MGA",
                @"decimal_digits": @"0",
                @"rounding": @"0",
                @"code": @"MGA",
                @"name_plural": @"Malagasy Ariaries",
                @"rate": @"0"
                }},
        @{@"MKD": @{
                @"symbol": @"MKD",
                @"name": @"Macedonian Denar",
                @"symbol_native": @"MKD",
                @"decimal_digits": @"2",
                @"rounding": @"0",
                @"code": @"MKD",
                @"name_plural": @"Macedonian denari",
                @"rate": @"0"
                }},
        @{@"MMK": @{
                @"symbol": @"MMK",
                @"name": @"Myanma Kyat",
                @"symbol_native": @"K",
                @"decimal_digits": @"0",
                @"rounding": @"0",
                @"code": @"MMK",
                @"name_plural": @"Myanma kyats",
                @"rate": @"0"
                }},
        @{@"MOP": @{
                @"symbol": @"MOP$",
                @"name": @"Macanese Pataca",
                @"symbol_native": @"MOP$",
                @"decimal_digits": @"2",
                @"rounding": @"0",
                @"code": @"MOP",
                @"name_plural": @"Macanese patacas",
                @"rate": @"0"
                }},
        @{@"MUR": @{
                @"symbol": @"MURs",
                @"name": @"Mauritian Rupee",
                @"symbol_native": @"MURs",
                @"decimal_digits": @"0",
                @"rounding": @"0",
                @"code": @"MUR",
                @"name_plural": @"Mauritian rupees",
                @"rate": @"0"
                }},
        @{@"MXN": @{
                @"symbol": @"MX$",
                @"name": @"Mexican Peso",
                @"symbol_native": @"$",
                @"decimal_digits": @"2",
                @"rounding": @"0",
                @"code": @"MXN",
                @"name_plural": @"Mexican pesos",
                @"rate": @"0"
                }},
        @{@"MYR": @{
                @"symbol": @"RM",
                @"name": @"Malaysian Ringgit",
                @"symbol_native": @"RM",
                @"decimal_digits": @"2",
                @"rounding": @"0",
                @"code": @"MYR",
                @"name_plural": @"Malaysian ringgits",
                @"rate": @"0"
                }},
        @{@"MZN": @{
                @"symbol": @"MTn",
                @"name": @"Mozambican Metical",
                @"symbol_native": @"MTn",
                @"decimal_digits": @"2",
                @"rounding": @"0",
                @"code": @"MZN",
                @"name_plural": @"Mozambican meticals",
                @"rate": @"0"
                }},
        @{@"NAD": @{
                @"symbol": @"N$",
                @"name": @"Namibian Dollar",
                @"symbol_native": @"N$",
                @"decimal_digits": @"2",
                @"rounding": @"0",
                @"code": @"NAD",
                @"name_plural": @"Namibian dollars",
                @"rate": @"0"
                }},
        @{@"NGN": @{
                @"symbol": @"₦",
                @"name": @"Nigerian Naira",
                @"symbol_native": @"₦",
                @"decimal_digits": @"2",
                @"rounding": @"0",
                @"code": @"NGN",
                @"name_plural": @"Nigerian nairas",
                @"rate": @"0"
                }},
        @{@"NIO": @{
                @"symbol": @"C$",
                @"name": @"Nicaraguan Córdoba",
                @"symbol_native": @"C$",
                @"decimal_digits": @"2",
                @"rounding": @"0",
                @"code": @"NIO",
                @"name_plural": @"Nicaraguan córdobas",
                @"rate": @"0"
                }},
        @{@"NOK": @{
                @"symbol": @"Nkr",
                @"name": @"Norwegian Krone",
                @"symbol_native": @"kr",
                @"decimal_digits": @"2",
                @"rounding": @"0",
                @"code": @"NOK",
                @"name_plural": @"Norwegian kroner",
                @"rate": @"0"
                }},
        @{@"NPR": @{
                @"symbol": @"NPRs",
                @"name": @"Nepalese Rupee",
                @"symbol_native": @"नेरू",
                @"decimal_digits": @"2",
                @"rounding": @"0",
                @"code": @"NPR",
                @"name_plural": @"Nepalese rupees",
                @"rate": @"0"
                }},
        @{@"NZD": @{
                @"symbol": @"NZ$",
                @"name": @"New Zealand Dollar",
                @"symbol_native": @"$",
                @"decimal_digits": @"2",
                @"rounding": @"0",
                @"code": @"NZD",
                @"name_plural": @"New Zealand dollars",
                @"rate": @"0"
                }},
        @{@"OMR": @{
                @"symbol": @"OMR",
                @"name": @"Omani Rial",
                @"symbol_native": @"ر.ع.‏",
                @"decimal_digits": @"3",
                @"rounding": @"0",
                @"code": @"OMR",
                @"name_plural": @"Omani rials",
                @"rate": @"0"
                }},
        @{@"PAB": @{
                @"symbol": @"B/.",
                @"name": @"Panamanian Balboa",
                @"symbol_native": @"B/.",
                @"decimal_digits": @"2",
                @"rounding": @"0",
                @"code": @"PAB",
                @"name_plural": @"Panamanian balboas",
                @"rate": @"0"
                }},
        @{@"PEN": @{
                @"symbol": @"S/.",
                @"name": @"Peruvian Nuevo Sol",
                @"symbol_native": @"S/.",
                @"decimal_digits": @"2",
                @"rounding": @"0",
                @"code": @"PEN",
                @"name_plural": @"Peruvian nuevos soles",
                @"rate": @"0"
                }},
        @{@"PHP": @{
                @"symbol": @"₱",
                @"name": @"Philippine Peso",
                @"symbol_native": @"₱",
                @"decimal_digits": @"2",
                @"rounding": @"0",
                @"code": @"PHP",
                @"name_plural": @"Philippine pesos",
                @"rate": @"0"
                }},
        @{@"PKR": @{
                @"symbol": @"PKRs",
                @"name": @"Pakistani Rupee",
                @"symbol_native": @"₨",
                @"decimal_digits": @"0",
                @"rounding": @"0",
                @"code": @"PKR",
                @"name_plural": @"Pakistani rupees",
                @"rate": @"0"
                }},
        @{@"PLN": @{
                @"symbol": @"zł",
                @"name": @"Polish Zloty",
                @"symbol_native": @"zł",
                @"decimal_digits": @"2",
                @"rounding": @"0",
                @"code": @"PLN",
                @"name_plural": @"Polish zlotys",
                @"rate": @"0"
                }},
        @{@"PYG": @{
                @"symbol": @"₲",
                @"name": @"Paraguayan Guarani",
                @"symbol_native": @"₲",
                @"decimal_digits": @"0",
                @"rounding": @"0",
                @"code": @"PYG",
                @"name_plural": @"Paraguayan guaranis",
                @"rate": @"0"
                }},
        @{@"QAR": @{
                @"symbol": @"QR",
                @"name": @"Qatari Rial",
                @"symbol_native": @"ر.ق.‏",
                @"decimal_digits": @"2",
                @"rounding": @"0",
                @"code": @"QAR",
                @"name_plural": @"Qatari rials",
                @"rate": @"0"
                }},
        @{@"RON": @{
                @"symbol": @"RON",
                @"name": @"Romanian Leu",
                @"symbol_native": @"RON",
                @"decimal_digits": @"2",
                @"rounding": @"0",
                @"code": @"RON",
                @"name_plural": @"Romanian lei",
                @"rate": @"0"
                }},
        @{@"RSD": @{
                @"symbol": @"din.",
                @"name": @"Serbian Dinar",
                @"symbol_native": @"дин.",
                @"decimal_digits": @"0",
                @"rounding": @"0",
                @"code": @"RSD",
                @"name_plural": @"Serbian dinars",
                @"rate": @"0"
                }},
        @{@"RUB": @{
                @"symbol": @"RUB",
                @"name": @"Russian Ruble",
                @"symbol_native": @"₽.",
                @"decimal_digits": @"2",
                @"rounding": @"0",
                @"code": @"RUB",
                @"name_plural": @"Russian rubles",
                @"rate": @"0"
                }},
        @{@"RWF": @{
                @"symbol": @"RWF",
                @"name": @"Rwandan Franc",
                @"symbol_native": @"FR",
                @"decimal_digits": @"0",
                @"rounding": @"0",
                @"code": @"RWF",
                @"name_plural": @"Rwandan francs",
                @"rate": @"0"
                }},
        @{@"SAR": @{
                @"symbol": @"SR",
                @"name": @"Saudi Riyal",
                @"symbol_native": @"ر.س.‏",
                @"decimal_digits": @"2",
                @"rounding": @"0",
                @"code": @"SAR",
                @"name_plural": @"Saudi riyals",
                @"rate": @"0"
                }},
        @{@"SDG": @{
                @"symbol": @"SDG",
                @"name": @"Sudanese Pound",
                @"symbol_native": @"SDG",
                @"decimal_digits": @"2",
                @"rounding": @"0",
                @"code": @"SDG",
                @"name_plural": @"Sudanese pounds",
                @"rate": @"0"
                }},
        @{@"SEK": @{
                @"symbol": @"Skr",
                @"name": @"Swedish Krona",
                @"symbol_native": @"kr",
                @"decimal_digits": @"2",
                @"rounding": @"0",
                @"code": @"SEK",
                @"name_plural": @"Swedish kronor",
                @"rate": @"0"
                }},
        @{@"SGD": @{
                @"symbol": @"S$",
                @"name": @"Singapore Dollar",
                @"symbol_native": @"$",
                @"decimal_digits": @"2",
                @"rounding": @"0",
                @"code": @"SGD",
                @"name_plural": @"Singapore dollars",
                @"rate": @"0"
                }},
        @{@"SOS": @{
                @"symbol": @"Ssh",
                @"name": @"Somali Shilling",
                @"symbol_native": @"Ssh",
                @"decimal_digits": @"0",
                @"rounding": @"0",
                @"code": @"SOS",
                @"name_plural": @"Somali shillings",
                @"rate": @"0"
                }},
        @{@"SYP": @{
                @"symbol": @"SY£",
                @"name": @"Syrian Pound",
                @"symbol_native": @"ل.س.‏",
                @"decimal_digits": @"0",
                @"rounding": @"0",
                @"code": @"SYP",
                @"name_plural": @"Syrian pounds",
                @"rate": @"0"
                }},
        @{@"THB": @{
                @"symbol": @"฿",
                @"name": @"Thai Baht",
                @"symbol_native": @"฿",
                @"decimal_digits": @"2",
                @"rounding": @"0",
                @"code": @"THB",
                @"name_plural": @"Thai baht",
                @"rate": @"0"
                }},
        @{@"TND": @{
                @"symbol": @"DT",
                @"name": @"Tunisian Dinar",
                @"symbol_native": @"د.ت.‏",
                @"decimal_digits": @"3",
                @"rounding": @"0",
                @"code": @"TND",
                @"name_plural": @"Tunisian dinars",
                @"rate": @"0"
                }},
        @{@"TOP": @{
                @"symbol": @"T$",
                @"name": @"Tongan Paʻanga",
                @"symbol_native": @"T$",
                @"decimal_digits": @"2",
                @"rounding": @"0",
                @"code": @"TOP",
                @"name_plural": @"Tongan paʻanga",
                @"rate": @"0"
                }},
        @{@"TRY": @{
                @"symbol": @"TL",
                @"name": @"Turkish Lira",
                @"symbol_native": @"TL",
                @"decimal_digits": @"2",
                @"rounding": @"0",
                @"code": @"TRY",
                @"name_plural": @"Turkish Lira",
                @"rate": @"0"
                }},
        @{@"TTD": @{
                @"symbol": @"TT$",
                @"name": @"Trinidad and Tobago Dollar",
                @"symbol_native": @"$",
                @"decimal_digits": @"2",
                @"rounding": @"0",
                @"code": @"TTD",
                @"name_plural": @"Trinidad and Tobago dollars",
                @"rate": @"0"
                }},
        @{@"TWD": @{
                @"symbol": @"NT$",
                @"name": @"New Taiwan Dollar",
                @"symbol_native": @"NT$",
                @"decimal_digits": @"2",
                @"rounding": @"0",
                @"code": @"TWD",
                @"name_plural": @"New Taiwan dollars",
                @"rate": @"0"
                }},
        @{@"TZS": @{
                @"symbol": @"TSh",
                @"name": @"Tanzanian Shilling",
                @"symbol_native": @"TSh",
                @"decimal_digits": @"0",
                @"rounding": @"0",
                @"code": @"TZS",
                @"name_plural": @"Tanzanian shillings",
                @"rate": @"0"
                }},
        @{@"UAH": @{
                @"symbol": @"₴",
                @"name": @"Ukrainian Hryvnia",
                @"symbol_native": @"₴",
                @"decimal_digits": @"2",
                @"rounding": @"0",
                @"code": @"UAH",
                @"name_plural": @"Ukrainian hryvnias",
                @"rate": @"0"
                }},
        @{@"UGX": @{
                @"symbol": @"USh",
                @"name": @"Ugandan Shilling",
                @"symbol_native": @"USh",
                @"decimal_digits": @"0",
                @"rounding": @"0",
                @"code": @"UGX",
                @"name_plural": @"Ugandan shillings",
                @"rate": @"0"
                }},
        @{@"UYU": @{
                @"symbol": @"$U",
                @"name": @"Uruguayan Peso",
                @"symbol_native": @"$",
                @"decimal_digits": @"2",
                @"rounding": @"0",
                @"code": @"UYU",
                @"name_plural": @"Uruguayan pesos",
                @"rate": @"0"
                }},
        @{@"UZS": @{
                @"symbol": @"UZS",
                @"name": @"Uzbekistan Som",
                @"symbol_native": @"UZS",
                @"decimal_digits": @"0",
                @"rounding": @"0",
                @"code": @"UZS",
                @"name_plural": @"Uzbekistan som",
                @"rate": @"0"
                }},
        @{@"VND": @{
                @"symbol": @"₫",
                @"name": @"Vietnamese Dong",
                @"symbol_native": @"₫",
                @"decimal_digits": @"0",
                @"rounding": @"0",
                @"code": @"VND",
                @"name_plural": @"Vietnamese dong",
                @"rate": @"0"
                }},
        @{@"XAF": @{
                @"symbol": @"FCFA",
                @"name": @"CFA Franc BEAC",
                @"symbol_native": @"FCFA",
                @"decimal_digits": @"0",
                @"rounding": @"0",
                @"code": @"XAF",
                @"name_plural": @"CFA francs BEAC",
                @"rate": @"0"
                }},
        @{@"XOF": @{
                @"symbol": @"CFA",
                @"name": @"CFA Franc BCEAO",
                @"symbol_native": @"CFA",
                @"decimal_digits": @"0",
                @"rounding": @"0",
                @"code": @"XOF",
                @"name_plural": @"CFA francs BCEAO",
                @"rate": @"0"
                }},
        @{@"YER": @{
                @"symbol": @"YR",
                @"name": @"Yemeni Rial",
                @"symbol_native": @"ر.ي.‏",
                @"decimal_digits": @"0",
                @"rounding": @"0",
                @"code": @"YER",
                @"name_plural": @"Yemeni rials",
                @"rate": @"0"
                }},
        @{@"ZAR": @{
                @"symbol": @"R",
                @"name": @"South African Rand",
                @"symbol_native": @"R",
                @"decimal_digits": @"2",
                @"rounding": @"0",
                @"code": @"ZAR",
                @"name_plural": @"South African rand",
                @"rate": @"0"
                }},
        @{@"ZWL": @{
                @"symbol": @"ZWL$",
                @"name": @"Zimbabwean Dollar",
                @"symbol_native": @"ZWL$",
                @"decimal_digits": @"0",
                @"rounding": @"0",
                @"code": @"ZWL",
                @"name_plural": @"Zimbabwean Dollar",
                @"rate": @"0"
        }}
        ];
    return symbole;;
}
+ (NSArray*)_Symbols {
    return [[NSArray alloc] initWithObjects:         @{
        @"Flag":@"https://www.currencyremitapp.com/wp-content//albania.png",
        @"CountryName": @"Kuwait",
        @"Currency": @"KWD",
        @"Code": @"KWD",
        @"Symbol": @"KD"
      },
            @{
              @"Flag": @"https://www.currencyremitapp.com/wp-content/themes/albania.png",
              @"CountryName": @"France",
              @"Currency": @"EUR",
              @"Code": @"EUR",
              @"Symbol": @"€"
            },
            @{
              @"Flag": @"https://www.currencyremitapp.com/wp-content/themes/albania.png",
              @"CountryName": @"Bahrain",
              @"Currency": @"BHD",
              @"Code": @"BHD",
              @"Symbol": @"BD"
            },
            @{
              @"Flag": @"https://www.currencyremitapp.com/wp-content/themes/albania.png",
              @"CountryName": @"United Arab Emirates",
              @"Currency": @"AED",
              @"Code": @"AED",
              @"Symbol": @"AED"
            },
    @{
        @"Flag": @"https://www.currencyremitapp.com/wp-content/themes/albania.png",
        @"CountryName": @"Palestine",
        @"Currency": @"JOD",
        @"Code": @"PLO",
        @"Symbol": @"JD"
        },
      @{
        @"Flag": @"https://www.currencyremitapp.com/wp-content/themes/albania.png",
        @"CountryName": @"Iraq",
        @"Currency": @"IRK",
        @"Code": @"IRK",
        @"Symbol": @"IRK"
      },
      @{
        @"Flag": @"https://www.currencyremitapp.com/wp-content/themes/currencyremitapp/images/countryimages/albania.png",
        @"CountryName": @"Jordan",
        @"Currency": @"JOD",
        @"Code": @"JOD",
        @"Symbol": @"JD"
      }, @{
        @"Flag": @"https://www.currencyremitapp.com/wp-content/themes/currencyremitapp/images/countryimages/albania.png",
        @"CountryName": @"Albania",
        @"Currency": @"Lek",
        @"Code": @"ALL",
        @"Symbol": @"Lek"
    },
    @{
        @"Flag": @"https://www.currencyremitapp.com/wp-content/themes/currencyremitapp/images/countryimages/afghanistan.png",
        @"CountryName": @"Afghanistan",
        @"Currency": @"Afghani",
        @"Code": @"AFN",
        @"Symbol": @"؋"
    },
    @{
        @"Flag": @"https://www.currencyremitapp.com/wp-content/themes/currencyremitapp/images/countryimages/argentina.png",
        @"CountryName": @"Argentina",
        @"Currency": @"Peso",
        @"Code": @"ARS",
        @"Symbol": @"$"
    },
    @{
        @"Flag": @"https://www.currencyremitapp.com/wp-content/themes/currencyremitapp/images/countryimages/aruba.png",
        @"CountryName": @"Aruba",
        @"Currency": @"Guilder",
        @"Code": @"AWG",
        @"Symbol": @"ƒ"
    },
    @{
        @"Flag": @"https://www.currencyremitapp.com/wp-content/themes/currencyremitapp/images/countryimages/australia.png",
        @"CountryName": @"Australia",
        @"Currency": @"Dollar",
        @"Code": @"AUD",
        @"Symbol": @"$"
    },
    @{
        @"Flag": @"https://www.currencyremitapp.com/wp-content/themes/currencyremitapp/images/countryimages/azerbaijan.png",
        @"CountryName": @"Azerbaijan",
        @"Currency": @"Manat",
        @"Code": @"AZN",
        @"Symbol": @"₼"
    },
    @{
        @"Flag": @"https://www.currencyremitapp.com/wp-content/themes/currencyremitapp/images/countryimages/bahamas.png",
        @"CountryName": @"Bahamas",
        @"Currency": @"Dollar",
        @"Code": @"BSD",
        @"Symbol": @"$"
    },
    @{
        @"Flag": @"https://www.currencyremitapp.com/wp-content/themes/currencyremitapp/images/countryimages/barbados.png",
        @"CountryName": @"Barbados",
        @"Currency": @"Dollar",
        @"Code": @"BBD",
        @"Symbol": @"$"
    },
    @{
        @"Flag": @"https://www.currencyremitapp.com/wp-content/themes/currencyremitapp/images/countryimages/belarus.png",
        @"CountryName": @"Belarus",
        @"Currency": @"Ruble",
        @"Code": @"BYR",
        @"Symbol": @"p."
    },
    @{
        @"Flag": @"https://www.currencyremitapp.com/wp-content/themes/currencyremitapp/images/countryimages/belize.png",
        @"CountryName": @"Belize",
        @"Currency": @"Dollar",
        @"Code": @"BZD",
        @"Symbol": @"BZ$"
    },
    @{
        @"Flag": @"https://www.currencyremitapp.com/wp-content/themes/currencyremitapp/images/countryimages/bermuda.png",
        @"CountryName": @"Bermuda",
        @"Currency": @"Dollar",
        @"Code": @"BMD",
        @"Symbol": @"$"
    },
    @{
        @"Flag": @"https://www.currencyremitapp.com/wp-content/themes/currencyremitapp/images/countryimages/bolivia.png",
        @"CountryName": @"Bolivia",
        @"Currency": @"Boliviano",
        @"Code": @"BOB",
        @"Symbol": @"$b"
    },
    @{
        @"Flag": @"https://www.currencyremitapp.com/wp-content/themes/currencyremitapp/images/countryimages/Bosnia_and_Herzegovina.png",
        @"CountryName": @"Bosnia and Herzegovina",
        @"Currency": @"Convertible Marka",
        @"Code": @"BAM",
        @"Symbol": @"KM"
    },
    @{
        @"Flag": @"https://www.currencyremitapp.com/wp-content/themes/currencyremitapp/images/countryimages/botswana.png",
        @"CountryName": @"Botswana",
        @"Currency": @"Pula",
        @"Code": @"BWP",
        @"Symbol": @"P"
    },
    @{
        @"Flag": @"https://www.currencyremitapp.com/wp-content/themes/currencyremitapp/images/countryimages/bulgaria.png",
        @"CountryName": @"Bulgaria",
        @"Currency": @"Lev",
        @"Code": @"BGN",
        @"Symbol": @"лв"
    },
    @{
        @"Flag": @"https://www.currencyremitapp.com/wp-content/themes/currencyremitapp/images/countryimages/brazil.png",
        @"CountryName": @"Brazil",
        @"Currency": @"Real",
        @"Code": @"BRL",
        @"Symbol": @"R$"
    },
    @{
        @"Flag": @"https://www.currencyremitapp.com/wp-content/themes/currencyremitapp/images/countryimages/brunei.png",
        @"CountryName": @"Brunei",
        @"Currency": @"Darussalam Dollar",
        @"Code": @"BND",
        @"Symbol": @"$"
    },
    @{
        @"Flag": @"https://www.currencyremitapp.com/wp-content/themes/currencyremitapp/images/countryimages/cambodia.png",
        @"CountryName": @"Cambodia",
        @"Currency": @"Riel",
        @"Code": @"KHR",
        @"Symbol": @"៛"
    },
    @{
        @"Flag": @"https://www.currencyremitapp.com/wp-content/themes/currencyremitapp/images/countryimages/canada.png",
        @"CountryName": @"Canada",
        @"Currency": @"Dollar",
        @"Code": @"CAD",
        @"Symbol": @"$"
    },
    @{
        @"Flag": @"https://www.currencyremitapp.com/wp-content/themes/currencyremitapp/images/countryimages/Cayman_Islands.png",
        @"CountryName": @"Cayman",
        @"Currency": @"Dollar",
        @"Code": @"KYD",
        @"Symbol": @"$"
    },
    @{
        @"Flag": @"https://www.currencyremitapp.com/wp-content/themes/currencyremitapp/images/countryimages/chile.png",
        @"CountryName": @"Chile",
        @"Currency": @"Peso",
        @"Code": @"CLP",
        @"Symbol": @"$"
    },
    @{
        @"Flag": @"https://www.currencyremitapp.com/wp-content/themes/currencyremitapp/images/countryimages/china.png",
        @"CountryName": @"China",
        @"Currency": @"Yuan Renminbi",
        @"Code": @"CNY",
        @"Symbol": @"¥"
    },
    @{
        @"Flag": @"https://www.currencyremitapp.com/wp-content/themes/currencyremitapp/images/countryimages/colombia.png",
        @"CountryName": @"Colombia",
        @"Currency": @"Peso",
        @"Code": @"COP",
        @"Symbol": @"$"
    },
    @{
        @"Flag": @"https://www.currencyremitapp.com/wp-content/themes/currencyremitapp/images/countryimages/costarica.png",
        @"CountryName": @"Costa Rica",
        @"Currency": @"Colon",
        @"Code": @"CRC",
        @"Symbol": @"₡"
    },
    @{
        @"Flag": @"https://www.currencyremitapp.com/wp-content/themes/currencyremitapp/images/countryimages/croatia.png",
        @"CountryName": @"Croatia",
        @"Currency": @"Kuna",
        @"Code": @"HRK",
        @"Symbol": @"kn"
    },
    @{
        @"Flag": @"https://www.currencyremitapp.com/wp-content/themes/currencyremitapp/images/countryimages/cuba.png",
        @"CountryName": @"Cuba",
        @"Currency": @"Peso",
        @"Code": @"CUP",
        @"Symbol": @"₱"
    },
    @{
        @"Flag": @"https://www.currencyremitapp.com/wp-content/themes/currencyremitapp/images/countryimages/czechrepublic.png",
        @"CountryName": @"Czech Republic",
        @"Currency": @"Koruna",
        @"Code": @"CZK",
        @"Symbol": @"Kč"
    },
    @{
        @"Flag": @"https://www.currencyremitapp.com/wp-content/themes/currencyremitapp/images/countryimages/denmark.png",
        @"CountryName": @"Denmark",
        @"Currency": @"Krone",
        @"Code": @"DKK",
        @"Symbol": @"kr"
    },
    @{
        @"Flag": @"https://www.currencyremitapp.com/wp-content/themes/currencyremitapp/images/countryimages/dominicanrepublic.png",
        @"CountryName": @"Dominican Republic",
        @"Currency": @"Peso",
        @"Code": @"DOP",
        @"Symbol": @"RD$"
    },
    @{
        @"Flag": @"https://www.currencyremitapp.com/wp-content/themes/currencyremitapp/images/countryimages/egypt.png",
        @"CountryName": @"Egypt",
        @"Currency": @"Pound",
        @"Code": @"EGP",
        @"Symbol": @"£"
    },
    @{
        @"Flag": @"https://www.currencyremitapp.com/wp-content/themes/currencyremitapp/images/countryimages/elsalvador.png",
        @"CountryName": @"El Salvador",
        @"Currency": @"Colon",
        @"Code": @"SVC",
        @"Symbol": @"$"
    },
    @{
        @"Flag": @"https://www.currencyremitapp.com/wp-content/themes/currencyremitapp/images/countryimages/estonia.png",
        @"CountryName": @"Estonia",
        @"Currency": @"Kroon",
        @"Code": @"EEK",
        @"Symbol": @"kr"
    },
    @{
        @"Flag": @"https://www.currencyremitapp.com/wp-content/themes/currencyremitapp/images/countryimages/euro.png",
        @"CountryName": @"Euro Member",
        @"Currency": @"Euro",
        @"Code": @"EUR",
        @"Symbol": @"€"
    },
    @{
        @"Flag": @"https://www.currencyremitapp.com/wp-content/themes/currencyremitapp/images/countryimages/falklandislands.png",
        @"CountryName": @"Falkland Islands",
        @"Currency": @"Pound",
        @"Code": @"FKP",
        @"Symbol": @"£"
    },
    @{
        @"Flag": @"https://www.currencyremitapp.com/wp-content/themes/currencyremitapp/images/countryimages/fiji.png",
        @"CountryName": @"Fiji",
        @"Currency": @"Dollar",
        @"Code": @"FJD",
        @"Symbol": @"$"
    },
    @{
        @"Flag": @"https://www.currencyremitapp.com/wp-content/themes/currencyremitapp/images/countryimages/georgia.png",
        @"CountryName": @"Georgia",
        @"Currency": @"Lari",
        @"Code": @"GEL",
        @"Symbol": @"₾"
    },
    @{
        @"Flag": @"https://www.currencyremitapp.com/wp-content/themes/currencyremitapp/images/countryimages/ghana.png",
        @"CountryName": @"Ghana",
        @"Currency": @"Cedis",
        @"Code": @"GHC",
        @"Symbol": @"¢"
    },
    @{
        @"Flag": @"https://www.currencyremitapp.com/wp-content/themes/currencyremitapp/images/countryimages/gibraltar.png",
        @"CountryName": @"Gibraltar",
        @"Currency": @"Pound",
        @"Code": @"GIP",
        @"Symbol": @"£"
    },
    @{
        @"Flag": @"https://www.currencyremitapp.com/wp-content/themes/currencyremitapp/images/countryimages/guatemala.png",
        @"CountryName": @"Guatemala",
        @"Currency": @"Quetzal",
        @"Code": @"GTQ",
        @"Symbol": @"Q"
    },
    @{
        @"Flag": @"https://www.currencyremitapp.com/wp-content/themes/currencyremitapp/images/countryimages/guernsey.png",
        @"CountryName": @"Guernsey",
        @"Currency": @"Pound",
        @"Code": @"GGP",
        @"Symbol": @"£"
    },
    @{
        @"Flag": @"https://www.currencyremitapp.com/wp-content/themes/currencyremitapp/images/countryimages/guyana.png",
        @"CountryName": @"Guyana",
        @"Currency": @"Dollar",
        @"Code": @"GYD",
        @"Symbol": @"$"
    },
    @{
        @"Flag": @"https://www.currencyremitapp.com/wp-content/themes/currencyremitapp/images/countryimages/honduras.png",
        @"CountryName": @"Honduras",
        @"Currency": @"Lempira",
        @"Code": @"HNL",
        @"Symbol": @"L"
    },
    @{
        @"Flag": @"https://www.currencyremitapp.com/wp-content/themes/currencyremitapp/images/countryimages/hongkong.png",
        @"CountryName": @"Hong Kong",
        @"Currency": @"Dollar",
        @"Code": @"HKD",
        @"Symbol": @"$"
    },
    @{
        @"Flag": @"https://www.currencyremitapp.com/wp-content/themes/currencyremitapp/images/countryimages/hungary.png",
        @"CountryName": @"Hungary",
        @"Currency": @"Forint",
        @"Code": @"HUF",
        @"Symbol": @"Ft"
    },
    @{
        @"Flag": @"https://www.currencyremitapp.com/wp-content/themes/currencyremitapp/images/countryimages/iceland.png",
        @"CountryName": @"Iceland",
        @"Currency": @"Krona",
        @"Code": @"ISK",
        @"Symbol": @"kr"
    },
    @{
        @"Flag": @"https://www.currencyremitapp.com/wp-content/themes/currencyremitapp/images/countryimages/india.png",
        @"CountryName": @"India",
        @"Currency": @"Rupee",
        @"Code": @"INR",
        @"Symbol": @"₹"
    },
    @{
        @"Flag": @"https://www.currencyremitapp.com/wp-content/themes/currencyremitapp/images/countryimages/indonesia.png",
        @"CountryName": @"Indonesia",
        @"Currency": @"Rupiah",
        @"Code": @"IDR",
        @"Symbol": @"Rp"
    },
    @{
        @"Flag": @"https://www.currencyremitapp.com/wp-content/themes/currencyremitapp/images/countryimages/iran.png",
        @"CountryName": @"Iran",
        @"Currency": @"Rial",
        @"Code": @"IRR",
        @"Symbol": @"﷼"
    },
    @{
        @"Flag": @"https://www.currencyremitapp.com/wp-content/themes/currencyremitapp/images/countryimages/isleofman.png",
        @"CountryName": @"Isle of Man",
        @"Currency": @"Pound",
        @"Code": @"IMP",
        @"Symbol": @"£"
    },
    @{
        @"Flag": @"https://www.currencyremitapp.com/wp-content/themes/currencyremitapp/images/countryimages/israel.png",
        @"CountryName": @"Israel",
        @"Currency": @"Shekel",
        @"Code": @"ILS",
        @"Symbol": @"₪"
    },
    @{
        @"Flag": @"https://www.currencyremitapp.com/wp-content/themes/currencyremitapp/images/countryimages/jamaica.png",
        @"CountryName": @"Jamaica",
        @"Currency": @"Dollar",
        @"Code": @"JMD",
        @"Symbol": @"J$"
    },
    @{
        @"Flag": @"https://www.currencyremitapp.com/wp-content/themes/currencyremitapp/images/countryimages/japan.png",
        @"CountryName": @"Japan",
        @"Currency": @"Yen",
        @"Code": @"JPY",
        @"Symbol": @"¥"
    },
    @{
        @"Flag": @"https://www.currencyremitapp.com/wp-content/themes/currencyremitapp/images/countryimages/jersey.png",
        @"CountryName": @"Jersey",
        @"Currency": @"Pound",
        @"Code": @"JEP",
        @"Symbol": @"£"
    },
    @{
        @"Flag": @"https://www.currencyremitapp.com/wp-content/themes/currencyremitapp/images/countryimages/kazakhstan.png",
        @"CountryName": @"Kazakhstan",
        @"Currency": @"Tenge",
        @"Code": @"KZT",
        @"Symbol": @"лв"
    },
    @{
        @"Flag": @"https://www.currencyremitapp.com/wp-content/themes/currencyremitapp/images/countryimages/northkorea.png",
        @"CountryName": @"Korea (North)",
        @"Currency": @"Won",
        @"Code": @"KPW",
        @"Symbol": @"₩"
    },
    @{
        @"Flag": @"https://www.currencyremitapp.com/wp-content/themes/currencyremitapp/images/countryimages/southkorea.png",
        @"CountryName": @"Korea (South)",
        @"Currency": @"Won",
        @"Code": @"KRW",
        @"Symbol": @"₩"
    },
    @{
        @"Flag": @"https://www.currencyremitapp.com/wp-content/themes/currencyremitapp/images/countryimages/kyrgyzstan.png",
        @"CountryName": @"Kyrgyzstan",
        @"Currency": @"Som",
        @"Code": @"KGS",
        @"Symbol": @"лв"
    },
    @{
        @"Flag": @"https://www.currencyremitapp.com/wp-content/themes/currencyremitapp/images/countryimages/laos.png",
        @"CountryName": @"Laos",
        @"Currency": @"Kip",
        @"Code": @"LAK",
        @"Symbol": @"₭"
    },
    @{
        @"Flag": @"https://www.currencyremitapp.com/wp-content/themes/currencyremitapp/images/countryimages/latvia.png",
        @"CountryName": @"Latvia",
        @"Currency": @"Lat",
        @"Code": @"LVL",
        @"Symbol": @"Ls"
    },
    @{
        @"Flag": @"https://www.currencyremitapp.com/wp-content/themes/currencyremitapp/images/countryimages/lebanon.png",
        @"CountryName": @"Lebanon",
        @"Currency": @"Pound",
        @"Code": @"LBP",
        @"Symbol": @"£"
    },
    @{
        @"Flag": @"https://www.currencyremitapp.com/wp-content/themes/currencyremitapp/images/countryimages/liberia.png",
        @"CountryName": @"Liberia",
        @"Currency": @"Dollar",
        @"Code": @"LRD",
        @"Symbol": @"$"
    },
    @{
        @"Flag": @"https://www.currencyremitapp.com/wp-content/themes/currencyremitapp/images/countryimages/lithuania.png",
        @"CountryName": @"Lithuania",
        @"Currency": @"Litas",
        @"Code": @"LTL",
        @"Symbol": @"Lt"
    },
    @{
        @"Flag": @"https://www.currencyremitapp.com/wp-content/themes/currencyremitapp/images/countryimages/macedonia.png",
        @"CountryName": @"Macedonia",
        @"Currency": @"Denar",
        @"Code": @"MKD",
        @"Symbol": @"ден"
    },
    @{
        @"Flag": @"https://www.currencyremitapp.com/wp-content/themes/currencyremitapp/images/countryimages/malaysia.png",
        @"CountryName": @"Malaysia",
        @"Currency": @"Ringgit",
        @"Code": @"MYR",
        @"Symbol": @"RM"
    },
    @{
        @"Flag": @"https://www.currencyremitapp.com/wp-content/themes/currencyremitapp/images/countryimages/mauritius.png",
        @"CountryName": @"Mauritius",
        @"Currency": @"Rupee",
        @"Code": @"MUR",
        @"Symbol": @"₨"
    },
    @{
        @"Flag": @"https://www.currencyremitapp.com/wp-content/themes/currencyremitapp/images/countryimages/mexico.png",
        @"CountryName": @"Mexico",
        @"Currency": @"Peso",
        @"Code": @"MXN",
        @"Symbol": @"$"
    },
    @{
        @"Flag": @"https://www.currencyremitapp.com/wp-content/themes/currencyremitapp/images/countryimages/mongolia.png",
        @"CountryName": @"Mongolia",
        @"Currency": @"Tughrik",
        @"Code": @"MNT",
        @"Symbol": @"₮"
    },
    @{
        @"Flag": @"https://www.currencyremitapp.com/wp-content/themes/currencyremitapp/images/countryimages/mozambique.png",
        @"CountryName": @"Mozambique",
        @"Currency": @"Metical",
        @"Code": @"MZN",
        @"Symbol": @"MT"
    },
    @{
        @"Flag": @"https://www.currencyremitapp.com/wp-content/themes/currencyremitapp/images/countryimages/namibia.png",
        @"CountryName": @"Namibia",
        @"Currency": @"Dollar",
        @"Code": @"NAD",
        @"Symbol": @"$"
    },
    @{
        @"Flag": @"https://www.currencyremitapp.com/wp-content/themes/currencyremitapp/images/countryimages/nepal.png",
        @"CountryName": @"Nepal",
        @"Currency": @"Rupee",
        @"Code": @"NPR",
        @"Symbol": @"₨"
    },
    @{
        @"Flag": @"https://www.currencyremitapp.com/wp-content/themes/currencyremitapp/images/countryimages/netherlands.png",
        @"CountryName": @"Netherlands",
        @"Currency": @"Antilles Guilder",
        @"Code": @"ANG",
        @"Symbol": @"ƒ"
    },
    @{
        @"Flag": @"https://www.currencyremitapp.com/wp-content/themes/currencyremitapp/images/countryimages/newzealand.png",
        @"CountryName": @"New Zealand",
        @"Currency": @"Dollar",
        @"Code": @"NZD",
        @"Symbol": @"$"
    },
    @{
        @"Flag": @"https://www.currencyremitapp.com/wp-content/themes/currencyremitapp/images/countryimages/nicaragua.png",
        @"CountryName": @"Nicaragua",
        @"Currency": @"Cordoba",
        @"Code": @"NIO",
        @"Symbol": @"C$"
    },
    @{
        @"Flag": @"https://www.currencyremitapp.com/wp-content/themes/currencyremitapp/images/countryimages/nigeria.png",
        @"CountryName": @"Nigeria",
        @"Currency": @"Naira",
        @"Code": @"NGN",
        @"Symbol": @"₦"
    },
    @{
        @"Flag": @"https://www.currencyremitapp.com/wp-content/themes/currencyremitapp/images/countryimages/norway.png",
        @"CountryName": @"Norway",
        @"Currency": @"Krone",
        @"Code": @"NOK",
        @"Symbol": @"kr"
    },
    @{
        @"Flag": @"https://www.currencyremitapp.com/wp-content/themes/currencyremitapp/images/countryimages/oman.png",
        @"CountryName": @"Oman",
        @"Currency": @"Rial",
        @"Code": @"OMR",
        @"Symbol": @"﷼"
    },
    @{
        @"Flag": @"https://www.currencyremitapp.com/wp-content/themes/currencyremitapp/images/countryimages/pakistan.png",
        @"CountryName": @"Pakistan",
        @"Currency": @"Rupee",
        @"Code": @"PKR",
        @"Symbol": @"₨"
    },
    @{
        @"Flag": @"https://www.currencyremitapp.com/wp-content/themes/currencyremitapp/images/countryimages/panama.png",
        @"CountryName": @"Panama",
        @"Currency": @"Balboa",
        @"Code": @"PAB",
        @"Symbol": @"B/."
    },
    @{
        @"Flag": @"https://www.currencyremitapp.com/wp-content/themes/currencyremitapp/images/countryimages/paraguay.png",
        @"CountryName": @"Paraguay",
        @"Currency": @"Guarani",
        @"Code": @"PYG",
        @"Symbol": @"Gs"
    },
    @{
        @"Flag": @"https://www.currencyremitapp.com/wp-content/themes/currencyremitapp/images/countryimages/peru.png",
        @"CountryName": @"Peru",
        @"Currency": @"Nuevo Sol",
        @"Code": @"PEN",
        @"Symbol": @"S/."
    },
    @{
        @"Flag": @"https://www.currencyremitapp.com/wp-content/themes/currencyremitapp/images/countryimages/philippines.png",
        @"CountryName": @"Philippines",
        @"Currency": @"Peso",
        @"Code": @"PHP",
        @"Symbol": @"₱"
    },
    @{
        @"Flag": @"https://www.currencyremitapp.com/wp-content/themes/currencyremitapp/images/countryimages/poland.png",
        @"CountryName": @"Poland",
        @"Currency": @"Zloty",
        @"Code": @"PLN",
        @"Symbol": @"zł"
    },
    @{
        @"Flag": @"https://www.currencyremitapp.com/wp-content/themes/currencyremitapp/images/countryimages/qatar.png",
        @"CountryName": @"Qatar",
        @"Currency": @"Riyal",
        @"Code": @"QAR",
        @"Symbol": @"﷼"
    },
    @{
        @"Flag": @"https://www.currencyremitapp.com/wp-content/themes/currencyremitapp/images/countryimages/romania.png",
        @"CountryName": @"Romania",
        @"Currency": @"New Leu",
        @"Code": @"RON",
        @"Symbol": @"lei"
    },
    @{
        @"Flag": @"https://www.currencyremitapp.com/wp-content/themes/currencyremitapp/images/countryimages/russia.png",
        @"CountryName": @"Russia",
        @"Currency": @"Ruble",
        @"Code": @"RUB",
        @"Symbol": @"₽"
    },
    @{
        @"Flag": @"https://www.currencyremitapp.com/wp-content/themes/currencyremitapp/images/countryimages/sainthelena.png",
        @"CountryName": @"Saint Helena",
        @"Currency": @"Pound",
        @"Code": @"SHP",
        @"Symbol": @"£"
    },
    @{
        @"Flag": @"https://www.currencyremitapp.com/wp-content/themes/currencyremitapp/images/countryimages/saudiarabia.png",
        @"CountryName": @"Saudi Arabia",
        @"Currency": @"Riyal",
        @"Code": @"SAR",
        @"Symbol": @"﷼"
    },
    @{
        @"Flag": @"https://www.currencyremitapp.com/wp-content/themes/currencyremitapp/images/countryimages/serbia.png",
        @"CountryName": @"Serbia",
        @"Currency": @"Dinar",
        @"Code": @"RSD",
        @"Symbol": @"Дин."
    },
    @{
        @"Flag": @"https://www.currencyremitapp.com/wp-content/themes/currencyremitapp/images/countryimages/seychelles.png",
        @"CountryName": @"Seychelles",
        @"Currency": @"Rupee",
        @"Code": @"SCR",
        @"Symbol": @"₨"
    },
    @{
        @"Flag": @"https://www.currencyremitapp.com/wp-content/themes/currencyremitapp/images/countryimages/singapore.png",
        @"CountryName": @"Singapore",
        @"Currency": @"Dollar",
        @"Code": @"SGD",
        @"Symbol": @"$"
    },
    @{
        @"Flag": @"https://www.currencyremitapp.com/wp-content/themes/currencyremitapp/images/countryimages/solomonislands.png",
        @"CountryName": @"Solomon Islands",
        @"Currency": @"Dollar",
        @"Code": @"SBD",
        @"Symbol": @"$"
    },
    @{
        @"Flag": @"https://www.currencyremitapp.com/wp-content/themes/currencyremitapp/images/countryimages/somalia.png",
        @"CountryName": @"Somalia",
        @"Currency": @"Shilling",
        @"Code": @"SOS",
        @"Symbol": @"S"
    },
    @{
        @"Flag": @"https://www.currencyremitapp.com/wp-content/themes/currencyremitapp/images/countryimages/southafrica.png",
        @"CountryName": @"South Africa",
        @"Currency": @"Rand",
        @"Code": @"ZAR",
        @"Symbol": @"R"
    },
    @{
        @"Flag": @"https://www.currencyremitapp.com/wp-content/themes/currencyremitapp/images/countryimages/srilanka.png",
        @"CountryName": @"Sri Lanka",
        @"Currency": @"Rupee",
        @"Code": @"LKR",
        @"Symbol": @"₨"
    },
    @{
        @"Flag": @"https://www.currencyremitapp.com/wp-content/themes/currencyremitapp/images/countryimages/sweden.png",
        @"CountryName": @"Sweden",
        @"Currency": @"Krona",
        @"Code": @"SEK",
        @"Symbol": @"kr"
    },
    @{
        @"Flag": @"https://www.currencyremitapp.com/wp-content/themes/currencyremitapp/images/countryimages/switzerland.png",
        @"CountryName": @"Switzerland",
        @"Currency": @"Franc",
        @"Code": @"CHF",
        @"Symbol": @"CHF"
    },
    @{
        @"Flag": @"https://www.currencyremitapp.com/wp-content/themes/currencyremitapp/images/countryimages/suriname.png",
        @"CountryName": @"Suriname",
        @"Currency": @"Dollar",
        @"Code": @"SRD",
        @"Symbol": @"$"
    },
    @{
        @"Flag": @"https://www.currencyremitapp.com/wp-content/themes/currencyremitapp/images/countryimages/syria.png",
        @"CountryName": @"Syria",
        @"Currency": @"Pound",
        @"Code": @"SYP",
        @"Symbol": @"£"
    },
    @{
        @"Flag": @"https://www.currencyremitapp.com/wp-content/themes/currencyremitapp/images/countryimages/taiwan.png",
        @"CountryName": @"Taiwan",
        @"Currency": @"New Dollar",
        @"Code": @"TWD",
        @"Symbol": @"NT$"
    },
    @{
        @"Flag": @"https://www.currencyremitapp.com/wp-content/themes/currencyremitapp/images/countryimages/thailand.png",
        @"CountryName": @"Thailand",
        @"Currency": @"Baht",
        @"Code": @"THB",
        @"Symbol": @"฿"
    },
    @{
        @"Flag": @"https://www.currencyremitapp.com/wp-content/themes/currencyremitapp/images/countryimages/trinidadandtobago.png",
        @"CountryName": @"Trinidad and Tobago",
        @"Currency": @"Dollar",
        @"Code": @"TTD",
        @"Symbol": @"TT$"
    },
    @{
        @"Flag": @"https://www.currencyremitapp.com/wp-content/themes/currencyremitapp/images/countryimages/turkey.png",
        @"CountryName": @"Turkey",
        @"Currency": @"Lira",
        @"Code": @"TRL",
        @"Symbol": @"₺"
    },
    @{
        @"Flag": @"https://www.currencyremitapp.com/wp-content/themes/currencyremitapp/images/countryimages/tuvalu.png",
        @"CountryName": @"Tuvalu",
        @"Currency": @"Dollar",
        @"Code": @"TVD",
        @"Symbol": @"$"
    },
    @{
        @"Flag": @"https://www.currencyremitapp.com/wp-content/themes/currencyremitapp/images/countryimages/ukraine.png",
        @"CountryName": @"Ukraine",
        @"Currency": @"Hryvna",
        @"Code": @"UAH",
        @"Symbol": @"₴"
    },
    @{
        @"Flag": @"https://www.currencyremitapp.com/wp-content/themes/currencyremitapp/images/countryimages/unitedkingdom.png",
        @"CountryName": @"United Kingdom",
        @"Currency": @"Pound",
        @"Code": @"GBP",
        @"Symbol": @"£"
    },
    @{
        @"Flag": @"https://www.currencyremitapp.com/wp-content/themes/currencyremitapp/images/countryimages/unitedstates.png",
        @"CountryName": @"United States",
        @"Currency": @"Dollar",
        @"Code": @"USD",
        @"Symbol": @"$"
    },
    @{
        @"Flag": @"https://www.currencyremitapp.com/wp-content/themes/currencyremitapp/images/countryimages/uruguay.png",
        @"CountryName": @"Uruguay",
        @"Currency": @"Peso",
        @"Code": @"UYU",
        @"Symbol": @"$U"
    },
    @{
        @"Flag": @"https://www.currencyremitapp.com/wp-content/themes/currencyremitapp/images/countryimages/uzbekistan.png",
        @"CountryName": @"Uzbekistan",
        @"Currency": @"Som",
        @"Code": @"UZS",
        @"Symbol": @"лв"
    },
    @{
        @"Flag": @"https://www.currencyremitapp.com/wp-content/themes/currencyremitapp/images/countryimages/venezuela.png",
        @"CountryName": @"Venezuela",
        @"Currency": @"Bolivar Fuerte",
        @"Code": @"VEF",
        @"Symbol": @"Bs"
    },
    @{
        @"Flag": @"https://www.currencyremitapp.com/wp-content/themes/currencyremitapp/images/countryimages/vietnam.png",
        @"CountryName": @"Viet Nam",
        @"Currency": @"Dong",
        @"Code": @"VND",
        @"Symbol": @"₫"
    },
    @{
        @"Flag": @"https://www.currencyremitapp.com/wp-content/themes/currencyremitapp/images/countryimages/yemen.png",
        @"CountryName": @"Yemen",
        @"Currency": @"Rial",
        @"Code": @"YER",
        @"Symbol": @"﷼"
    },
    @{
        @"Flag": @"https://www.currencyremitapp.com/wp-content/themes/currencyremitapp/images/countryimages/zimbabwe.png",
        @"CountryName": @"Zimbabwe",
        @"Currency": @"Dollar",
        @"Code": @"ZWD",
        @"Symbol": @"Z$"
    }, nil];
}
+ (NSArray*)Countries {
    return [[NSArray alloc] initWithObjects:       @{
        @"countryCode": @"AD",
        @"countryName": @"Andorra",
        @"currencyCode": @"EUR",
        @"population": @"84000",
        @"capital": @"Andorra la Vella",
        @"continentName": @"Europe"
    },
    @{
        @"countryCode": @"AE",
        @"countryName": @"United Arab Emirates",
        @"currencyCode": @"AED",
        @"population": @"4975593",
        @"capital": @"Abu Dhabi",
        @"continentName": @"Asia"
    },
    @{
        @"countryCode": @"AF",
        @"countryName": @"Afghanistan",
        @"currencyCode": @"AFN",
        @"population": @"29121286",
        @"capital": @"Kabul",
        @"continentName": @"Asia"
    },
    @{
        @"countryCode": @"AG",
        @"countryName": @"Antigua and Barbuda",
        @"currencyCode": @"XCD",
        @"population": @"86754",
        @"capital": @"St. John's",
        @"continentName": @"North America"
    },
    @{
        @"countryCode": @"AI",
        @"countryName": @"Anguilla",
        @"currencyCode": @"XCD",
        @"population": @"13254",
        @"capital": @"The Valley",
        @"continentName": @"North America"
    },
    @{
        @"countryCode": @"AL",
        @"countryName": @"Albania",
        @"currencyCode": @"ALL",
        @"population": @"2986952",
        @"capital": @"Tirana",
        @"continentName": @"Europe"
    },
    @{
        @"countryCode": @"AM",
        @"countryName": @"Armenia",
        @"currencyCode": @"AMD",
        @"population": @"2968000",
        @"capital": @"Yerevan",
        @"continentName": @"Asia"
    },
    @{
        @"countryCode": @"AO",
        @"countryName": @"Angola",
        @"currencyCode": @"AOA",
        @"population": @"13068161",
        @"capital": @"Luanda",
        @"continentName": @"Africa"
    },
    @{
        @"countryCode": @"AQ",
        @"countryName": @"Antarctica",
        @"currencyCode": @"",
        @"population": @"0",
        @"capital": @"",
        @"continentName": @"Antarctica"
    },
    @{
        @"countryCode": @"AR",
        @"countryName": @"Argentina",
        @"currencyCode": @"ARS",
        @"population": @"41343201",
        @"capital": @"Buenos Aires",
        @"continentName": @"South America"
    },
    @{
        @"countryCode": @"AS",
        @"countryName": @"American Samoa",
        @"currencyCode": @"USD",
        @"population": @"57881",
        @"capital": @"Pago Pago",
        @"continentName": @"Oceania"
    },
    @{
        @"countryCode": @"AT",
        @"countryName": @"Austria",
        @"currencyCode": @"EUR",
        @"population": @"8205000",
        @"capital": @"Vienna",
        @"continentName": @"Europe"
    },
    @{
        @"countryCode": @"AU",
        @"countryName": @"Australia",
        @"currencyCode": @"AUD",
        @"population": @"21515754",
        @"capital": @"Canberra",
        @"continentName": @"Oceania"
    },
    @{
        @"countryCode": @"AW",
        @"countryName": @"Aruba",
        @"currencyCode": @"AWG",
        @"population": @"71566",
        @"capital": @"Oranjestad",
        @"continentName": @"North America"
    },
    @{
        @"countryCode": @"AX",
        @"countryName": @"Åland",
        @"currencyCode": @"EUR",
        @"population": @"26711",
        @"capital": @"Mariehamn",
        @"continentName": @"Europe"
    },
    @{
        @"countryCode": @"AZ",
        @"countryName": @"Azerbaijan",
        @"currencyCode": @"AZN",
        @"population": @"8303512",
        @"capital": @"Baku",
        @"continentName": @"Asia"
    },
    @{
        @"countryCode": @"BA",
        @"countryName": @"Bosnia and Herzegovina",
        @"currencyCode": @"BAM",
        @"population": @"4590000",
        @"capital": @"Sarajevo",
        @"continentName": @"Europe"
    },
    @{
        @"countryCode": @"BB",
        @"countryName": @"Barbados",
        @"currencyCode": @"BBD",
        @"population": @"285653",
        @"capital": @"Bridgetown",
        @"continentName": @"North America"
    },
    @{
        @"countryCode": @"BD",
        @"countryName": @"Bangladesh",
        @"currencyCode": @"BDT",
        @"population": @"156118464",
        @"capital": @"Dhaka",
        @"continentName": @"Asia"
    },
    @{
        @"countryCode": @"BE",
        @"countryName": @"Belgium",
        @"currencyCode": @"EUR",
        @"population": @"10403000",
        @"capital": @"Brussels",
        @"continentName": @"Europe"
    },
    @{
        @"countryCode": @"BF",
        @"countryName": @"Burkina Faso",
        @"currencyCode": @"XOF",
        @"population": @"16241811",
        @"capital": @"Ouagadougou",
        @"continentName": @"Africa"
    },
    @{
        @"countryCode": @"BG",
        @"countryName": @"Bulgaria",
        @"currencyCode": @"BGN",
        @"population": @"7148785",
        @"capital": @"Sofia",
        @"continentName": @"Europe"
    },
    @{
        @"countryCode": @"BH",
        @"countryName": @"Bahrain",
        @"currencyCode": @"BHD",
        @"population": @"738004",
        @"capital": @"Manama",
        @"continentName": @"Asia"
    },
    @{
        @"countryCode": @"BI",
        @"countryName": @"Burundi",
        @"currencyCode": @"BIF",
        @"population": @"9863117",
        @"capital": @"Bujumbura",
        @"continentName": @"Africa"
    },
    @{
        @"countryCode": @"BJ",
        @"countryName": @"Benin",
        @"currencyCode": @"XOF",
        @"population": @"9056010",
        @"capital": @"Porto-Novo",
        @"continentName": @"Africa"
    },
    @{
        @"countryCode": @"BL",
        @"countryName": @"Saint Barthélemy",
        @"currencyCode": @"EUR",
        @"population": @"8450",
        @"capital": @"Gustavia",
        @"continentName": @"North America"
    },
    @{
        @"countryCode": @"BM",
        @"countryName": @"Bermuda",
        @"currencyCode": @"BMD",
        @"population": @"65365",
        @"capital": @"Hamilton",
        @"continentName": @"North America"
    },
    @{
        @"countryCode": @"BN",
        @"countryName": @"Brunei",
        @"currencyCode": @"BND",
        @"population": @"395027",
        @"capital": @"Bandar Seri Begawan",
        @"continentName": @"Asia"
    },
    @{
        @"countryCode": @"BO",
        @"countryName": @"Bolivia",
        @"currencyCode": @"BOB",
        @"population": @"9947418",
        @"capital": @"Sucre",
        @"continentName": @"South America"
    },
    @{
        @"countryCode": @"BQ",
        @"countryName": @"Bonaire",
        @"currencyCode": @"USD",
        @"population": @"18012",
        @"capital": @"Kralendijk",
        @"continentName": @"North America"
    },
    @{
        @"countryCode": @"BR",
        @"countryName": @"Brazil",
        @"currencyCode": @"BRL",
        @"population": @"201103330",
        @"capital": @"Brasília",
        @"continentName": @"South America"
    },
    @{
        @"countryCode": @"BS",
        @"countryName": @"Bahamas",
        @"currencyCode": @"BSD",
        @"population": @"301790",
        @"capital": @"Nassau",
        @"continentName": @"North America"
    },
    @{
        @"countryCode": @"BT",
        @"countryName": @"Bhutan",
        @"currencyCode": @"BTN",
        @"population": @"699847",
        @"capital": @"Thimphu",
        @"continentName": @"Asia"
    },
    @{
        @"countryCode": @"BV",
        @"countryName": @"Bouvet Island",
        @"currencyCode": @"NOK",
        @"population": @"0",
        @"capital": @"",
        @"continentName": @"Antarctica"
    },
    @{
        @"countryCode": @"BW",
        @"countryName": @"Botswana",
        @"currencyCode": @"BWP",
        @"population": @"2029307",
        @"capital": @"Gaborone",
        @"continentName": @"Africa"
    },
    @{
        @"countryCode": @"BY",
        @"countryName": @"Belarus",
        @"currencyCode": @"BYR",
        @"population": @"9685000",
        @"capital": @"Minsk",
        @"continentName": @"Europe"
    },
    @{
        @"countryCode": @"BZ",
        @"countryName": @"Belize",
        @"currencyCode": @"BZD",
        @"population": @"314522",
        @"capital": @"Belmopan",
        @"continentName": @"North America"
    },
    @{
        @"countryCode": @"CA",
        @"countryName": @"Canada",
        @"currencyCode": @"CAD",
        @"population": @"33679000",
        @"capital": @"Ottawa",
        @"continentName": @"North America"
    },
    @{
        @"countryCode": @"CC",
        @"countryName": @"Cocos [Keeling] Islands",
        @"currencyCode": @"AUD",
        @"population": @"628",
        @"capital": @"West Island",
        @"continentName": @"Asia"
    },
    @{
        @"countryCode": @"CD",
        @"countryName": @"Democratic Republic of the Congo",
        @"currencyCode": @"CDF",
        @"population": @"70916439",
        @"capital": @"Kinshasa",
        @"continentName": @"Africa"
    },
    @{
        @"countryCode": @"CF",
        @"countryName": @"Central African Republic",
        @"currencyCode": @"XAF",
        @"population": @"4844927",
        @"capital": @"Bangui",
        @"continentName": @"Africa"
    },
    @{
        @"countryCode": @"CG",
        @"countryName": @"Republic of the Congo",
        @"currencyCode": @"XAF",
        @"population": @"3039126",
        @"capital": @"Brazzaville",
        @"continentName": @"Africa"
    },
    @{
        @"countryCode": @"CH",
        @"countryName": @"Switzerland",
        @"currencyCode": @"CHF",
        @"population": @"7581000",
        @"capital": @"Bern",
        @"continentName": @"Europe"
    },
    @{
        @"countryCode": @"CI",
        @"countryName": @"Ivory Coast",
        @"currencyCode": @"XOF",
        @"population": @"21058798",
        @"capital": @"Yamoussoukro",
        @"continentName": @"Africa"
    },
    @{
        @"countryCode": @"CK",
        @"countryName": @"Cook Islands",
        @"currencyCode": @"NZD",
        @"population": @"21388",
        @"capital": @"Avarua",
        @"continentName": @"Oceania"
    },
    @{
        @"countryCode": @"CL",
        @"countryName": @"Chile",
        @"currencyCode": @"CLP",
        @"population": @"16746491",
        @"capital": @"Santiago",
        @"continentName": @"South America"
    },
    @{
        @"countryCode": @"CM",
        @"countryName": @"Cameroon",
        @"currencyCode": @"XAF",
        @"population": @"19294149",
        @"capital": @"Yaoundé",
        @"continentName": @"Africa"
    },
    @{
        @"countryCode": @"CN",
        @"countryName": @"China",
        @"currencyCode": @"CNY",
        @"population": @"1330044000",
        @"capital": @"Beijing",
        @"continentName": @"Asia"
    },
    @{
        @"countryCode": @"CO",
        @"countryName": @"Colombia",
        @"currencyCode": @"COP",
        @"population": @"47790000",
        @"capital": @"Bogotá",
        @"continentName": @"South America"
    },
    @{
        @"countryCode": @"CR",
        @"countryName": @"Costa Rica",
        @"currencyCode": @"CRC",
        @"population": @"4516220",
        @"capital": @"San José",
        @"continentName": @"North America"
    },
    @{
        @"countryCode": @"CU",
        @"countryName": @"Cuba",
        @"currencyCode": @"CUP",
        @"population": @"11423000",
        @"capital": @"Havana",
        @"continentName": @"North America"
    },
    @{
        @"countryCode": @"CV",
        @"countryName": @"Cape Verde",
        @"currencyCode": @"CVE",
        @"population": @"508659",
        @"capital": @"Praia",
        @"continentName": @"Africa"
    },
    @{
        @"countryCode": @"CW",
        @"countryName": @"Curacao",
        @"currencyCode": @"ANG",
        @"population": @"141766",
        @"capital": @"Willemstad",
        @"continentName": @"North America"
    },
    @{
        @"countryCode": @"CX",
        @"countryName": @"Christmas Island",
        @"currencyCode": @"AUD",
        @"population": @"1500",
        @"capital": @"Flying Fish Cove",
        @"continentName": @"Asia"
    },
    @{
        @"countryCode": @"CY",
        @"countryName": @"Cyprus",
        @"currencyCode": @"EUR",
        @"population": @"1102677",
        @"capital": @"Nicosia",
        @"continentName": @"Europe"
    },
    @{
        @"countryCode": @"CZ",
        @"countryName": @"Czechia",
        @"currencyCode": @"CZK",
        @"population": @"10476000",
        @"capital": @"Prague",
        @"continentName": @"Europe"
    },
    @{
        @"countryCode": @"DE",
        @"countryName": @"Germany",
        @"currencyCode": @"EUR",
        @"population": @"81802257",
        @"capital": @"Berlin",
        @"continentName": @"Europe"
    },
    @{
        @"countryCode": @"DJ",
        @"countryName": @"Djibouti",
        @"currencyCode": @"DJF",
        @"population": @"740528",
        @"capital": @"Djibouti",
        @"continentName": @"Africa"
    },
    @{
        @"countryCode": @"DK",
        @"countryName": @"Denmark",
        @"currencyCode": @"DKK",
        @"population": @"5484000",
        @"capital": @"Copenhagen",
        @"continentName": @"Europe"
    },
    @{
        @"countryCode": @"DM",
        @"countryName": @"Dominica",
        @"currencyCode": @"XCD",
        @"population": @"72813",
        @"capital": @"Roseau",
        @"continentName": @"North America"
    },
    @{
        @"countryCode": @"DO",
        @"countryName": @"Dominican Republic",
        @"currencyCode": @"DOP",
        @"population": @"9823821",
        @"capital": @"Santo Domingo",
        @"continentName": @"North America"
    },
    @{
        @"countryCode": @"DZ",
        @"countryName": @"Algeria",
        @"currencyCode": @"DZD",
        @"population": @"34586184",
        @"capital": @"Algiers",
        @"continentName": @"Africa"
    },
    @{
        @"countryCode": @"EC",
        @"countryName": @"Ecuador",
        @"currencyCode": @"USD",
        @"population": @"14790608",
        @"capital": @"Quito",
        @"continentName": @"South America"
    },
    @{
        @"countryCode": @"EE",
        @"countryName": @"Estonia",
        @"currencyCode": @"EUR",
        @"population": @"1291170",
        @"capital": @"Tallinn",
        @"continentName": @"Europe"
    },
    @{
        @"countryCode": @"EG",
        @"countryName": @"Egypt",
        @"currencyCode": @"EGP",
        @"population": @"80471869",
        @"capital": @"Cairo",
        @"continentName": @"Africa"
    },
    @{
        @"countryCode": @"EH",
        @"countryName": @"Western Sahara",
        @"currencyCode": @"MAD",
        @"population": @"273008",
        @"capital": @"Laâyoune / El Aaiún",
        @"continentName": @"Africa"
    },
    @{
        @"countryCode": @"ER",
        @"countryName": @"Eritrea",
        @"currencyCode": @"ERN",
        @"population": @"5792984",
        @"capital": @"Asmara",
        @"continentName": @"Africa"
    },
    @{
        @"countryCode": @"ES",
        @"countryName": @"Spain",
        @"currencyCode": @"EUR",
        @"population": @"46505963",
        @"capital": @"Madrid",
        @"continentName": @"Europe"
    },
    @{
        @"countryCode": @"ET",
        @"countryName": @"Ethiopia",
        @"currencyCode": @"ETB",
        @"population": @"88013491",
        @"capital": @"Addis Ababa",
        @"continentName": @"Africa"
    },
    @{
        @"countryCode": @"FI",
        @"countryName": @"Finland",
        @"currencyCode": @"EUR",
        @"population": @"5244000",
        @"capital": @"Helsinki",
        @"continentName": @"Europe"
    },
    @{
        @"countryCode": @"FJ",
        @"countryName": @"Fiji",
        @"currencyCode": @"FJD",
        @"population": @"875983",
        @"capital": @"Suva",
        @"continentName": @"Oceania"
    },
    @{
        @"countryCode": @"FK",
        @"countryName": @"Falkland Islands",
        @"currencyCode": @"FKP",
        @"population": @"2638",
        @"capital": @"Stanley",
        @"continentName": @"South America"
    },
    @{
        @"countryCode": @"FM",
        @"countryName": @"Micronesia",
        @"currencyCode": @"USD",
        @"population": @"107708",
        @"capital": @"Palikir",
        @"continentName": @"Oceania"
    },
    @{
        @"countryCode": @"FO",
        @"countryName": @"Faroe Islands",
        @"currencyCode": @"DKK",
        @"population": @"48228",
        @"capital": @"Tórshavn",
        @"continentName": @"Europe"
    },
    @{
        @"countryCode": @"FR",
        @"countryName": @"France",
        @"currencyCode": @"EUR",
        @"population": @"64768389",
        @"capital": @"Paris",
        @"continentName": @"Europe"
    },
    @{
        @"countryCode": @"GA",
        @"countryName": @"Gabon",
        @"currencyCode": @"XAF",
        @"population": @"1545255",
        @"capital": @"Libreville",
        @"continentName": @"Africa"
    },
    @{
        @"countryCode": @"GB",
        @"countryName": @"United Kingdom",
        @"currencyCode": @"GBP",
        @"population": @"62348447",
        @"capital": @"London",
        @"continentName": @"Europe"
    },
    @{
        @"countryCode": @"GD",
        @"countryName": @"Grenada",
        @"currencyCode": @"XCD",
        @"population": @"107818",
        @"capital": @"St. George's",
        @"continentName": @"North America"
    },
    @{
        @"countryCode": @"GE",
        @"countryName": @"Georgia",
        @"currencyCode": @"GEL",
        @"population": @"4630000",
        @"capital": @"Tbilisi",
        @"continentName": @"Asia"
    },
    @{
        @"countryCode": @"GF",
        @"countryName": @"French Guiana",
        @"currencyCode": @"EUR",
        @"population": @"195506",
        @"capital": @"Cayenne",
        @"continentName": @"South America"
    },
    @{
        @"countryCode": @"GG",
        @"countryName": @"Guernsey",
        @"currencyCode": @"GBP",
        @"population": @"65228",
        @"capital": @"St Peter Port",
        @"continentName": @"Europe"
    },
    @{
        @"countryCode": @"GH",
        @"countryName": @"Ghana",
        @"currencyCode": @"GHS",
        @"population": @"24339838",
        @"capital": @"Accra",
        @"continentName": @"Africa"
    },
    @{
        @"countryCode": @"GI",
        @"countryName": @"Gibraltar",
        @"currencyCode": @"GIP",
        @"population": @"27884",
        @"capital": @"Gibraltar",
        @"continentName": @"Europe"
    },
    @{
        @"countryCode": @"GL",
        @"countryName": @"Greenland",
        @"currencyCode": @"DKK",
        @"population": @"56375",
        @"capital": @"Nuuk",
        @"continentName": @"North America"
    },
    @{
        @"countryCode": @"GM",
        @"countryName": @"Gambia",
        @"currencyCode": @"GMD",
        @"population": @"1593256",
        @"capital": @"Bathurst",
        @"continentName": @"Africa"
    },
    @{
        @"countryCode": @"GN",
        @"countryName": @"Guinea",
        @"currencyCode": @"GNF",
        @"population": @"10324025",
        @"capital": @"Conakry",
        @"continentName": @"Africa"
    },
    @{
        @"countryCode": @"GP",
        @"countryName": @"Guadeloupe",
        @"currencyCode": @"EUR",
        @"population": @"443000",
        @"capital": @"Basse-Terre",
        @"continentName": @"North America"
    },
    @{
        @"countryCode": @"GQ",
        @"countryName": @"Equatorial Guinea",
        @"currencyCode": @"XAF",
        @"population": @"1014999",
        @"capital": @"Malabo",
        @"continentName": @"Africa"
    },
    @{
        @"countryCode": @"GR",
        @"countryName": @"Greece",
        @"currencyCode": @"EUR",
        @"population": @"11000000",
        @"capital": @"Athens",
        @"continentName": @"Europe"
    },
    @{
        @"countryCode": @"GS",
        @"countryName": @"South Georgia and the South Sandwich Islands",
        @"currencyCode": @"GBP",
        @"population": @"30",
        @"capital": @"Grytviken",
        @"continentName": @"Antarctica"
    },
    @{
        @"countryCode": @"GT",
        @"countryName": @"Guatemala",
        @"currencyCode": @"GTQ",
        @"population": @"13550440",
        @"capital": @"Guatemala City",
        @"continentName": @"North America"
    },
    @{
        @"countryCode": @"GU",
        @"countryName": @"Guam",
        @"currencyCode": @"USD",
        @"population": @"159358",
        @"capital": @"Hagåtña",
        @"continentName": @"Oceania"
    },
    @{
        @"countryCode": @"GW",
        @"countryName": @"Guinea-Bissau",
        @"currencyCode": @"XOF",
        @"population": @"1565126",
        @"capital": @"Bissau",
        @"continentName": @"Africa"
    },
    @{
        @"countryCode": @"GY",
        @"countryName": @"Guyana",
        @"currencyCode": @"GYD",
        @"population": @"748486",
        @"capital": @"Georgetown",
        @"continentName": @"South America"
    },
    @{
        @"countryCode": @"HK",
        @"countryName": @"Hong Kong",
        @"currencyCode": @"HKD",
        @"population": @"6898686",
        @"capital": @"Hong Kong",
        @"continentName": @"Asia"
    },
    @{
        @"countryCode": @"HM",
        @"countryName": @"Heard Island and McDonald Islands",
        @"currencyCode": @"AUD",
        @"population": @"0",
        @"capital": @"",
        @"continentName": @"Antarctica"
    },
    @{
        @"countryCode": @"HN",
        @"countryName": @"Honduras",
        @"currencyCode": @"HNL",
        @"population": @"7989415",
        @"capital": @"Tegucigalpa",
        @"continentName": @"North America"
    },
    @{
        @"countryCode": @"HR",
        @"countryName": @"Croatia",
        @"currencyCode": @"HRK",
        @"population": @"4284889",
        @"capital": @"Zagreb",
        @"continentName": @"Europe"
    },
    @{
        @"countryCode": @"HT",
        @"countryName": @"Haiti",
        @"currencyCode": @"HTG",
        @"population": @"9648924",
        @"capital": @"Port-au-Prince",
        @"continentName": @"North America"
    },
    @{
        @"countryCode": @"HU",
        @"countryName": @"Hungary",
        @"currencyCode": @"HUF",
        @"population": @"9982000",
        @"capital": @"Budapest",
        @"continentName": @"Europe"
    },
    @{
        @"countryCode": @"ID",
        @"countryName": @"Indonesia",
        @"currencyCode": @"IDR",
        @"population": @"242968342",
        @"capital": @"Jakarta",
        @"continentName": @"Asia"
    },
    @{
        @"countryCode": @"IE",
        @"countryName": @"Ireland",
        @"currencyCode": @"EUR",
        @"population": @"4622917",
        @"capital": @"Dublin",
        @"continentName": @"Europe"
    },
    @{
        @"countryCode": @"IL",
        @"countryName": @"Israel",
        @"currencyCode": @"ILS",
        @"population": @"7353985",
        @"capital": @"",
        @"continentName": @"Asia"
    },
    @{
        @"countryCode": @"IM",
        @"countryName": @"Isle of Man",
        @"currencyCode": @"GBP",
        @"population": @"75049",
        @"capital": @"Douglas",
        @"continentName": @"Europe"
    },
    @{
        @"countryCode": @"IN",
        @"countryName": @"India",
        @"currencyCode": @"INR",
        @"population": @"1173108018",
        @"capital": @"New Delhi",
        @"continentName": @"Asia"
    },
    @{
        @"countryCode": @"IO",
        @"countryName": @"British Indian Ocean Territory",
        @"currencyCode": @"USD",
        @"population": @"4000",
        @"capital": @"",
        @"continentName": @"Asia"
    },
    @{
        @"countryCode": @"IQ",
        @"countryName": @"Iraq",
        @"currencyCode": @"IQD",
        @"population": @"29671605",
        @"capital": @"Baghdad",
        @"continentName": @"Asia"
    },
    @{
        @"countryCode": @"IR",
        @"countryName": @"Iran",
        @"currencyCode": @"IRR",
        @"population": @"76923300",
        @"capital": @"Tehran",
        @"continentName": @"Asia"
    },
    @{
        @"countryCode": @"IS",
        @"countryName": @"Iceland",
        @"currencyCode": @"ISK",
        @"population": @"308910",
        @"capital": @"Reykjavik",
        @"continentName": @"Europe"
    },
    @{
        @"countryCode": @"IT",
        @"countryName": @"Italy",
        @"currencyCode": @"EUR",
        @"population": @"60340328",
        @"capital": @"Rome",
        @"continentName": @"Europe"
    },
    @{
        @"countryCode": @"JE",
        @"countryName": @"Jersey",
        @"currencyCode": @"GBP",
        @"population": @"90812",
        @"capital": @"Saint Helier",
        @"continentName": @"Europe"
    },
    @{
        @"countryCode": @"JM",
        @"countryName": @"Jamaica",
        @"currencyCode": @"JMD",
        @"population": @"2847232",
        @"capital": @"Kingston",
        @"continentName": @"North America"
    },
    @{
        @"countryCode": @"JO",
        @"countryName": @"Jordan",
        @"currencyCode": @"JOD",
        @"population": @"6407085",
        @"capital": @"Amman",
        @"continentName": @"Asia"
    },
    @{
        @"countryCode": @"JP",
        @"countryName": @"Japan",
        @"currencyCode": @"JPY",
        @"population": @"127288000",
        @"capital": @"Tokyo",
        @"continentName": @"Asia"
    },
    @{
        @"countryCode": @"KE",
        @"countryName": @"Kenya",
        @"currencyCode": @"KES",
        @"population": @"40046566",
        @"capital": @"Nairobi",
        @"continentName": @"Africa"
    },
    @{
        @"countryCode": @"KG",
        @"countryName": @"Kyrgyzstan",
        @"currencyCode": @"KGS",
        @"population": @"5776500",
        @"capital": @"Bishkek",
        @"continentName": @"Asia"
    },
    @{
        @"countryCode": @"KH",
        @"countryName": @"Cambodia",
        @"currencyCode": @"KHR",
        @"population": @"14453680",
        @"capital": @"Phnom Penh",
        @"continentName": @"Asia"
    },
    @{
        @"countryCode": @"KI",
        @"countryName": @"Kiribati",
        @"currencyCode": @"AUD",
        @"population": @"92533",
        @"capital": @"Tarawa",
        @"continentName": @"Oceania"
    },
    @{
        @"countryCode": @"KM",
        @"countryName": @"Comoros",
        @"currencyCode": @"KMF",
        @"population": @"773407",
        @"capital": @"Moroni",
        @"continentName": @"Africa"
    },
    @{
        @"countryCode": @"KN",
        @"countryName": @"Saint Kitts and Nevis",
        @"currencyCode": @"XCD",
        @"population": @"51134",
        @"capital": @"Basseterre",
        @"continentName": @"North America"
    },
    @{
        @"countryCode": @"KP",
        @"countryName": @"North Korea",
        @"currencyCode": @"KPW",
        @"population": @"22912177",
        @"capital": @"Pyongyang",
        @"continentName": @"Asia"
    },
    @{
        @"countryCode": @"KR",
        @"countryName": @"South Korea",
        @"currencyCode": @"KRW",
        @"population": @"48422644",
        @"capital": @"Seoul",
        @"continentName": @"Asia"
    },
    @{
        @"countryCode": @"KW",
        @"countryName": @"Kuwait",
        @"currencyCode": @"KWD",
        @"population": @"2789132",
        @"capital": @"Kuwait City",
        @"continentName": @"Asia"
    },
    @{
        @"countryCode": @"KY",
        @"countryName": @"Cayman Islands",
        @"currencyCode": @"KYD",
        @"population": @"44270",
        @"capital": @"George Town",
        @"continentName": @"North America"
    },
    @{
        @"countryCode": @"KZ",
        @"countryName": @"Kazakhstan",
        @"currencyCode": @"KZT",
        @"population": @"15340000",
        @"capital": @"Astana",
        @"continentName": @"Asia"
    },
    @{
        @"countryCode": @"LA",
        @"countryName": @"Laos",
        @"currencyCode": @"LAK",
        @"population": @"6368162",
        @"capital": @"Vientiane",
        @"continentName": @"Asia"
    },
    @{
        @"countryCode": @"LB",
        @"countryName": @"Lebanon",
        @"currencyCode": @"LBP",
        @"population": @"4125247",
        @"capital": @"Beirut",
        @"continentName": @"Asia"
    },
    @{
        @"countryCode": @"LC",
        @"countryName": @"Saint Lucia",
        @"currencyCode": @"XCD",
        @"population": @"160922",
        @"capital": @"Castries",
        @"continentName": @"North America"
    },
    @{
        @"countryCode": @"LI",
        @"countryName": @"Liechtenstein",
        @"currencyCode": @"CHF",
        @"population": @"35000",
        @"capital": @"Vaduz",
        @"continentName": @"Europe"
    },
    @{
        @"countryCode": @"LK",
        @"countryName": @"Sri Lanka",
        @"currencyCode": @"LKR",
        @"population": @"21513990",
        @"capital": @"Colombo",
        @"continentName": @"Asia"
    },
    @{
        @"countryCode": @"LR",
        @"countryName": @"Liberia",
        @"currencyCode": @"LRD",
        @"population": @"3685076",
        @"capital": @"Monrovia",
        @"continentName": @"Africa"
    },
    @{
        @"countryCode": @"LS",
        @"countryName": @"Lesotho",
        @"currencyCode": @"LSL",
        @"population": @"1919552",
        @"capital": @"Maseru",
        @"continentName": @"Africa"
    },
    @{
        @"countryCode": @"LT",
        @"countryName": @"Lithuania",
        @"currencyCode": @"EUR",
        @"population": @"2944459",
        @"capital": @"Vilnius",
        @"continentName": @"Europe"
    },
    @{
        @"countryCode": @"LU",
        @"countryName": @"Luxembourg",
        @"currencyCode": @"EUR",
        @"population": @"497538",
        @"capital": @"Luxembourg",
        @"continentName": @"Europe"
    },
    @{
        @"countryCode": @"LV",
        @"countryName": @"Latvia",
        @"currencyCode": @"EUR",
        @"population": @"2217969",
        @"capital": @"Riga",
        @"continentName": @"Europe"
    },
    @{
        @"countryCode": @"LY",
        @"countryName": @"Libya",
        @"currencyCode": @"LYD",
        @"population": @"6461454",
        @"capital": @"Tripoli",
        @"continentName": @"Africa"
    },
    @{
        @"countryCode": @"MA",
        @"countryName": @"Morocco",
        @"currencyCode": @"MAD",
        @"population": @"33848242",
        @"capital": @"Rabat",
        @"continentName": @"Africa"
    },
    @{
        @"countryCode": @"MC",
        @"countryName": @"Monaco",
        @"currencyCode": @"EUR",
        @"population": @"32965",
        @"capital": @"Monaco",
        @"continentName": @"Europe"
    },
    @{
        @"countryCode": @"MD",
        @"countryName": @"Moldova",
        @"currencyCode": @"MDL",
        @"population": @"4324000",
        @"capital": @"Chişinău",
        @"continentName": @"Europe"
    },
    @{
        @"countryCode": @"ME",
        @"countryName": @"Montenegro",
        @"currencyCode": @"EUR",
        @"population": @"666730",
        @"capital": @"Podgorica",
        @"continentName": @"Europe"
    },
    @{
        @"countryCode": @"MF",
        @"countryName": @"Saint Martin",
        @"currencyCode": @"EUR",
        @"population": @"35925",
        @"capital": @"Marigot",
        @"continentName": @"North America"
    },
    @{
        @"countryCode": @"MG",
        @"countryName": @"Madagascar",
        @"currencyCode": @"MGA",
        @"population": @"21281844",
        @"capital": @"Antananarivo",
        @"continentName": @"Africa"
    },
    @{
        @"countryCode": @"MH",
        @"countryName": @"Marshall Islands",
        @"currencyCode": @"USD",
        @"population": @"65859",
        @"capital": @"Majuro",
        @"continentName": @"Oceania"
    },
    @{
        @"countryCode": @"MK",
        @"countryName": @"Macedonia",
        @"currencyCode": @"MKD",
        @"population": @"2062294",
        @"capital": @"Skopje",
        @"continentName": @"Europe"
    },
    @{
        @"countryCode": @"ML",
        @"countryName": @"Mali",
        @"currencyCode": @"XOF",
        @"population": @"13796354",
        @"capital": @"Bamako",
        @"continentName": @"Africa"
    },
    @{
        @"countryCode": @"MM",
        @"countryName": @"Myanmar [Burma]",
        @"currencyCode": @"MMK",
        @"population": @"53414374",
        @"capital": @"Naypyitaw",
        @"continentName": @"Asia"
    },
    @{
        @"countryCode": @"MN",
        @"countryName": @"Mongolia",
        @"currencyCode": @"MNT",
        @"population": @"3086918",
        @"capital": @"Ulan Bator",
        @"continentName": @"Asia"
    },
    @{
        @"countryCode": @"MO",
        @"countryName": @"Macao",
        @"currencyCode": @"MOP",
        @"population": @"449198",
        @"capital": @"Macao",
        @"continentName": @"Asia"
    },
    @{
        @"countryCode": @"MP",
        @"countryName": @"Northern Mariana Islands",
        @"currencyCode": @"USD",
        @"population": @"53883",
        @"capital": @"Saipan",
        @"continentName": @"Oceania"
    },
    @{
        @"countryCode": @"MQ",
        @"countryName": @"Martinique",
        @"currencyCode": @"EUR",
        @"population": @"432900",
        @"capital": @"Fort-de-France",
        @"continentName": @"North America"
    },
    @{
        @"countryCode": @"MR",
        @"countryName": @"Mauritania",
        @"currencyCode": @"MRO",
        @"population": @"3205060",
        @"capital": @"Nouakchott",
        @"continentName": @"Africa"
    },
    @{
        @"countryCode": @"MS",
        @"countryName": @"Montserrat",
        @"currencyCode": @"XCD",
        @"population": @"9341",
        @"capital": @"Plymouth",
        @"continentName": @"North America"
    },
    @{
        @"countryCode": @"MT",
        @"countryName": @"Malta",
        @"currencyCode": @"EUR",
        @"population": @"403000",
        @"capital": @"Valletta",
        @"continentName": @"Europe"
    },
    @{
        @"countryCode": @"MU",
        @"countryName": @"Mauritius",
        @"currencyCode": @"MUR",
        @"population": @"1294104",
        @"capital": @"Port Louis",
        @"continentName": @"Africa"
    },
    @{
        @"countryCode": @"MV",
        @"countryName": @"Maldives",
        @"currencyCode": @"MVR",
        @"population": @"395650",
        @"capital": @"Malé",
        @"continentName": @"Asia"
    },
    @{
        @"countryCode": @"MW",
        @"countryName": @"Malawi",
        @"currencyCode": @"MWK",
        @"population": @"15447500",
        @"capital": @"Lilongwe",
        @"continentName": @"Africa"
    },
    @{
        @"countryCode": @"MX",
        @"countryName": @"Mexico",
        @"currencyCode": @"MXN",
        @"population": @"112468855",
        @"capital": @"Mexico City",
        @"continentName": @"North America"
    },
    @{
        @"countryCode": @"MY",
        @"countryName": @"Malaysia",
        @"currencyCode": @"MYR",
        @"population": @"28274729",
        @"capital": @"Kuala Lumpur",
        @"continentName": @"Asia"
    },
    @{
        @"countryCode": @"MZ",
        @"countryName": @"Mozambique",
        @"currencyCode": @"MZN",
        @"population": @"22061451",
        @"capital": @"Maputo",
        @"continentName": @"Africa"
    },
    @{
        @"countryCode": @"NA",
        @"countryName": @"Namibia",
        @"currencyCode": @"NAD",
        @"population": @"2128471",
        @"capital": @"Windhoek",
        @"continentName": @"Africa"
    },
    @{
        @"countryCode": @"NC",
        @"countryName": @"New Caledonia",
        @"currencyCode": @"XPF",
        @"population": @"216494",
        @"capital": @"Noumea",
        @"continentName": @"Oceania"
    },
    @{
        @"countryCode": @"NE",
        @"countryName": @"Niger",
        @"currencyCode": @"XOF",
        @"population": @"15878271",
        @"capital": @"Niamey",
        @"continentName": @"Africa"
    },
    @{
        @"countryCode": @"NF",
        @"countryName": @"Norfolk Island",
        @"currencyCode": @"AUD",
        @"population": @"1828",
        @"capital": @"Kingston",
        @"continentName": @"Oceania"
    },
    @{
        @"countryCode": @"NG",
        @"countryName": @"Nigeria",
        @"currencyCode": @"NGN",
        @"population": @"154000000",
        @"capital": @"Abuja",
        @"continentName": @"Africa"
    },
    @{
        @"countryCode": @"NI",
        @"countryName": @"Nicaragua",
        @"currencyCode": @"NIO",
        @"population": @"5995928",
        @"capital": @"Managua",
        @"continentName": @"North America"
    },
    @{
        @"countryCode": @"NL",
        @"countryName": @"Netherlands",
        @"currencyCode": @"EUR",
        @"population": @"16645000",
        @"capital": @"Amsterdam",
        @"continentName": @"Europe"
    },
    @{
        @"countryCode": @"NO",
        @"countryName": @"Norway",
        @"currencyCode": @"NOK",
        @"population": @"5009150",
        @"capital": @"Oslo",
        @"continentName": @"Europe"
    },
    @{
        @"countryCode": @"NP",
        @"countryName": @"Nepal",
        @"currencyCode": @"NPR",
        @"population": @"28951852",
        @"capital": @"Kathmandu",
        @"continentName": @"Asia"
    },
    @{
        @"countryCode": @"NR",
        @"countryName": @"Nauru",
        @"currencyCode": @"AUD",
        @"population": @"10065",
        @"capital": @"Yaren",
        @"continentName": @"Oceania"
    },
    @{
        @"countryCode": @"NU",
        @"countryName": @"Niue",
        @"currencyCode": @"NZD",
        @"population": @"2166",
        @"capital": @"Alofi",
        @"continentName": @"Oceania"
    },
    @{
        @"countryCode": @"NZ",
        @"countryName": @"New Zealand",
        @"currencyCode": @"NZD",
        @"population": @"4252277",
        @"capital": @"Wellington",
        @"continentName": @"Oceania"
    },
    @{
        @"countryCode": @"OM",
        @"countryName": @"Oman",
        @"currencyCode": @"OMR",
        @"population": @"2967717",
        @"capital": @"Muscat",
        @"continentName": @"Asia"
    },
    @{
        @"countryCode": @"PA",
        @"countryName": @"Panama",
        @"currencyCode": @"PAB",
        @"population": @"3410676",
        @"capital": @"Panama City",
        @"continentName": @"North America"
    },
    @{
        @"countryCode": @"PE",
        @"countryName": @"Peru",
        @"currencyCode": @"PEN",
        @"population": @"29907003",
        @"capital": @"Lima",
        @"continentName": @"South America"
    },
    @{
        @"countryCode": @"PF",
        @"countryName": @"French Polynesia",
        @"currencyCode": @"XPF",
        @"population": @"270485",
        @"capital": @"Papeete",
        @"continentName": @"Oceania"
    },
    @{
        @"countryCode": @"PG",
        @"countryName": @"Papua New Guinea",
        @"currencyCode": @"PGK",
        @"population": @"6064515",
        @"capital": @"Port Moresby",
        @"continentName": @"Oceania"
    },
    @{
        @"countryCode": @"PH",
        @"countryName": @"Philippines",
        @"currencyCode": @"PHP",
        @"population": @"99900177",
        @"capital": @"Manila",
        @"continentName": @"Asia"
    },
    @{
        @"countryCode": @"PK",
        @"countryName": @"Pakistan",
        @"currencyCode": @"PKR",
        @"population": @"184404791",
        @"capital": @"Islamabad",
        @"continentName": @"Asia"
    },
    @{
        @"countryCode": @"PL",
        @"countryName": @"Poland",
        @"currencyCode": @"PLN",
        @"population": @"38500000",
        @"capital": @"Warsaw",
        @"continentName": @"Europe"
    },
    @{
        @"countryCode": @"PM",
        @"countryName": @"Saint Pierre and Miquelon",
        @"currencyCode": @"EUR",
        @"population": @"7012",
        @"capital": @"Saint-Pierre",
        @"continentName": @"North America"
    },
    @{
        @"countryCode": @"PN",
        @"countryName": @"Pitcairn Islands",
        @"currencyCode": @"NZD",
        @"population": @"46",
        @"capital": @"Adamstown",
        @"continentName": @"Oceania"
    },
    @{
        @"countryCode": @"PR",
        @"countryName": @"Puerto Rico",
        @"currencyCode": @"USD",
        @"population": @"3916632",
        @"capital": @"San Juan",
        @"continentName": @"North America"
    },
    @{
        @"countryCode": @"PS",
        @"countryName": @"Palestine",
        @"currencyCode": @"ILS",
        @"population": @"3800000",
        @"capital": @"",
        @"continentName": @"Asia"
    },
    @{
        @"countryCode": @"PT",
        @"countryName": @"Portugal",
        @"currencyCode": @"EUR",
        @"population": @"10676000",
        @"capital": @"Lisbon",
        @"continentName": @"Europe"
    },
    @{
        @"countryCode": @"PW",
        @"countryName": @"Palau",
        @"currencyCode": @"USD",
        @"population": @"19907",
        @"capital": @"Melekeok",
        @"continentName": @"Oceania"
    },
    @{
        @"countryCode": @"PY",
        @"countryName": @"Paraguay",
        @"currencyCode": @"PYG",
        @"population": @"6375830",
        @"capital": @"Asunción",
        @"continentName": @"South America"
    },
    @{
        @"countryCode": @"QA",
        @"countryName": @"Qatar",
        @"currencyCode": @"QAR",
        @"population": @"840926",
        @"capital": @"Doha",
        @"continentName": @"Asia"
    },
    @{
        @"countryCode": @"RE",
        @"countryName": @"Réunion",
        @"currencyCode": @"EUR",
        @"population": @"776948",
        @"capital": @"Saint-Denis",
        @"continentName": @"Africa"
    },
    @{
        @"countryCode": @"RO",
        @"countryName": @"Romania",
        @"currencyCode": @"RON",
        @"population": @"21959278",
        @"capital": @"Bucharest",
        @"continentName": @"Europe"
    },
    @{
        @"countryCode": @"RS",
        @"countryName": @"Serbia",
        @"currencyCode": @"RSD",
        @"population": @"7344847",
        @"capital": @"Belgrade",
        @"continentName": @"Europe"
    },
    @{
        @"countryCode": @"RU",
        @"countryName": @"Russia",
        @"currencyCode": @"RUB",
        @"population": @"140702000",
        @"capital": @"Moscow",
        @"continentName": @"Europe"
    },
    @{
        @"countryCode": @"RW",
        @"countryName": @"Rwanda",
        @"currencyCode": @"RWF",
        @"population": @"11055976",
        @"capital": @"Kigali",
        @"continentName": @"Africa"
    },
    @{
        @"countryCode": @"SA",
        @"countryName": @"Saudi Arabia",
        @"currencyCode": @"SAR",
        @"population": @"25731776",
        @"capital": @"Riyadh",
        @"continentName": @"Asia"
    },
    @{
        @"countryCode": @"SB",
        @"countryName": @"Solomon Islands",
        @"currencyCode": @"SBD",
        @"population": @"559198",
        @"capital": @"Honiara",
        @"continentName": @"Oceania"
    },
    @{
        @"countryCode": @"SC",
        @"countryName": @"Seychelles",
        @"currencyCode": @"SCR",
        @"population": @"88340",
        @"capital": @"Victoria",
        @"continentName": @"Africa"
    },
    @{
        @"countryCode": @"SD",
        @"countryName": @"Sudan",
        @"currencyCode": @"SDG",
        @"population": @"35000000",
        @"capital": @"Khartoum",
        @"continentName": @"Africa"
    },
    @{
        @"countryCode": @"SE",
        @"countryName": @"Sweden",
        @"currencyCode": @"SEK",
        @"population": @"9828655",
        @"capital": @"Stockholm",
        @"continentName": @"Europe"
    },
    @{
        @"countryCode": @"SG",
        @"countryName": @"Singapore",
        @"currencyCode": @"SGD",
        @"population": @"4701069",
        @"capital": @"Singapore",
        @"continentName": @"Asia"
    },
    @{
        @"countryCode": @"SH",
        @"countryName": @"Saint Helena",
        @"currencyCode": @"SHP",
        @"population": @"7460",
        @"capital": @"Jamestown",
        @"continentName": @"Africa"
    },
    @{
        @"countryCode": @"SI",
        @"countryName": @"Slovenia",
        @"currencyCode": @"EUR",
        @"population": @"2007000",
        @"capital": @"Ljubljana",
        @"continentName": @"Europe"
    },
    @{
        @"countryCode": @"SJ",
        @"countryName": @"Svalbard and Jan Mayen",
        @"currencyCode": @"NOK",
        @"population": @"2550",
        @"capital": @"Longyearbyen",
        @"continentName": @"Europe"
    },
    @{
        @"countryCode": @"SK",
        @"countryName": @"Slovakia",
        @"currencyCode": @"EUR",
        @"population": @"5455000",
        @"capital": @"Bratislava",
        @"continentName": @"Europe"
    },
    @{
        @"countryCode": @"SL",
        @"countryName": @"Sierra Leone",
        @"currencyCode": @"SLL",
        @"population": @"5245695",
        @"capital": @"Freetown",
        @"continentName": @"Africa"
    },
    @{
        @"countryCode": @"SM",
        @"countryName": @"San Marino",
        @"currencyCode": @"EUR",
        @"population": @"31477",
        @"capital": @"San Marino",
        @"continentName": @"Europe"
    },
    @{
        @"countryCode": @"SN",
        @"countryName": @"Senegal",
        @"currencyCode": @"XOF",
        @"population": @"12323252",
        @"capital": @"Dakar",
        @"continentName": @"Africa"
    },
    @{
        @"countryCode": @"SO",
        @"countryName": @"Somalia",
        @"currencyCode": @"SOS",
        @"population": @"10112453",
        @"capital": @"Mogadishu",
        @"continentName": @"Africa"
    },
    @{
        @"countryCode": @"SR",
        @"countryName": @"Suriname",
        @"currencyCode": @"SRD",
        @"population": @"492829",
        @"capital": @"Paramaribo",
        @"continentName": @"South America"
    },
    @{
        @"countryCode": @"SS",
        @"countryName": @"South Sudan",
        @"currencyCode": @"SSP",
        @"population": @"8260490",
        @"capital": @"Juba",
        @"continentName": @"Africa"
    },
    @{
        @"countryCode": @"ST",
        @"countryName": @"São Tomé and Príncipe",
        @"currencyCode": @"STD",
        @"population": @"175808",
        @"capital": @"São Tomé",
        @"continentName": @"Africa"
    },
    @{
        @"countryCode": @"SV",
        @"countryName": @"El Salvador",
        @"currencyCode": @"USD",
        @"population": @"6052064",
        @"capital": @"San Salvador",
        @"continentName": @"North America"
    },
    @{
        @"countryCode": @"SX",
        @"countryName": @"Sint Maarten",
        @"currencyCode": @"ANG",
        @"population": @"37429",
        @"capital": @"Philipsburg",
        @"continentName": @"North America"
    },
    @{
        @"countryCode": @"SY",
        @"countryName": @"Syria",
        @"currencyCode": @"SYP",
        @"population": @"22198110",
        @"capital": @"Damascus",
        @"continentName": @"Asia"
    },
    @{
        @"countryCode": @"SZ",
        @"countryName": @"Swaziland",
        @"currencyCode": @"SZL",
        @"population": @"1354051",
        @"capital": @"Mbabane",
        @"continentName": @"Africa"
    },
    @{
        @"countryCode": @"TC",
        @"countryName": @"Turks and Caicos Islands",
        @"currencyCode": @"USD",
        @"population": @"20556",
        @"capital": @"Cockburn Town",
        @"continentName": @"North America"
    },
    @{
        @"countryCode": @"TD",
        @"countryName": @"Chad",
        @"currencyCode": @"XAF",
        @"population": @"10543464",
        @"capital": @"N'Djamena",
        @"continentName": @"Africa"
    },
    @{
        @"countryCode": @"TF",
        @"countryName": @"French Southern Territories",
        @"currencyCode": @"EUR",
        @"population": @"140",
        @"capital": @"Port-aux-Français",
        @"continentName": @"Antarctica"
    },
    @{
        @"countryCode": @"TG",
        @"countryName": @"Togo",
        @"currencyCode": @"XOF",
        @"population": @"6587239",
        @"capital": @"Lomé",
        @"continentName": @"Africa"
    },
    @{
        @"countryCode": @"TH",
        @"countryName": @"Thailand",
        @"currencyCode": @"THB",
        @"population": @"67089500",
        @"capital": @"Bangkok",
        @"continentName": @"Asia"
    },
    @{
        @"countryCode": @"TJ",
        @"countryName": @"Tajikistan",
        @"currencyCode": @"TJS",
        @"population": @"7487489",
        @"capital": @"Dushanbe",
        @"continentName": @"Asia"
    },
    @{
        @"countryCode": @"TK",
        @"countryName": @"Tokelau",
        @"currencyCode": @"NZD",
        @"population": @"1466",
        @"capital": @"",
        @"continentName": @"Oceania"
    },
    @{
        @"countryCode": @"TL",
        @"countryName": @"East Timor",
        @"currencyCode": @"USD",
        @"population": @"1154625",
        @"capital": @"Dili",
        @"continentName": @"Oceania"
    },
    @{
        @"countryCode": @"TM",
        @"countryName": @"Turkmenistan",
        @"currencyCode": @"TMT",
        @"population": @"4940916",
        @"capital": @"Ashgabat",
        @"continentName": @"Asia"
    },
    @{
        @"countryCode": @"TN",
        @"countryName": @"Tunisia",
        @"currencyCode": @"TND",
        @"population": @"10589025",
        @"capital": @"Tunis",
        @"continentName": @"Africa"
    },
    @{
        @"countryCode": @"TO",
        @"countryName": @"Tonga",
        @"currencyCode": @"TOP",
        @"population": @"122580",
        @"capital": @"Nuku'alofa",
        @"continentName": @"Oceania"
    },
    @{
        @"countryCode": @"TR",
        @"countryName": @"Turkey",
        @"currencyCode": @"TRY",
        @"population": @"77804122",
        @"capital": @"Ankara",
        @"continentName": @"Asia"
    },
    @{
        @"countryCode": @"TT",
        @"countryName": @"Trinidad and Tobago",
        @"currencyCode": @"TTD",
        @"population": @"1228691",
        @"capital": @"Port of Spain",
        @"continentName": @"North America"
    },
    @{
        @"countryCode": @"TV",
        @"countryName": @"Tuvalu",
        @"currencyCode": @"AUD",
        @"population": @"10472",
        @"capital": @"Funafuti",
        @"continentName": @"Oceania"
    },
    @{
        @"countryCode": @"TW",
        @"countryName": @"Taiwan",
        @"currencyCode": @"TWD",
        @"population": @"22894384",
        @"capital": @"Taipei",
        @"continentName": @"Asia"
    },
    @{
        @"countryCode": @"TZ",
        @"countryName": @"Tanzania",
        @"currencyCode": @"TZS",
        @"population": @"41892895",
        @"capital": @"Dodoma",
        @"continentName": @"Africa"
    },
    @{
        @"countryCode": @"UA",
        @"countryName": @"Ukraine",
        @"currencyCode": @"UAH",
        @"population": @"45415596",
        @"capital": @"Kiev",
        @"continentName": @"Europe"
    },
    @{
        @"countryCode": @"UG",
        @"countryName": @"Uganda",
        @"currencyCode": @"UGX",
        @"population": @"33398682",
        @"capital": @"Kampala",
        @"continentName": @"Africa"
    },
    @{
        @"countryCode": @"UM",
        @"countryName": @"U.S. Minor Outlying Islands",
        @"currencyCode": @"USD",
        @"population": @"0",
        @"capital": @"",
        @"continentName": @"Oceania"
    },
    @{
        @"countryCode": @"US",
        @"countryName": @"United States",
        @"currencyCode": @"USD",
        @"population": @"310232863",
        @"capital": @"Washington",
        @"continentName": @"North America"
    },
    @{
        @"countryCode": @"UY",
        @"countryName": @"Uruguay",
        @"currencyCode": @"UYU",
        @"population": @"3477000",
        @"capital": @"Montevideo",
        @"continentName": @"South America"
    },
    @{
        @"countryCode": @"UZ",
        @"countryName": @"Uzbekistan",
        @"currencyCode": @"UZS",
        @"population": @"27865738",
        @"capital": @"Tashkent",
        @"continentName": @"Asia"
    },
    @{
        @"countryCode": @"VA",
        @"countryName": @"Vatican City",
        @"currencyCode": @"EUR",
        @"population": @"921",
        @"capital": @"Vatican City",
        @"continentName": @"Europe"
    },
    @{
        @"countryCode": @"VC",
        @"countryName": @"Saint Vincent and the Grenadines",
        @"currencyCode": @"XCD",
        @"population": @"104217",
        @"capital": @"Kingstown",
        @"continentName": @"North America"
    },
    @{
        @"countryCode": @"VE",
        @"countryName": @"Venezuela",
        @"currencyCode": @"VEF",
        @"population": @"27223228",
        @"capital": @"Caracas",
        @"continentName": @"South America"
    },
    @{
        @"countryCode": @"VG",
        @"countryName": @"British Virgin Islands",
        @"currencyCode": @"USD",
        @"population": @"21730",
        @"capital": @"Road Town",
        @"continentName": @"North America"
    },
    @{
        @"countryCode": @"VI",
        @"countryName": @"U.S. Virgin Islands",
        @"currencyCode": @"USD",
        @"population": @"108708",
        @"capital": @"Charlotte Amalie",
        @"continentName": @"North America"
    },
    @{
        @"countryCode": @"VN",
        @"countryName": @"Vietnam",
        @"currencyCode": @"VND",
        @"population": @"89571130",
        @"capital": @"Hanoi",
        @"continentName": @"Asia"
    },
    @{
        @"countryCode": @"VU",
        @"countryName": @"Vanuatu",
        @"currencyCode": @"VUV",
        @"population": @"221552",
        @"capital": @"Port Vila",
        @"continentName": @"Oceania"
    },
    @{
        @"countryCode": @"WF",
        @"countryName": @"Wallis and Futuna",
        @"currencyCode": @"XPF",
        @"population": @"16025",
        @"capital": @"Mata-Utu",
        @"continentName": @"Oceania"
    },
    @{
        @"countryCode": @"WS",
        @"countryName": @"Samoa",
        @"currencyCode": @"WST",
        @"population": @"192001",
        @"capital": @"Apia",
        @"continentName": @"Oceania"
    },
    @{
        @"countryCode": @"XK",
        @"countryName": @"Kosovo",
        @"currencyCode": @"EUR",
        @"population": @"1800000",
        @"capital": @"Pristina",
        @"continentName": @"Europe"
    },
    @{
        @"countryCode": @"YE",
        @"countryName": @"Yemen",
        @"currencyCode": @"YER",
        @"population": @"23495361",
        @"capital": @"Sanaa",
        @"continentName": @"Asia"
    },
    @{
        @"countryCode": @"YT",
        @"countryName": @"Mayotte",
        @"currencyCode": @"EUR",
        @"population": @"159042",
        @"capital": @"Mamoudzou",
        @"continentName": @"Africa"
    },
    @{
        @"countryCode": @"ZA",
        @"countryName": @"South Africa",
        @"currencyCode": @"ZAR",
        @"population": @"49000000",
        @"capital": @"Pretoria",
        @"continentName": @"Africa"
    },
    @{
        @"countryCode": @"ZM",
        @"countryName": @"Zambia",
        @"currencyCode": @"ZMW",
        @"population": @"13460305",
        @"capital": @"Lusaka",
        @"continentName": @"Africa"
    },
    @{
        @"countryCode": @"ZW",
        @"countryName": @"Zimbabwe",
        @"currencyCode": @"ZWL",
        @"population": @"13061000",
        @"capital": @"Harare",
        @"continentName": @"Africa"
    }, nil];
}
+(NSString*)formateNumber:(double)number {
    NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
    formatter.numberStyle = NSNumberFormatterDecimalStyle;
    formatter.maximumFractionDigits = 3; // Set the maximum number of decimal places
    NSString *formattedString = [formatter stringFromNumber:@(number)];
    return formattedString;
}
+ (NSInteger)getObjectIndex:(NSArray *)array byName:(NSString *)theName {
    NSInteger idx = 0;
    for (NSString* key in array) {
        if ([key isEqualToString:theName])
            return idx;
        ++idx;
    }
    return NSNotFound;
}
+(void)getObjectIndexFromDictionary:(NSArray *)array forKey:(NSString *)keyValue andFiledName:(NSString*)field andResultBloch:(ResultsBlock)block {
    int idx = 0;
    for (NSDictionary* item in array) {
        NSDictionary* currency = [item objectForKey:keyValue];
        if ([[currency objectForKey:field] isEqualToString:keyValue])
            block ([item objectForKey:keyValue], idx);
        ++idx;
    }
    
}

@end
