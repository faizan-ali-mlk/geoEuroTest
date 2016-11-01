//
//  NetworkHandler.h
//  TestJob
//
//  Created by Wajid Zon 2/4/16.
//  Copyright © 2016 Underscore. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NetworkHandler : NSObject

+(void)GET:(NSString *)URLString parameters:(id)param success:(void (^)(id responseData))success
    failure:(void (^)(NSError * responseError))failure;

@end
