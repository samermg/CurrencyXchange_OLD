//
//  Download.m
//  Test
//
//  Created by PACI on 2/15/24.
//

#import "APIClient.h"
#import "SGAPI.h"
@implementation APIClient
-(id)init {
    self= [super init];
    if (self) {
        _FileURL=@"";
        _HttpHeaderFields = [NSDictionary dictionary];
        _isFinishedDownloading = NO;
    }
    return self;
}
-(void)setFileURL:(NSString*)url {
    _FileURL = url;
}
-(NSString*)getFileURL {
    return _FileURL;
}
-(void)setHTTPMethod:(HttpMethod)Method {
    _HttpMethod = Method;
}
-(HttpMethod)getHTTPMethod {
    return _HttpMethod;
}
-(void)setHttpHeaderFields:(NSDictionary*)headers {
    _HttpHeaderFields = headers;
}
-(NSDictionary*)getHeaderFields {
    return _HttpHeaderFields;
}
-(void)setAdditionalParameters:(NSDictionary*)additionalParameters {
    _AdditionalParameters =additionalParameters;
}
-(NSDictionary*)getAdditionalParameter {
    return _AdditionalParameters;
}
-(void)setIsFinishedDownloading:(Boolean)isFinished {
    _isFinishedDownloading = isFinished;
}
-(BOOL)getIsFinishedDownloading {
    return _isFinishedDownloading;
}
-(NSURL*)url {
    return [[NSURL alloc]initWithString:_FileURL];
}
-(void)Login {
    if ([_FileURL isEqual:@""] || [_FileURL length]<10) {
        if ([[self delegate] respondsToSelector:@selector(APIRequest:didFinishRequestWithError:)]) {
            NSString* err =@"URL is not valid or URL is not found";
            [[self delegate] APIRequest:self didFinishRequestWithError:err];
        }
    } else {
        dispatch_queue_t dwnQueue = dispatch_queue_create("StartQ", NULL);
        dispatch_async(dwnQueue, ^ {
            [SGAPI QueryRequestCall:LOGIN_API method:self->_HttpMethod headers:self->_HttpHeaderFields andParams:self->_AdditionalParameters res:^(NSDictionary * _Nullable json, NSError * _Nullable error) {
                //NSLog(@"JSON: %@",json);
                dispatch_async(dispatch_get_main_queue(), ^{
                    if ([[self delegate] respondsToSelector:@selector(APIRequest:didFinishRequestWithContent:)]) {
                        [[self delegate] APIRequest:self didFinishRequestWithContent:json];
                    }
                });
            }];
            
            
        });
    }
}
@end
