//
//  Download.h
//  Test
//
//  Created by PACI on 2/15/24.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import "Helper.h"
static int counter;
static NSTimeInterval executionTime;


NS_ASSUME_NONNULL_BEGIN
@class APIClient;

@protocol APIClientDelegate <NSObject>
@optional
-(void)APIRequest:(APIClient*_Nullable)call didFinishRequestWithError:(NSString*_Nullable)error;
-(void)APIRequest:(APIClient*_Nullable)load didFinishRequestWithContent:(NSDictionary*_Nullable)data;
@end
typedef void (^WebAPIServerResponse)(NSDictionary* _Nullable results, NSError* _Nullable error);

@interface APIClient : NSObject {
    NSString* _FileURL;
    NSDictionary* _HttpHeaderFields;
    NSDictionary* _AdditionalParameters;
    HttpMethod _HttpMethod;
    BOOL _isFinishedDownloading;
}
@property (weak,nonatomic) id<APIClientDelegate>_Nullable delegate;
-(id)init;
#pragma API URL
-(void)setFileURL:(NSString*)url;
-(NSString*)getFileURL;
#pragma API HTTP Method
-(void)setHTTPMethod:(HttpMethod)Method;
-(HttpMethod)getHTTPMethod;
#pragma API HTTP Header
-(void)setHttpHeaderFields:(NSDictionary*)headers;
-(NSDictionary*)getHeaderFields;
#pragma API HTTP Parameters
-(void)setAdditionalParameters:(NSDictionary*)additionalParameters;
-(NSDictionary*)getAdditionalParameter;
-(void)Featch;
-(void)Execute:(WebAPIServerResponse)block;
-(void)ExecutePOST:(WebAPIServerResponse)block;

@end

NS_ASSUME_NONNULL_END
