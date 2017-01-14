//
//  NYMediaMetadata.h
//
//  Created by VISHAL DHIMAN on 14/01/17
//  Copyright (c) 2017 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface NYMediaMetadata : NSObject <NSCoding, NSCopying>

@property (nonatomic, assign) double height;
@property (nonatomic, assign) double width;
@property (nonatomic, strong) NSString *url;
@property (nonatomic, strong) NSString *format;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
