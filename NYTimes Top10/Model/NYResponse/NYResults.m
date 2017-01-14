//
//  NYResults.m
//
//  Created by VISHAL DHIMAN on 14/01/17
//  Copyright (c) 2017 __MyCompanyName__. All rights reserved.
//

#import "NYResults.h"
#import "NYMedia.h"


NSString *const kNYResultsId = @"id";
NSString *const kNYResultsSection = @"section";
NSString *const kNYResultsAdxKeywords = @"adx_keywords";
NSString *const kNYResultsColumn = @"column";
NSString *const kNYResultsAssetId = @"asset_id";
NSString *const kNYResultsDesFacet = @"des_facet";
NSString *const kNYResultsByline = @"byline";
NSString *const kNYResultsAbstract = @"abstract";
NSString *const kNYResultsOrgFacet = @"org_facet";
NSString *const kNYResultsUrl = @"url";
NSString *const kNYResultsType = @"type";
NSString *const kNYResultsTitle = @"title";
NSString *const kNYResultsSource = @"source";
NSString *const kNYResultsGeoFacet = @"geo_facet";
NSString *const kNYResultsPublishedDate = @"published_date";
NSString *const kNYResultsPerFacet = @"per_facet";
NSString *const kNYResultsMedia = @"media";
NSString *const kNYResultsViews = @"views";


@interface NYResults ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation NYResults

@synthesize resultsIdentifier = _resultsIdentifier;
@synthesize section = _section;
@synthesize adxKeywords = _adxKeywords;
@synthesize column = _column;
@synthesize assetId = _assetId;
@synthesize desFacet = _desFacet;
@synthesize byline = _byline;
@synthesize abstract = _abstract;
@synthesize orgFacet = _orgFacet;
@synthesize url = _url;
@synthesize type = _type;
@synthesize title = _title;
@synthesize source = _source;
@synthesize geoFacet = _geoFacet;
@synthesize publishedDate = _publishedDate;
@synthesize perFacet = _perFacet;
@synthesize media = _media;
@synthesize views = _views;


+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict {
    return [[self alloc] initWithDictionary:dict];
}

