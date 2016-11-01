//
//  Trip.h
//  GoEuroTest
//
//  Created by Faizan Ali on 11/1/16.
//  Copyright © 2016 GoEuro. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@interface Trip : NSObject


-(void)loadJson:(id)data andType:(int)tripType;
-(void)loadDBObject:(NSManagedObject*)data;


@property(nonatomic)int tripId;
@property(nonatomic,strong)NSURL *imgUrl;
@property(nonatomic,strong)NSString *priceInEuro;
@property(nonatomic,strong)NSDate *departureTime;
@property(nonatomic,strong)NSDate *arrivalTime;
@property(nonatomic)int numberOfStop;
@property(nonatomic)int tripType;
@property(nonatomic)int totalDifference;
@property(nonatomic,readonly)NSString *depatureTimeString;
@property(nonatomic,readonly)NSString *arrivalTimeString;
@property(nonatomic,readonly)NSString *hoursString;

@end
