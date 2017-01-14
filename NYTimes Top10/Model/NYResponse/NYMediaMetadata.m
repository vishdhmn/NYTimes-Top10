//
//  NYMediaMetadata.m
//
//  Created by VISHAL DHIMAN on 14/01/17
//  Copyright (c) 2017 __MyCompanyName__. All rights reserved.
//

#import "NYMediaMetadata.h"


NSString *const kNYMediaMetadataHeight = @"height";
NSString *const kNYMediaMetadataWidth = @"width";
NSString *const kNYMediaMetadataUrl = @"url";
NSString *const kNYMediaMetadataFormat = @"format";


@interface NYMediaMetadata ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation NYMediaMetadata

@synthesize height = _height;
@synthesize width = _width;
@synthesize url = _url;
@synthesize format = _format;


+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict {
    return [[self alloc] initWithDictionary:dict];
}

- (instancetype)initWithDictionary:(NSDictionary *)dict {
    self = [super init];
    
    // This check serves to make sure that a non-NSDictionary object
    // passed into the model class doesn't break the parsing.
    if (self && [dict isKindOfClass:[NSDictionary class]]) {
            self.height = [[self objectOrNilForKey:kNYMediaMetadataHeight fromDictionary:dict] doubleValue];
            self.width = [[self objectOrNilForKey:kNYMediaMetadataWidth fromDictionary:dict] doubleValue];
            self.url = [self objectOrNilForKey:kNYMediaMetadataUrl fromDictionary:dict];
            self.format = [self objectOrNilForKey:kNYMediaMetadataFormat fromDictionary:dict];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation {
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:[NSNumber numberWithDouble:self.height] forKey:kNYMediaMetadataHeight];
    [mutableDict setValue:[NSNumber numberWithDouble:self.width] forKey:kNYMediaMetadataWidth];
    [mutableDict setValue:self.url forKey:kNYMediaMetadataUrl];
    [mutableDict setValue:self.format forKey:kNYMediaMetadataFormat];

    return [NSDictionary dictionaryWithDictionary:mutableDict];
}

- (NSString *)description  {
    return [NSString stringWithFormat:@"%@", [self dictionaryRepresentation]];
}

#pragma mark - Helper Method
- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict {
    id object = [dict objectForKey:aKey];
    return [object isEqual:[NSNull null]] ? nil : object;
}


#pragma mark - NSCoding Methods

- (id)initWithCoder:(NSCoder *)aDecoder {
    self = [super init];

    self.height = [aDecoder decodeDoubleForKey:kNYMediaMetadataHeight];
    self.width = [aDecoder decodeDoubleForKey:kNYMediaMetadataWidth];
    self.url = [aDecoder decodeObjectForKey:kNYMediaMetadataUrl];
    self.format = [aDecoder decodeObjectForKey:kNYMediaMetadataFormat];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeDouble:_height forKey:kNYMediaMetadataHeight];
    [aCoder encodeDouble:_width forKey:kNYMediaMetadataWidth];
    [aCoder encodeObject:_url forKey:kNYMediaMetadataUrl];
    [aCoder encodeObject:_format forKey:kNYMediaMetadataFormat];
}

- (id)copyWithZone:(NSZone *)zone {
    NYMediaMetadata *copy = [[NYMediaMetadata alloc] init];
    
    
    
    if (copy) {

        copy.height = self.height;
        copy.width = self.width;
        copy.url = [self.url copyWithZone:zone];
        copy.format = [self.format copyWithZone:zone];
    }
    
    return copy;
}


@end