- (instancetype)initWithDictionary:(NSDictionary *)dict {
    self = [super init];
    
    // This check serves to make sure that a non-NSDictionary object
    // passed into the model class doesn't break the parsing.
    if (self && [dict isKindOfClass:[NSDictionary class]]) {
            self.resultsIdentifier = [[self objectOrNilForKey:kNYResultsId fromDictionary:dict] doubleValue];
            self.section = [self objectOrNilForKey:kNYResultsSection fromDictionary:dict];
            self.adxKeywords = [self objectOrNilForKey:kNYResultsAdxKeywords fromDictionary:dict];
            self.column = [self objectOrNilForKey:kNYResultsColumn fromDictionary:dict];
            self.assetId = [[self objectOrNilForKey:kNYResultsAssetId fromDictionary:dict] doubleValue];
            self.desFacet = [self objectOrNilForKey:kNYResultsDesFacet fromDictionary:dict];
            self.byline = [self objectOrNilForKey:kNYResultsByline fromDictionary:dict];
            self.abstract = [self objectOrNilForKey:kNYResultsAbstract fromDictionary:dict];
            self.orgFacet = [self objectOrNilForKey:kNYResultsOrgFacet fromDictionary:dict];
            self.url = [self objectOrNilForKey:kNYResultsUrl fromDictionary:dict];
            self.type = [self objectOrNilForKey:kNYResultsType fromDictionary:dict];
            self.title = [self objectOrNilForKey:kNYResultsTitle fromDictionary:dict];
            self.source = [self objectOrNilForKey:kNYResultsSource fromDictionary:dict];
            self.geoFacet = [self objectOrNilForKey:kNYResultsGeoFacet fromDictionary:dict];
            self.publishedDate = [self objectOrNilForKey:kNYResultsPublishedDate fromDictionary:dict];
            self.perFacet = [self objectOrNilForKey:kNYResultsPerFacet fromDictionary:dict];
    NSObject *receivedNYMedia = [dict objectForKey:kNYResultsMedia];
    NSMutableArray *parsedNYMedia = [NSMutableArray array];
    
    if ([receivedNYMedia isKindOfClass:[NSArray class]]) {
        for (NSDictionary *item in (NSArray *)receivedNYMedia) {
            if ([item isKindOfClass:[NSDictionary class]]) {
                [parsedNYMedia addObject:[NYMedia modelObjectWithDictionary:item]];
            }
       }
    } else if ([receivedNYMedia isKindOfClass:[NSDictionary class]]) {
       [parsedNYMedia addObject:[NYMedia modelObjectWithDictionary:(NSDictionary *)receivedNYMedia]];
    }

    self.media = [NSArray arrayWithArray:parsedNYMedia];
            self.views = [[self objectOrNilForKey:kNYResultsViews fromDictionary:dict] doubleValue];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation {
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:[NSNumber numberWithDouble:self.resultsIdentifier] forKey:kNYResultsId];
    [mutableDict setValue:self.section forKey:kNYResultsSection];
    [mutableDict setValue:self.adxKeywords forKey:kNYResultsAdxKeywords];
    [mutableDict setValue:self.column forKey:kNYResultsColumn];
    [mutableDict setValue:[NSNumber numberWithDouble:self.assetId] forKey:kNYResultsAssetId];
    NSMutableArray *tempArrayForDesFacet = [NSMutableArray array];
    
    for (NSObject *subArrayObject in self.desFacet) {
        if ([subArrayObject respondsToSelector:@selector(dictionaryRepresentation)]) {
            // This class is a model object
            [tempArrayForDesFacet addObject:[subArrayObject performSelector:@selector(dictionaryRepresentation)]];
        } else {
            // Generic object
            [tempArrayForDesFacet addObject:subArrayObject];
        }
    }
    [mutableDict setValue:[NSArray arrayWithArray:tempArrayForDesFacet] forKey:kNYResultsDesFacet];
    [mutableDict setValue:self.byline forKey:kNYResultsByline];
    [mutableDict setValue:self.abstract forKey:kNYResultsAbstract];
    NSMutableArray *tempArrayForOrgFacet = [NSMutableArray array];
    
    for (NSObject *subArrayObject in self.orgFacet) {
        if ([subArrayObject respondsToSelector:@selector(dictionaryRepresentation)]) {
            // This class is a model object
            [tempArrayForOrgFacet addObject:[subArrayObject performSelector:@selector(dictionaryRepresentation)]];
        } else {
            // Generic object
            [tempArrayForOrgFacet addObject:subArrayObject];
        }
    }
    [mutableDict setValue:[NSArray arrayWithArray:tempArrayForOrgFacet] forKey:kNYResultsOrgFacet];
    [mutableDict setValue:self.url forKey:kNYResultsUrl];
    [mutableDict setValue:self.type forKey:kNYResultsType];
    [mutableDict setValue:self.title forKey:kNYResultsTitle];
    [mutableDict setValue:self.source forKey:kNYResultsSource];
    [mutableDict setValue:self.geoFacet forKey:kNYResultsGeoFacet];
    [mutableDict setValue:self.publishedDate forKey:kNYResultsPublishedDate];
    NSMutableArray *tempArrayForPerFacet = [NSMutableArray array];
    
    for (NSObject *subArrayObject in self.perFacet) {
        if ([subArrayObject respondsToSelector:@selector(dictionaryRepresentation)]) {
            // This class is a model object
            [tempArrayForPerFacet addObject:[subArrayObject performSelector:@selector(dictionaryRepresentation)]];
        } else {
            // Generic object
            [tempArrayForPerFacet addObject:subArrayObject];
        }
    }
    [mutableDict setValue:[NSArray arrayWithArray:tempArrayForPerFacet] forKey:kNYResultsPerFacet];
    NSMutableArray *tempArrayForMedia = [NSMutableArray array];
    
    for (NSObject *subArrayObject in self.media) {
        if ([subArrayObject respondsToSelector:@selector(dictionaryRepresentation)]) {
            // This class is a model object
            [tempArrayForMedia addObject:[subArrayObject performSelector:@selector(dictionaryRepresentation)]];
        } else {
            // Generic object
            [tempArrayForMedia addObject:subArrayObject];
        }
    }
    [mutableDict setValue:[NSArray arrayWithArray:tempArrayForMedia] forKey:kNYResultsMedia];
    [mutableDict setValue:[NSNumber numberWithDouble:self.views] forKey:kNYResultsViews];

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

    self.resultsIdentifier = [aDecoder decodeDoubleForKey:kNYResultsId];
    self.section = [aDecoder decodeObjectForKey:kNYResultsSection];
    self.adxKeywords = [aDecoder decodeObjectForKey:kNYResultsAdxKeywords];
    self.column = [aDecoder decodeObjectForKey:kNYResultsColumn];
    self.assetId = [aDecoder decodeDoubleForKey:kNYResultsAssetId];
    self.desFacet = [aDecoder decodeObjectForKey:kNYResultsDesFacet];
    self.byline = [aDecoder decodeObjectForKey:kNYResultsByline];
    self.abstract = [aDecoder decodeObjectForKey:kNYResultsAbstract];
    self.orgFacet = [aDecoder decodeObjectForKey:kNYResultsOrgFacet];
    self.url = [aDecoder decodeObjectForKey:kNYResultsUrl];
    self.type = [aDecoder decodeObjectForKey:kNYResultsType];
    self.title = [aDecoder decodeObjectForKey:kNYResultsTitle];
    self.source = [aDecoder decodeObjectForKey:kNYResultsSource];
    self.geoFacet = [aDecoder decodeObjectForKey:kNYResultsGeoFacet];
    self.publishedDate = [aDecoder decodeObjectForKey:kNYResultsPublishedDate];
    self.perFacet = [aDecoder decodeObjectForKey:kNYResultsPerFacet];
    self.media = [aDecoder decodeObjectForKey:kNYResultsMedia];
    self.views = [aDecoder decodeDoubleForKey:kNYResultsViews];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeDouble:_resultsIdentifier forKey:kNYResultsId];
    [aCoder encodeObject:_section forKey:kNYResultsSection];
    [aCoder encodeObject:_adxKeywords forKey:kNYResultsAdxKeywords];
    [aCoder encodeObject:_column forKey:kNYResultsColumn];
    [aCoder encodeDouble:_assetId forKey:kNYResultsAssetId];
    [aCoder encodeObject:_desFacet forKey:kNYResultsDesFacet];
    [aCoder encodeObject:_byline forKey:kNYResultsByline];
    [aCoder encodeObject:_abstract forKey:kNYResultsAbstract];
    [aCoder encodeObject:_orgFacet forKey:kNYResultsOrgFacet];
    [aCoder encodeObject:_url forKey:kNYResultsUrl];
    [aCoder encodeObject:_type forKey:kNYResultsType];
    [aCoder encodeObject:_title forKey:kNYResultsTitle];
    [aCoder encodeObject:_source forKey:kNYResultsSource];
    [aCoder encodeObject:_geoFacet forKey:kNYResultsGeoFacet];
    [aCoder encodeObject:_publishedDate forKey:kNYResultsPublishedDate];
    [aCoder encodeObject:_perFacet forKey:kNYResultsPerFacet];
    [aCoder encodeObject:_media forKey:kNYResultsMedia];
    [aCoder encodeDouble:_views forKey:kNYResultsViews];
}

- (id)copyWithZone:(NSZone *)zone {
    NYResults *copy = [[NYResults alloc] init];
    
    
    
    if (copy) {

        copy.resultsIdentifier = self.resultsIdentifier;
        copy.section = [self.section copyWithZone:zone];
        copy.adxKeywords = [self.adxKeywords copyWithZone:zone];
        copy.column = [self.column copyWithZone:zone];
        copy.assetId = self.assetId;
        copy.desFacet = [self.desFacet copyWithZone:zone];
        copy.byline = [self.byline copyWithZone:zone];
        copy.abstract = [self.abstract copyWithZone:zone];
        copy.orgFacet = [self.orgFacet copyWithZone:zone];
        copy.url = [self.url copyWithZone:zone];
        copy.type = [self.type copyWithZone:zone];
        copy.title = [self.title copyWithZone:zone];
        copy.source = [self.source copyWithZone:zone];
        copy.geoFacet = [self.geoFacet copyWithZone:zone];
        copy.publishedDate = [self.publishedDate copyWithZone:zone];
        copy.perFacet = [self.perFacet copyWithZone:zone];
        copy.media = [self.media copyWithZone:zone];
        copy.views = self.views;
    }
    
    return copy;
}


@end
