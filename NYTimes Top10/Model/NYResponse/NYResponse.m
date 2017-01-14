//
//  NYResponse.m
//
//  Created by VISHAL DHIMAN on 14/01/17
//  Copyright (c) 2017 __MyCompanyName__. All rights reserved.
//

#import "NYResponse.h"
#import "NYResults.h"


NSString *const kNYResponseStatus = @"status";
NSString *const kNYResponseResults = @"results";
NSString *const kNYResponseCopyright = @"copyright";
NSString *const kNYResponseNumResults = @"num_results";


@interface NYResponse ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation NYResponse

@synthesize status = _status;
@synthesize results = _results;
@synthesize copyright = _copyright;
@synthesize numResults = _numResults;


+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict {
    return [[self alloc] initWithDictionary:dict];
}

- (instancetype)initWithDictionary:(NSDictionary *)dict {
    self = [super init];
    
    // This check serves to make sure that a non-NSDictionary object
    // passed into the model class doesn't break the parsing.
    if (self && [dict isKindOfClass:[NSDictionary class]]) {
            self.status = [self objectOrNilForKey:kNYResponseStatus fromDictionary:dict];
    NSObject *receivedNYResults = [dict objectForKey:kNYResponseResults];
    NSMutableArray *parsedNYResults = [NSMutableArray array];
    
    if ([receivedNYResults isKindOfClass:[NSArray class]]) {
        for (NSDictionary *item in (NSArray *)receivedNYResults) {
            if ([item isKindOfClass:[NSDictionary class]]) {
                [parsedNYResults addObject:[NYResults modelObjectWithDictionary:item]];
            }
       }
    } else if ([receivedNYResults isKindOfClass:[NSDictionary class]]) {
       [parsedNYResults addObject:[NYResults modelObjectWithDictionary:(NSDictionary *)receivedNYResults]];
    }

    self.results = [NSArray arrayWithArray:parsedNYResults];
            self.copyright = [self objectOrNilForKey:kNYResponseCopyright fromDictionary:dict];
            self.numResults = [[self objectOrNilForKey:kNYResponseNumResults fromDictionary:dict] doubleValue];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation {
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.status forKey:kNYResponseStatus];
    NSMutableArray *tempArrayForResults = [NSMutableArray array];
    
    for (NSObject *subArrayObject in self.results) {
        if ([subArrayObject respondsToSelector:@selector(dictionaryRepresentation)]) {
            // This class is a model object
            [tempArrayForResults addObject:[subArrayObject performSelector:@selector(dictionaryRepresentation)]];
        } else {
            // Generic object
            [tempArrayForResults addObject:subArrayObject];
        }
    }
    [mutableDict setValue:[NSArray arrayWithArray:tempArrayForResults] forKey:kNYResponseResults];
    [mutableDict setValue:self.copyright forKey:kNYResponseCopyright];
    [mutableDict setValue:[NSNumber numberWithDouble:self.numResults] forKey:kNYResponseNumResults];

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

    self.status = [aDecoder decodeObjectForKey:kNYResponseStatus];
    self.results = [aDecoder decodeObjectForKey:kNYResponseResults];
    self.copyright = [aDecoder decodeObjectForKey:kNYResponseCopyright];
    self.numResults = [aDecoder decodeDoubleForKey:kNYResponseNumResults];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_status forKey:kNYResponseStatus];
    [aCoder encodeObject:_results forKey:kNYResponseResults];
    [aCoder encodeObject:_copyright forKey:kNYResponseCopyright];
    [aCoder encodeDouble:_numResults forKey:kNYResponseNumResults];
}

- (id)copyWithZone:(NSZone *)zone {
    NYResponse *copy = [[NYResponse alloc] init];
    
    
    
    if (copy) {

        copy.status = [self.status copyWithZone:zone];
        copy.results = [self.results copyWithZone:zone];
        copy.copyright = [self.copyright copyWithZone:zone];
        copy.numResults = self.numResults;
    }
    
    return copy;
}


@end
