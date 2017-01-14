//
//  NYResults.h
//
//  Created by VISHAL DHIMAN on 14/01/17
//  Copyright (c) 2017 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface NYResults : NSObject <NSCoding, NSCopying>

@property (nonatomic, assign) double resultsIdentifier;
@property (nonatomic, strong) NSString *section;
@property (nonatomic, strong) NSString *adxKeywords;
@property (nonatomic, strong) NSString *column;
@property (nonatomic, assign) double assetId;
@property (nonatomic, strong) NSArray *desFacet;
@property (nonatomic, strong) NSString *byline;
@property (nonatomic, strong) NSString *abstract;
@property (nonatomic, strong) NSArray *orgFacet;
@property (nonatomic, strong) NSString *url;
@property (nonatomic, strong) NSString *type;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *source;
@property (nonatomic, strong) NSString *geoFacet;
@property (nonatomic, strong) NSString *publishedDate;
@property (nonatomic, strong) NSArray *perFacet;
@property (nonatomic, strong) NSArray *media;
@property (nonatomic, assign) double views;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
