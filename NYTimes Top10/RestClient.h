//
//  RestClient.h
//  NYTimes Top10
//
//  Created by vishal dhiman on 14/01/17.
//  Copyright © 2017 vishal dhiman. All rights reserved.
//

#import <Foundation/Foundation.h>


@protocol RestClientDelegate;

@interface RestClient : NSObject <NSURLConnectionDelegate, NSURLConnectionDataDelegate>

-(instancetype)initWithUrlString:(NSString*)urlString postString:(NSString*)postStr methodType:(NSString*)httpMethod completionHandler:(void (^)(NSInteger responseCode, NSData* data, NSError* connectionError)) handler;
-(void)stopLoading;
-(void)loadRequest;

@property (nonatomic, copy) void (^responseHandler)(NSInteger responseCode, NSData* data, NSError* connectionError);

@property (nonatomic, weak) id<RestClientDelegate> delegate;

@property (nonatomic, copy) NSString *urlStr;
@property (nonatomic, copy) NSString *httpMethodType;
@property (nonatomic, copy) NSString *queryStr;
@property (nonatomic, readwrite) BOOL isJsonRequest;

@property (nonatomic, strong) NSURLConnection *urlConnection;

@property (nonatomic ) NSInteger resposeStatus;
@property (nonatomic, strong) NSMutableData* connData;


@end


@protocol RestClientDelegate <NSObject>

-(void) restClient:(RestClient*)client didFinishWithObject:(id)object;
-(void) restClient:(RestClient*)client didFailWithError:(NSError *)error;

@end
