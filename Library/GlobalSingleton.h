//
//  GlobalSingleton.h
//  CurrencyXchange
//
//  Created by Samer Ghanim on 31/03/2024.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface GlobalSingleton : NSObject
@property (nonatomic, strong) NSDictionary *CurrenciesRates;
@property (nonatomic,strong) NSDictionary  *Countries;

+ (instancetype)sharedInstance;
@end

NS_ASSUME_NONNULL_END
