//
//  WKInterfaceImage+URL.m
//
//  WKInterfaceImage+AFNetworking
//
//  Created by Joseph Granieri on 12/03/2015.
//  Copyright (c) 2015 Arcade Wizz Kid. All rights reserved.
//

#import "WKInterfaceImage+AFNetworking.h"
#import <AFNetworking.h>

@implementation WKInterfaceImage (AFNetworking)

// Sets the WKInterfaceImage from a URL and assigned an image Name to store in the WatchKit device cache.
// @param imageName Image name to store in the WatchKit device cache (default imageName is the URL path)
// @param completion Completion handling to handler called after URL response with an optional error (nil for no error)
- (void)setImageWithURL:(NSURL *)url withImageName:(NSString *)imageName
             completion:(void (^)(NSError *))completion {
    
    // Setup default image name - if not provide use the URL path
    imageName = imageName ? imageName : [url absoluteString];
    
    id cachedImage = [WKInterfaceDevice currentDevice].cachedImages[imageName];
    if (cachedImage) {
        // Set the image from the device cache
        [self setImageNamed:imageName];
        completion(nil);
        return;
    }
    
    NSURLRequest *urlRequest = [[NSURLRequest alloc] initWithURL:url];
    AFHTTPRequestOperation *requestOperation = [[AFHTTPRequestOperation alloc] initWithRequest:urlRequest];
    requestOperation.responseSerializer = [AFImageResponseSerializer serializer];
    [requestOperation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        [[WKInterfaceDevice currentDevice] addCachedImage:responseObject name:imageName];
        [self setImageNamed:imageName];
        completion(nil);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        completion(error);
    }];
    [requestOperation start];
}

@end
