//
//  RestClient.m
//  NYTimes Top10
//
//  Created by vishal dhiman on 14/01/17.
//  Copyright © 2017 vishal dhiman. All rights reserved.
//

#import "RestClient.h"
#import "Constants/NYConstants.h"

@implementation RestClient

-(instancetype)initWithUrlString:(NSString*)urlString postString:(NSString*)postStr methodType:(NSString*)httpMethod completionHandler:(void (^)(NSInteger responseCode, NSData* data, NSError* connectionError)) handler{
    self = [super init];
    if (self) {
        self.queryStr = postStr;
        self.urlStr = urlString;
        self.httpMethodType = httpMethod;
        self.isJsonRequest = true;
        if (handler) {
            self.responseHandler = handler;
        }
        self.resposeStatus = -1;
    }

    return self;
}

-(void)stopLoading{
    self.delegate = nil;
    self.responseHandler = nil;
}

-(void)loadRequest{

    self.queryStr = [NSString stringWithFormat:@"&api-key=%@", API_KEY];

    NSURL *connUrl = [NSURL URLWithString:[NSString stringWithFormat:@"%@?%@", self.urlStr, self.queryStr]];
    
    NSMutableURLRequest *urlRequest = [NSMutableURLRequest requestWithURL:connUrl cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:60];
    

    DEBUG_LOG(@"Loading request: %@?%@", self.urlStr, self.queryStr);

    self.urlConnection = [NSURLConnection connectionWithRequest:urlRequest delegate:self];
    if (!self.urlConnection) {
        dispatch_async(dispatch_get_main_queue(), ^{
            if (self.delegate) {
                [self.delegate restClient:self didFailWithError:nil];
            }else if (self.responseHandler){
                self.responseHandler(self.resposeStatus, self.connData, nil);
            };
        });
    }
}


#pragma mark - NSUrlConnectionDelegate
//-(NSURLRequest *)connection:(NSURLConnection *)connection willSendRequest:(NSURLRequest *)request redirectResponse:(NSURLResponse *)response{
//    
//    
//    return request;
//}

- (BOOL)connection:(NSURLConnection *)connection canAuthenticateAgainstProtectionSpace:(NSURLProtectionSpace *)protectionSpace {
    return [protectionSpace.authenticationMethod isEqualToString:NSURLAuthenticationMethodServerTrust];
}

- (void)connection:(NSURLConnection *)connection didReceiveAuthenticationChallenge:(NSURLAuthenticationChallenge *)challenge {
    if ([challenge.protectionSpace.authenticationMethod isEqualToString:NSURLAuthenticationMethodServerTrust])
        [challenge.sender useCredential:[NSURLCredential credentialForTrust:challenge.protectionSpace.serverTrust] forAuthenticationChallenge:challenge];

    [challenge.sender continueWithoutCredentialForAuthenticationChallenge:challenge];
}

#pragma mark- NSURLConnectionDataDelegate
- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response{
    self.resposeStatus = [(NSHTTPURLResponse*)response statusCode];
    self.connData = [[NSMutableData alloc] init];
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data{
    DEBUG_LOG(@"data for : %@", self.queryStr);
    [self.connData appendData:data];
}

-(void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error{

    DEBUG_LOG(@"didfail for : %@", self.queryStr);
    static BOOL retried = false;
    if (error.code == -1005 && !retried) {
        retried = true;
        DEBUG_LOG(@"Retrying request!!\n%@", connection.originalRequest.URL);
        [self loadRequest];
        return;
    }

    dispatch_async(dispatch_get_main_queue(), ^{
        if (self.delegate) {
            [self.delegate restClient:self didFailWithError:error];
        }else if (self.responseHandler){
            self.responseHandler(self.resposeStatus, self.connData, error);
        }
    });
    DEBUG_LOG(@"Failed connection. Please check, %@", error.debugDescription);
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection{
    //DEBUG_LOG(@"is main thread %@", [NSThread isMainThread]?@"YES": @"NO");
    DEBUG_LOG(@"didfinish for : %@", self.queryStr);

    DEBUG_LOG(@"URL: %@\n Response:\n%@ ", connection.originalRequest, [[NSString alloc] initWithData:self.connData encoding:NSUTF8StringEncoding]);
    @try {
        id jsonObject=[NSJSONSerialization
                       JSONObjectWithData:self.connData
                       options:NSJSONReadingMutableLeaves|NSJSONReadingAllowFragments|NSJSONReadingMutableContainers
                       error:nil];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            if (self.delegate) {
                [self.delegate restClient:self didFinishWithObject:jsonObject];
            }else if ([self responseHandler]){
                self.responseHandler(self.resposeStatus, self.connData, nil);
            }

        });

    }
    @catch (NSException *exception) {
        DEBUG_LOG(@"Exception: %@", exception.debugDescription);
        dispatch_async(dispatch_get_main_queue(), ^{
            if (self.delegate) {
                [self.delegate restClient:self didFailWithError:nil];
            }else if (self.responseHandler){
                self.responseHandler(self.resposeStatus, self.connData, nil);
            }
        });
    }
}

@end
