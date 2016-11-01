//
//  TripHandler.h
//  GoEuroTest
//
//  Created by Faizan Ali on 11/1/16.
//  Copyright © 2016 GoEuro. All rights reserved.
//

#import <Foundation/Foundation.h>





@interface TripHandler : NSObject


-(void)getTripsList:(int)tripType  Success:(void (^)(id responseData))success;

@end
