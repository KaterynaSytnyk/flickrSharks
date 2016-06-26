//
//  ParsingManager.m
//  AcronymList
//
//  Created by Kateryna Sytnyk on 12/16/15.
//  Copyright © 2015 KaterynaSytnyk. All rights reserved.
//

#import "ParsingManager.h"
#import "FastEasyMapping.h"
#import "SharkPhoto.h"

static NSString *const SearchParameterString = @"text";
static NSString *const MethodParameterString = @"method";
static NSString *const APIKeyParameterString = @"api_key";
static NSString *const FormatParameterString = @"format";
static NSString *const NoJsonCallbackParameterString = @"nojsoncallback";
static NSString *const PageParameterString = @"page";
static NSString *const ExtrasParameterString = @"extras";

static NSString *const SharkSearchString = @"shark";
static NSString *const FlickrAPIKey = @"949e98778755d1982f537d56236bbb42";
static NSString *const FlickrSearchMethodName = @"flickr.photos.search";
static NSString *const FormatParameterJSON = @"json";
static NSString *const NoJsonCallbackValue = @"1";
static NSString *const ExtrasParameterValue = @"url_t,url_c,url_l,url_o";

@interface ParsingManager ()

@end

@implementation ParsingManager

+ (instancetype)sharedManager {
    static ParsingManager *sharedManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedManager = [ParsingManager new];
    });
    return sharedManager;
}

#pragma mark - Flickr Photo Search Input Dictionaries

- (NSDictionary *)dictionaryForSharkFeedSearchWithPage:(NSInteger)page {
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionaryWithDictionary:[self dictionaryForFlickrPhotoSearch]];
    
    [mutableDict setValue:SharkSearchString forKey:SearchParameterString];
    [mutableDict setValue:[NSString stringWithFormat:@"%d", page] forKey:PageParameterString];
    
    return [NSDictionary dictionaryWithDictionary:mutableDict];
}

- (NSDictionary *)dictionaryForFlickrPhotoSearch {
    NSMutableDictionary *mutableDict = [NSMutableDictionary new];
    [mutableDict setValue:FlickrSearchMethodName forKey:MethodParameterString];
    [mutableDict setValue:FlickrAPIKey forKey:APIKeyParameterString];
    [mutableDict setValue:FormatParameterJSON forKey:FormatParameterString];
    [mutableDict setValue:NoJsonCallbackValue forKey:NoJsonCallbackParameterString];
    [mutableDict setValue:ExtrasParameterValue forKey:ExtrasParameterString];
    
    return [NSDictionary dictionaryWithDictionary:mutableDict];
}

- (NSArray *)sharkPhotosArrayFromDictionary:(NSDictionary *)sharkPhotosListDictionary {
    if (!sharkPhotosListDictionary) {
        return nil;
    }

    id rootLevelPhotosDictionary = nil;
    id photosArray = nil;
    rootLevelPhotosDictionary = sharkPhotosListDictionary[@"photos"];
    
    if ([rootLevelPhotosDictionary isKindOfClass:[NSDictionary class]]) {
        photosArray = rootLevelPhotosDictionary[@"photo"];
        
    } else {
        NSLog(@"Invalid data returned. Aborting.");
        return nil;
    }

    
    if ([photosArray isKindOfClass:[NSArray class]]) {

        NSArray *acronymMeaningsArray = [self sharkPhotosFromArray:photosArray];
        return acronymMeaningsArray;

    } else {
        NSLog(@"Invalid data returned. Aborting.");
        return nil;
    }
}

- (NSArray *)sharkPhotosFromArray:(NSArray *)sharkPhotosRawArray {
    NSMutableArray *sharkPhotos = [NSMutableArray array];
    for (NSDictionary *sharkPhotoDictionary in sharkPhotosRawArray) {
        SharkPhoto *sharkPhoto = [self sharkPhotoFromDictionary:sharkPhotoDictionary];
        [sharkPhotos addObject:sharkPhoto];
    }
    return [NSArray arrayWithArray:sharkPhotos];
}


- (SharkPhoto *)sharkPhotoFromDictionary:(NSDictionary *)photoDictionary {
    SharkPhoto *sharkPhoto = [FEMObjectDeserializer deserializeObjectExternalRepresentation:photoDictionary usingMapping:[self sharkPhotoMapping]];
    
    return sharkPhoto;
}


#pragma mark - Mappings

- (FEMObjectMapping *)sharkPhotoMapping {
    return [FEMObjectMapping mappingForClass:[SharkPhoto class] configuration:^(FEMObjectMapping *mapping) {
        [mapping addAttributesFromDictionary:@{@"photoTitle" : @"title",
                                               @"thumbnailImageURL" : @"url_t",
                                               @"largeImageURL" : @"url_l"
                                               }];
    }];
};


@end
