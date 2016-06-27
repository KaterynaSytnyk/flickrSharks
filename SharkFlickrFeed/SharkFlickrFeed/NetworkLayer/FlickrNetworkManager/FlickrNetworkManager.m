//
//  FlickrNetworkManager.m
//  SharkFlickrFeed
//
//  Created by Kateryna Sytnyk on 6/24/16.
//  Copyright © 2016 KaterynaSytnyk. All rights reserved.
//

#import "FlickrNetworkManager.h"
#import "ParsingManager.h"


@interface FlickrNetworkManager ()

@property (nonatomic, strong) NSURLSession *session;
@property (copy, nonatomic) NSString *localizedSearchErrorMessage;
@property (copy, nonatomic) NSString *localizedSearchNoResultsMessage;

@end


@implementation FlickrNetworkManager

#pragma mark - Inits

+ (instancetype)sharedManager {
    static FlickrNetworkManager *sharedManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedManager = [FlickrNetworkManager new];
       // [sharedManager setupSession];
        [sharedManager localizeStrings];
        
    });
    return sharedManager;
}

#pragma mark - Setup

- (void)localizeStrings {
    self.localizedSearchErrorMessage = NSLocalizedString(@"Photo search failed. Please try again.", @"Error message for the case when photo search fails.");
    self.localizedSearchNoResultsMessage = NSLocalizedString(@"Photo search returned no results. Please try again.", @"Error message for the case when photo search returned no results.");
}

- (void)setupSession {
    // create session, setup self as delegate for downloads
    NSURLSessionConfiguration *config = [NSURLSessionConfiguration defaultSessionConfiguration];
    config.allowsCellularAccess = NO;
    //KS: TODO - finish NSURLSession setup instead of AFNetworking
}

#pragma mark - Network Calls

- (void)getSharkPhotosWithSuccessHandler:(SharkPhotosFeedSuccessHandler)successHandler
                            errorHandler:(DefaultErrorHandler)errorHandler {
    
    NSDictionary *params = [[ParsingManager sharedManager] dictionaryForSharkFeedSearchWithPage:1];
    
    __weak typeof(self) weakSelf = self;
    
    [self.sessionManager GET:@"" parameters:params success:^(NSURLSessionDataTask *task, id responseObject) {
        
        if (![responseObject isKindOfClass:[NSDictionary class]]) {
            if (errorHandler) {
                errorHandler(weakSelf.localizedSearchErrorMessage);
            }
        }
        
        NSArray *sharkPhotos = [[ParsingManager sharedManager] sharkPhotosArrayFromDictionary:responseObject];
        
        if (!sharkPhotos) {
            if (errorHandler) {
                errorHandler(weakSelf.localizedSearchNoResultsMessage);
            }
            return;
        }
        
        if (successHandler) {
            successHandler(sharkPhotos);
        }
        
    } failure:^(NSURLSessionDataTask * _Nonnull task, NSError * _Nonnull error) {
        NSLog(@"Failed network call for shark photos search: %@", error.localizedDescription);
        
        if (errorHandler) {
            errorHandler(weakSelf.localizedSearchErrorMessage);
        }
    }];
    
}


//KS: Photo Feed JSON

//https://api.flickr.com/services/rest/?method=flickr.photos.search&api_key=949e987787 55d1982f537d56236bbb42&text=shark&format=json&nojsoncallback=1&page=1&extras =url_t,url_c,url_l,url_o

//{"photos":
//    {"page":1,"pages":2894,"perpage":100,"total":"289331","photo":[
//    {"id":"27291496694",
//        "owner":"97303805@N00",
//        "secret":"878f379282",
//        "server":"7414",
//        "farm":8,
//        "title":"Birds of Belmar - Least Tern - 15",
//        "ispublic":1,
//        "isfriend":0,
//        "isfamily":0,
//        "url_t":"https:\/\/farm8.staticflickr.com\/7414\/27291496694_878f379282_t.jpg",
//        "height_t":"67",
//        "width_t":"100",
//        "url_c":"https:\/\/farm8.staticflickr.com\/7414\/27291496694_878f379282_c.jpg",
//        "height_c":534,
//        "width_c":"800",
//        "url_l":"https:\/\/farm8.staticflickr.com\/7414\/27291496694_878f379282_b.jpg",
//        "height_l":"683",
//        "width_l":"1024"},
//        
//        {"id":"27291496574","owner":"97303805@N00","secret":"d14c0c538c","server":"7093","farm":8,"title":"Birds of Belmar - Least Tern - 16","ispublic":1,"isfriend":0,"isfamily":0,"url_t":"https:\/\/farm8.staticflickr.com\/7093\/27291496574_d14c0c538c_t.jpg","height_t":"67","width_t":"100","url_c":"https:\/\/farm8.staticflickr.com\/7093\/27291496574_d14c0c538c_c.jpg","height_c":534,"width_c":"800","url_l":"https:\/\/farm8.staticflickr.com\/7093\/27291496574_d14c0c538c_b.jpg","height_l":"683","width_l":"1024"},{"id":"27625141650","owner":"142104174@N03","secret":"dc32b60f4a","server":"7404","farm":8,"title":"\u0412\u042b\u0427\u0418\u0421\u041b\u0415\u041d\u0418\u0415 \u0410\u0423\u0422\u041e\u0412","ispublic":1,"isfriend":0,"isfamily":0,"url_t":"https:\/\/farm8.staticflickr.com\/7404\/27625141650_dc32b60f4a_t.jpg","height_t":"61","width_t":"100","url_o":"https:\/\/farm8.staticflickr.com\/7404\/27625141650_d477e2591e_o.png","height_o":"336","width_o":"552"},


