//
//  LibraryAPI.m
//  FreelancerExam
//
//  Created by Sil Piplay on 7/10/15.
//  Copyright (c) 2015 Panfilo. All rights reserved.
//

#import "LibraryAPI.h"
#import "AFNetworking.h"
#import "Movie.h"

#define URL_BASE @"http://www.whatsbeef.net/"

@implementation LibraryAPI

static LibraryAPI *_instance;
static AFHTTPRequestOperationManager *_httpClient;
static dispatch_once_t oncePredicate;

+ (LibraryAPI *)sharedInstance {
    dispatch_once(&oncePredicate, ^{
        _instance = [[LibraryAPI alloc] init];
    });
    return _instance;
}

+ (AFHTTPRequestOperationManager *)httpClient {
    if (!_httpClient) {
        _httpClient = [[AFHTTPRequestOperationManager alloc] initWithBaseURL:[NSURL URLWithString:URL_BASE]];
    }
    
    return _httpClient;
}

- (void)requestMovieListAtPage: (NSUInteger)page
                       success: (void (^)(NSMutableArray *movieList))success
                       failure: (void (^)(NSError *error))failure {
    
    NSString *apiUrlString = [NSString stringWithFormat:@"/wabz/guide.php?start=%lu", (unsigned long)page];
    NSLog(@"Page: %lu", (unsigned long)page);
    [[LibraryAPI httpClient] GET:apiUrlString parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSDictionary *responseDict = (NSDictionary *) responseObject;
        NSObject *resultObject = responseDict[@"results"];
        NSMutableArray *results = [[NSMutableArray alloc] init];
        if (![resultObject isKindOfClass:[NSNull class]]) {
            for (NSDictionary *resultItem in responseDict[@"results"]) {
                Movie *movie = [Movie new];
                movie.name = resultItem[@"name"];
                movie.startTime = resultItem[@"start_time"];
                movie.endTime = resultItem[@"end_time"];
                movie.channel = resultItem[@"channel"];
                movie.rating = resultItem[@"rating"];
                
                [results addObject:movie];
            }
        }
        success (results);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        failure (error);
    }];
}


@end
