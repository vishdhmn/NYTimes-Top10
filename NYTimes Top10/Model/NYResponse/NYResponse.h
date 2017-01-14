//
//  NYResponse.h
//
//  Created by VISHAL DHIMAN on 14/01/17
//  Copyright (c) 2017 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface NYResponse : NSObject <NSCoding, NSCopying>

@property (nonatomic, strong) NSString *status;
@property (nonatomic, strong) NSArray *results;
@property (nonatomic, strong) NSString *copyright;
@property (nonatomic, assign) double numResults;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
