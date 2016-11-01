//
//  NetworkHandler.m
//  TestJob
//
//  Created by Wajid Zon 2/4/16.
//  Copyright © 2016 Underscore. All rights reserved.
//

#import "NetworkHandler.h"
#import "Constants.h"


@implementation NetworkHandler

+ (id)cleanJsonToObject:(id)data
{
    
    if ([data isKindOfClass:[NSArray class]]) {
        NSMutableArray *array = [data mutableCopy];
        for (int i = (int)array.count-1; i >= 0; i--) {
            id a = array[i];
            if (a == (id)[NSNull null]){
                [array removeObjectAtIndex:i];
            } else {
                array[i] = [self cleanJsonToObject:a];
            }
        }
        return array;
    }
    else if ([data isKindOfClass:[NSDictionary class]]) {
        NSMutableDictionary *dictionary = [data mutableCopy];
        for(NSString *key in [dictionary allKeys]) {
            id d = dictionary[key];
            if (d == (id)[NSNull null]){
                dictionary[key] = @"";
            } else {
                dictionary[key] = [self cleanJsonToObject:d];
            }
        }
        return dictionary;
    } else {
        return data;
    }
}
+(void)GET:(NSString *)URLString parameters:(id)param success:(void (^)(id responseData))success
    failure:(void (^)(NSError * responseError))failure
{
    
    
        NSURL *URL = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@",BASEURL,URLString]];
        AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
        manager.responseSerializer = [AFJSONResponseSerializer serializer];
        manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json",@"text/javascript", @"text/html", nil];

    
        [manager GET:URL.absoluteString parameters:param progress:nil success:^(NSURLSessionTask *task, id responseObject)
         {
            // NSLog(@"JSON: %@", responseObject);
    
             if([responseObject isKindOfClass:[NSArray class]] )
             {
                 success([NetworkHandler cleanJsonToObject:responseObject]);
             }
             else
             {
                 [CommonMethods showOKAlertView:@"Error" withDescription:@"No Trip Available"];
                 failure(nil);
             }
         } failure:^(NSURLSessionTask *operation, NSError *error)
         {
    
             [CommonMethods showOKAlertView:@"Error" withDescription:error.description];
    
             failure(error);
             NSLog(@"Error: %@", error);
         }];
    
}

@end
