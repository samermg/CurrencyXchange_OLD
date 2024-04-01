//
//  GlobalSingleton.m
//  CurrencyXchange
//
//  Created by Samer Ghanim on 31/03/2024.
//

#import "GlobalSingleton.h"
@implementation GlobalSingleton
+ (instancetype)sharedInstance {
    static GlobalSingleton *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[self alloc] init];
    });
    return sharedInstance;
}

@end
