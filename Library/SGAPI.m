//
//  SGAPI.m
//  TableView
//
//  Created by Samer Ghanim on 08/02/2024.
//
#import "SGAPI.h"
@implementation SGAPI
- (void)hitAPI
{
    [self callAPI:@"https://graph.facebook.com/4" res:^(NSDictionary * _Nullable json, NSError * _Nullable error) {
        //NSLog(@"res %@, err %@", json, error);
    }];
}

- (void)callAPI:(NSString*)url res:(void (^)(NSDictionary * _Nullable json, NSError * _Nullable error))completionHandler {
    [self callAPI:url completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (error) {
            completionHandler(nil, error);
            return;
        }
        NSError* error1;
        NSDictionary* json = [NSJSONSerialization JSONObjectWithData:data
                                                             options:kNilOptions
                                                               error:&error1];
        dispatch_async(dispatch_get_main_queue(), ^{
            completionHandler(json, error1);
        });
    }];
}

- (void)callAPI:(NSString*)url completionHandler:(void (^)(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error))completionHandler {
    NSURLSession *defaultSession = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    NSURLRequest *urlRequest = [NSURLRequest requestWithURL:[NSURL URLWithString:url]];
    [[defaultSession dataTaskWithRequest:urlRequest
                       completionHandler:completionHandler] resume];
}

- (void)consume:(NSString*_Nonnull)strURL
         method:(HttpMethod)method
        headers:(NSDictionary*_Nullable)headers
      andParams:(NSDictionary*_Nullable)params
            res:(void (^_Nonnull)(NSDictionary * _Nullable json, NSError * _Nullable error))completionHandler {
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *session = [NSURLSession sessionWithConfiguration:configuration delegate:nil delegateQueue:nil];
    NSURL *url = [NSURL URLWithString:strURL];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url
                                                           cachePolicy:NSURLRequestUseProtocolCachePolicy
                                                       timeoutInterval:60.0];
    [request addValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [request addValue:@"application/json" forHTTPHeaderField:@"Accept"];
    for (NSString *key in headers) {
        [request addValue:headers[key] forHTTPHeaderField:key];
    }
    NSString *httpMethod_ = (method == GET) ? @"GET" : @"POST";
    [request setHTTPMethod:httpMethod_];
    if (params) {
        NSError *error;
        NSData *body = [NSJSONSerialization dataWithJSONObject:params options:0 error:&error];
        [request setHTTPBody:body];
    }
    [[session dataTaskWithRequest:request
                completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (error) {
            completionHandler(nil, error);
            return;
        }
        NSError* error1;
        id json = [NSJSONSerialization JSONObjectWithData:data
                                                  options:kNilOptions
                                                    error:&error1];
        dispatch_async(dispatch_get_main_queue(), ^{
            completionHandler(json, error1);
        });
    }] resume];
}

+ (void)call:(NSString*_Nonnull)strURL
      method:(HttpMethod)method
     headers:(NSDictionary*_Nullable)headers
   andParams:(NSDictionary*_Nullable)params
         res:(void (^_Nonnull)(NSDictionary * _Nullable json, NSError * _Nullable error))completionHandler {
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *session = [NSURLSession sessionWithConfiguration:configuration delegate:nil delegateQueue:nil];
    NSURL *url = [NSURL URLWithString:strURL];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url
                                                           cachePolicy:NSURLRequestUseProtocolCachePolicy
                                                       timeoutInterval:60.0];
    [request addValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [request addValue:@"application/json" forHTTPHeaderField:@"Accept"];
    for (NSString *key in headers) {
        [request addValue:headers[key] forHTTPHeaderField:key];
    }
    NSString *httpMethod_ = (method == GET) ? @"GET" : @"POST";
    [request setHTTPMethod:httpMethod_];
    
    if (params) {
        NSError *error;
        NSData *body = [NSJSONSerialization dataWithJSONObject:params options:0 error:&error];
        [request setHTTPBody:body];
    }
    [[session dataTaskWithRequest:request
                completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (error) {
            completionHandler(nil, error);
            return;
        }
        NSError* error1;
        id json = [NSJSONSerialization JSONObjectWithData:data
                                                  options:kNilOptions
                                                    error:&error1];
        dispatch_async(dispatch_get_main_queue(), ^{
            completionHandler(json, error1);
        });
    }] resume];
}
+ (void)QueryRequestCall:(NSString*_Nonnull)strURL
                  method:(HttpMethod)method
                 headers:(NSDictionary*_Nullable)headers
               andParams:(NSDictionary*_Nullable)params
                     res:(void (^_Nonnull)(NSDictionary * _Nullable json, NSError * _Nullable error))completionHandler {
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *session = [NSURLSession sessionWithConfiguration:configuration delegate:nil delegateQueue:nil];
    if (params) {
        NSMutableString*query = [[NSMutableString alloc]initWithString:strURL];
        int counter =0;
        for (NSString *key in params) {
            if (counter == 0) {
                [query appendString:@"?"];
            }
            [query appendString:[NSString stringWithFormat:@"%@=%@", key,params[key]]];
            if (counter < [params count]-1) {
                [query appendString:@"&"];
            }
            counter++;
        }
        strURL = query;
    }
    NSURL *url = [NSURL URLWithString:strURL];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:60.0];
    [request addValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [request addValue:@"application/json" forHTTPHeaderField:@"Accept"];
    for (NSString *key in headers) {
        [request addValue:headers[key] forHTTPHeaderField:key];
    }
    NSString *httpMethod_ = (method == GET) ? @"GET" : @"POST";
    [request setHTTPMethod:httpMethod_];
    
    [[session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (error) {
            completionHandler(nil, error);
            return;
        }
        NSError* error1;
        id json = [NSJSONSerialization JSONObjectWithData:data
                                                  options:kNilOptions
                                                    error:&error1];
        dispatch_async(dispatch_get_main_queue(), ^{
            completionHandler(json, error1);
        });
    }] resume];
}

//Add this utility method in your class.
- (NSDictionary *) dictionaryWithPropertiesOfObject:(id)obj
{
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];

    unsigned count;
    objc_property_t *properties = class_copyPropertyList([obj class], &count);

    for (int i = 0; i < count; i++) {
        NSString *key = [NSString stringWithUTF8String:property_getName(properties[i])];
        [dict setObject:[obj valueForKey:key] forKey:key];
    }

    free(properties);

    return [NSDictionary dictionaryWithDictionary:dict];
}
@end
