//
//  GlobalConstants.h
//  AcronymList
//
//  Created by Kateryna Sytnyk on 12/16/15.
//  Copyright © 2015 KaterynaSytnyk. All rights reserved.
//

#ifndef GlobalConstants_h
#define GlobalConstants_h

typedef void(^DefaultCompletionBlock)(void);
typedef void(^DefaultSuccessHandler)(void);
typedef void(^DefaultErrorHandler)(NSString *localizedErrorMessage);

typedef void(^AcronymMeaningSearchSuccessHandler)(NSArray *acronymMeanings);

#endif /* GlobalConstants_h */
