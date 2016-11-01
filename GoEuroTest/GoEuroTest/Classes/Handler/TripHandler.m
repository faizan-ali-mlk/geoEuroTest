//
//  TripHandler.m
//  GoEuroTest
//
//  Created by Faizan Ali on 11/1/16.
//  Copyright © 2016 GoEuro. All rights reserved.
//

#import "TripHandler.h"
#import "Constants.h"



@implementation TripHandler



-(void)getTripsList:(int)tripType  Success:(void (^)(id responseData))success
{
    NSString *url =  @"3zmcy" ;
    
    if(tripType == 1)
    {
        url = @"37yzm";
    }
    else if(tripType == 2)
    {
        url = @"w60i" ;
    }
    
    
    if([[CommonMethods getUserDefaultValueForKey:isNetworkAvailable] boolValue])
    {
        [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeClear];
        [SVProgressHUD show];
        [NetworkHandler GET:url parameters:nil success:^(id responseData)
         {
             [SVProgressHUD dismiss];
             
             [CoreDataHandler cacheTripWithObjArrayTrips:responseData tripType:tripType];
             
             NSArray *objResponse =  (NSArray*)responseData;
             
             NSMutableArray *objResponseArray = [[NSMutableArray alloc] init];
             for(int i=0;i<objResponse.count;i++)
             {
                 Trip *objTrip = [[Trip alloc] init];
                 [objTrip loadJson:objResponse[i] andType:tripType];
                 [objResponseArray addObject:objTrip];
             }
             
             success(objResponseArray);
             
         } failure:^(NSError *responseError)
         {
             [SVProgressHUD dismiss];
             success(nil);
         }];
    }
    else
    {
        NSArray *objArray = [CoreDataHandler getTripValueWithTripType:tripType];
        
        NSMutableArray *objResponseArray = [[NSMutableArray alloc] init];
        for(int i=0;i<objArray.count;i++)
        {
            Trip *objTrip = [[Trip alloc] init];
            [objTrip loadDBObject:objArray[i]];
            [objResponseArray addObject:objTrip];
        }
        success(objResponseArray);

    }
    
   
}
@end
