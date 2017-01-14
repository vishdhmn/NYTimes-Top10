//
//  NYMedia.m
//
//  Created by VISHAL DHIMAN on 14/01/17
//  Copyright (c) 2017 __MyCompanyName__. All rights reserved.
//

#import "NYMedia.h"
#import "NYMediaMetadata.h"


NSString *const kNYMediaCopyright = @"copyright";
NSString *const kNYMediaCaption = @"caption";
NSString *const kNYMediaType = @"type";
NSString *const kNYMediaSubtype = @"subtype";
NSString *const kNYMediaMediaMetadata = @"media-metadata";


@interface NYMedia ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation NYMedia

@synthesize copyright = _copyright;
@synthesize caption = _caption;
@synthesize type = _type;
@synthesize subtype = _subtype;
@synthesize mediaMetadata = _mediaMetadata;


+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict {
    return [[self alloc] initWithDictionary:dict];
}

- (instancetype)initWithDictionary:(NSDictionary *)dict {
    self = [super init];
    
    // This check serves to make sure that a non-NSDictionary object
    // passed into the model class doesn't break the parsing.
    if (self && [dict isKindOfClass:[NSDictionary class]]) {
            self.copyright = [self objectOrNilForKey:kNYMediaCopyright fromDictionary:dict];
            self.caption = [self objectOrNilForKey:kNYMediaCaption fromDictionary:dict];
            self.type = [self objectOrNilForKey:kNYMediaType fromDictionary:dict];
            self.subtype = [self objectOrNilForKey:kNYMediaSubtype fromDictionary:dict];
    NSObject *receivedNYMediaMetadata = [dict objectForKey:kNYMediaMediaMetadata];
    NSMutableArray *parsedNYMediaMetadata = [NSMutableArray array];
    
    if ([receivedNYMediaMetadata isKindOfClass:[NSArray class]]) {
        for (NSDictionary *item in (NSArray *)receivedNYMediaMetadata) {
            if ([item isKindOfClass:[NSDictionary class]]) {
                [parsedNYMediaMetadata addObject:[NYMediaMetadata modelObjectWithDictionary:item]];
            }
       }
    } else if ([receivedNYMediaMetadata isKindOfClass:[NSDictionary class]]) {
       [parsedNYMediaMetadata addObject:[NYMediaMetadata modelObjectWithDictionary:(NSDictionary *)receivedNYMediaMetadata]];
    }

    self.mediaMetadata = [NSArray arrayWithArray:parsedNYMediaMetadata];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation {
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.copyright forKey:kNYMediaCopyright];
    [mutableDict setValue:self.caption forKey:kNYMediaCaption];
    [mutableDict setValue:self.type forKey:kNYMediaType];
    [mutableDict setValue:self.subtype forKey:kNYMediaSubtype];
    NSMutableArray *tempArrayForMediaMetadata = [NSMutableArray array];
    
    for (NSObject *subArrayObject in self.mediaMetadata) {
        if ([subArrayObject respondsToSelector:@selector(dictionaryRepresentation)]) {
            // This class is a model object
            [tempArrayForMediaMetadata addObject:[subArrayObject performSelector:@selector(dictionaryRepresentation)]];
        } else {
            // Generic object
            [tempArrayForMediaMetadata addObject:subArrayObject];
        }
    }
    [mutableDict setValue:[NSArray arrayWithArray:tempArrayForMediaMetadata] forKey:kNYMediaMediaMetadata];

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

    self.copyright = [aDecoder decodeObjectForKey:kNYMediaCopyright];
    self.caption = [aDecoder decodeObjectForKey:kNYMediaCaption];
    self.type = [aDecoder decodeObjectForKey:kNYMediaType];
    self.subtype = [aDecoder decodeObjectForKey:kNYMediaSubtype];
    self.mediaMetadata = [aDecoder decodeObjectForKey:kNYMediaMediaMetadata];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_copyright forKey:kNYMediaCopyright];
    [aCoder encodeObject:_caption forKey:kNYMediaCaption];
    [aCoder encodeObject:_type forKey:kNYMediaType];
    [aCoder encodeObject:_subtype forKey:kNYMediaSubtype];
    [aCoder encodeObject:_mediaMetadata forKey:kNYMediaMediaMetadata];
}

- (id)copyWithZone:(NSZone *)zone {
    NYMedia *copy = [[NYMedia alloc] init];
    
    
    
    if (copy) {

        copy.copyright = [self.copyright copyWithZone:zone];
        copy.caption = [self.caption copyWithZone:zone];
        copy.type = [self.type copyWithZone:zone];
        copy.subtype = [self.subtype copyWithZone:zone];
        copy.mediaMetadata = [self.mediaMetadata copyWithZone:zone];
    }
    
    return copy;
}


@end
