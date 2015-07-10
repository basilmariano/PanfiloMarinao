//
//  LibraryAPI.h
//  FreelancerExam
//
//  Created by Sil Piplay on 7/10/15.
//  Copyright (c) 2015 Panfilo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LibraryAPI : NSObject

+ (LibraryAPI *)sharedInstance;
- (void)requestMovieListAtPage: (NSUInteger)page
                       success: (void (^)(NSMutableArray *movieList))success
                       failure: (void (^)(NSError *error))failure;
@end
