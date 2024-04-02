//
//  SGAPI.h
//  TableView
//
//  Created by Samer Ghanim on 08/02/2024.
//

#import <Foundation/Foundation.h>


#import "Helper.h"
@interface SGAPI : NSObject
+ (void)call:(NSString*_Nonnull)strURL
      method:(HttpMethod)method
     headers:(NSDictionary*_Nullable)headers
   andParams:(NSDictionary*_Nullable)params
         res:(void (^_Nonnull)(NSDictionary * _Nullable json, NSError * _Nullable error))completionHandler ;

- (void)callAPI:(NSString*_Nullable)url res:(void (^_Nullable)(NSDictionary * _Nullable json, NSError * _Nullable error))completionHandler;

- (void)callAPI:(NSString*_Nonnull)url completionHandler:(void (^_Nullable)(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error))completionHandler;

- (void)consume:(NSString*_Nonnull)strURL
      method:(HttpMethod)method
     headers:(NSDictionary*_Nullable)headers
   andParams:(NSDictionary*_Nullable)params
            res:(void (^_Nonnull)(NSDictionary * _Nullable json, NSError * _Nullable error))completionHandler;
+ (void)QueryRequestCall:(NSString*_Nonnull)strURL
      method:(HttpMethod)method
     headers:(NSDictionary*_Nullable)headers
   andParams:(NSDictionary*_Nullable)params
            res:(void (^_Nonnull)(NSDictionary * _Nullable json, NSError * _Nullable error))completionHandler;
@end