//KS: Individual Photo JSON:
//{"photo":{"id":"22337474460","secret":"a84043078e","server":"699","farm":1,"dateuploaded":"1445974092","isfavorite":0,"license":"0","safety_level":"0","rotation":0,"owner":{"nsid":"18178648@N05","username":"Geoffrey Gilson","realname":"","location":"Barcelona, Spain","iconserver":"7432","iconfarm":8,"path_alias":"geoffreygilson"},"title":{"_content":"Carcharodon carcharias"},"description":{"_content":"The great white shark (Carcharodon carcharias), also known as the great white, white pointer, white shark, or white death, is a species of large lamniform shark which can be found in the coastal surface waters of all the major oceans."},"visibility":{"ispublic":1,"isfriend":0,"isfamily":0},"dates":{"posted":"1445974092","taken":"2015-10-27 20:27:02","takengranularity":0,"takenunknown":"1","lastupdate":"1447953981"},"views":"585","editability":{"cancomment":0,"canaddmeta":0},"publiceditability":{"cancomment":1,"canaddmeta":1},"usage":{"candownload":0,"canblog":0,"canprint":0,"canshare":1},"comments":{"_content":"1"},"notes":{"note":[]},"people":{"haspeople":0},"tags":{"tag":[{"id":"18173308-22337474460-2174","author":"18178648@N05","authorname":"Geoffrey Gilson","raw":"shark","_content":"shark","machine_tag":0},{"id":"18173308-22337474460-6651","author":"18178648@N05","authorname":"Geoffrey Gilson","raw":"great","_content":"great","machine_tag":0},{"id":"18173308-22337474460-395","author":"18178648@N05","authorname":"Geoffrey Gilson","raw":"white","_content":"white","machine_tag":0},{"id":"18173308-22337474460-21387","author":"18178648@N05","authorname":"Geoffrey Gilson","raw":"requin","_content":"requin","machine_tag":0},{"id":"18173308-22337474460-46816","author":"18178648@N05","authorname":"Geoffrey Gilson","raw":"blanc","_content":"blanc","machine_tag":0},{"id":"18173308-22337474460-409","author":"18178648@N05","authorname":"Geoffrey Gilson","raw":"fish","_content":"fish","machine_tag":0},{"id":"18173308-22337474460-7187","author":"18178648@N05","authorname":"Geoffrey Gilson","raw":"attack","_content":"attack","machine_tag":0},{"id":"18173308-22337474460-5833","author":"18178648@N05","authorname":"Geoffrey Gilson","raw":"wildlife","_content":"wildlife","machine_tag":0},{"id":"18173308-22337474460-5992","author":"18178648@N05","authorname":"Geoffrey Gilson","raw":"south","_content":"south","machine_tag":0},{"id":"18173308-22337474460-55","author":"18178648@N05","authorname":"Geoffrey Gilson","raw":"africa","_content":"africa","machine_tag":0},{"id":"18173308-22337474460-331613","author":"18178648@N05","authorname":"Geoffrey Gilson","raw":"gansbaai","_content":"gansbaai","machine_tag":0},{"id":"18173308-22337474460-14664","author":"18178648@N05","authorname":"Geoffrey Gilson","raw":"experience","_content":"experience","machine_tag":0}]},"urls":{"url":[{"type":"photopage","_content":"https:\/\/www.flickr.com\/photos\/geoffreygilson\/22337474460\/"}]},"media":"photo"},"stat":"ok"}

@end
