//
//  WKInterfaceImage+AFNetworking
//
//  Created by Joseph Granieri on 12/03/2015.
//  Copyright (c) 2015 Arcade Wizz Kid. All rights reserved.
//

#import <WatchKit/WatchKit.h>

@interface WKInterfaceImage (AFNetworking)

// Sets the WKInterfaceImage from a URL and assigned an image Name to store in the WatchKit device cache.
// @param imageName Image name to store in the WatchKit device cache (default imageName is the URL path)
// @param completion Completion handling to handler called after URL response with an optional error (nil for no error)
- (void)setImageWithURL:(NSURL *)url withImageName:(NSString *)imageName
             completion:(void (^)(NSError *))completion;

@end
