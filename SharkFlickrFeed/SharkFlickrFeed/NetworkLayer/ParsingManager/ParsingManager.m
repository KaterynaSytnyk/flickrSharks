//
//  ParsingManager.m
//  AcronymList
//
//  Created by Kateryna Sytnyk on 12/16/15.
//  Copyright © 2015 KaterynaSytnyk. All rights reserved.
//

#import "ParsingManager.h"
#import "FastEasyMapping.h"

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

//- (NSDictionary *)dictionaryContainingInfoForAcronymSearch:(Acronym *)acronym {
//    return [FEMSerializer serializeObject:acronym usingMapping:[self acronymMappingForMeaningsSearch]];
//}
//
//- (AcronymMeaning *)acronymMeaningFromDictionary:(NSDictionary *)acronymMeaningDictionary {
//    AcronymMeaning *acronymMeaning = [FEMObjectDeserializer deserializeObjectExternalRepresentation:acronymMeaningDictionary usingMapping:[self acronymMeaningMapping]];
//
//    return acronymMeaning;
//}
//
//- (NSArray *)acronymMeaningsArrayFromDictionary:(NSDictionary *)acronymMeaningsListDictionary {
//    if (!acronymMeaningsListDictionary) {
//        return nil;
//    }
//    
//    id objectToMap = nil;
//    
//    objectToMap = acronymMeaningsListDictionary[@"lfs"];
//    if ([objectToMap isKindOfClass:[NSArray class]]) {
//        
//        NSArray *acronymMeaningsArray = [self acronymMeaningsFromArray:objectToMap];
//        return acronymMeaningsArray;
//        
//    } else {
//        NSLog(@"Invalid data returned. Aborting.");
//        return nil;
//    }
//}
//
//- (NSArray *)acronymMeaningsFromArray:(NSArray *)acronymMeaningRawArray {
//    NSMutableArray *acronymMeanings = [NSMutableArray array];
//    for (NSDictionary *acronymMeaningDictionary in acronymMeaningRawArray) {
//        AcronymMeaning *acronymMeaning = [self acronymMeaningFromDictionary:acronymMeaningDictionary];
//        [acronymMeanings addObject:acronymMeaning];
//    }
//    return [NSArray arrayWithArray:acronymMeanings];
//}
//
//
//#pragma mark - Mappings
//
//
//- (FEMObjectMapping *)acronymMappingForMeaningsSearch {
//    return [FEMObjectMapping mappingForClass:[Acronym class] configuration:^(FEMObjectMapping *mapping) {
//        [mapping addAttributesFromDictionary:@{@"acronymString" : @"sf",
//                                               }];
//        
//    }];
//};
//
//- (FEMObjectMapping *)acronymMeaningMapping {
//    return [FEMObjectMapping mappingForClass:[AcronymMeaning class] configuration:^(FEMObjectMapping *mapping) {
//        [mapping addAttributesFromDictionary:@{@"fullName" : @"lf",
//                                               @"numberOfOccuranceString" : @"freq",
//                                               @"yearSinceString" : @"since"
//                                               }];
//        
//    }];
//};
//


//[{"sf": "FBI",
// "lfs": [{"lf": "Federal Bureau of Investigation",
//        "freq": 18,
//        "since": 1986,
//        "vars": [{"lf": "Federal Bureau of Investigation", "freq": 17, "since": 1986},
//                 {"lf": "Federal Bureau of Investigations", "freq": 1, "since": 1995}]},
//         
//         {"lf": "Frontal Behavioral Inventory",
//        "freq": 9,
//        "since": 1997,
//        "vars": [{"lf": "Frontal Behavioral Inventory", "freq": 4, "since": 1997},
//                 {"lf": "Frontal Behavioural Inventory", "freq": 3, "since": 2005},
//                 {"lf": "Frontal Behavior Inventory", "freq": 1, "since": 2005},
//                 {"lf": "frontal behavioural inventory", "freq": 1, "since": 2007}]},
//    
//         {"lf": "fresh blood imaging",
//        "freq": 7,
//        "since": 2000,
//        "vars": [{"lf": "fresh blood imaging", "freq": 6, "since": 2000},
//                 {"lf": "fresh-blood imaging", "freq": 1, "since": 2001}]},
//    
//         {"lf": "foreign body infections",
//        "freq": 4,
//        "since": 1998,
//        "vars": [{"lf": "foreign body infections", "freq": 2, "since": 2004},
//                 {"lf": "Foreign-body infection", "freq": 1, "since": 2004},
//                 {"lf": "Foreign-Body Infection", "freq": 1, "since": 1998}]}]}]


@end
