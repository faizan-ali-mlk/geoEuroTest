//
//  Trip.m
//  GoEuroTest
//
//  Created by Faizan Ali on 11/1/16.
//  Copyright © 2016 GoEuro. All rights reserved.
//

#import "Trip.h"

@implementation Trip


-(void)loadJson:(id)data andType:(int)tripType
{
    NSString *url = [data objectForKey:@"provider_logo"];
    url = [url stringByReplacingOccurrencesOfString:@"{size}" withString:@"63"];
    
    NSDateFormatter *df = [[NSDateFormatter alloc] init] ;
    [df setDateFormat:@"HH:mm"];
    df.timeZone = [NSTimeZone timeZoneForSecondsFromGMT:0];
    
    
    self.tripId = [[data objectForKey:@"id"] intValue];
    self.imgUrl = [NSURL URLWithString:url];
    self.priceInEuro = [NSString stringWithFormat:@"%@",[data objectForKey:@"price_in_euros"]];
    self.departureTime = [df dateFromString:[data objectForKey:@"departure_time"]];
    self.arrivalTime = [df dateFromString:[data objectForKey:@"arrival_time"] ];
    self.totalDifference = [self.arrivalTime timeIntervalSinceDate:self.departureTime];
    self.numberOfStop = [[data objectForKey:@"number_of_stops"] intValue];
    self.tripType = tripType;
   
}
-(void)loadDBObject:(NSManagedObject*)data
{
    
    NSString *url = [data valueForKey:@"provider_logo"];
    url = [url stringByReplacingOccurrencesOfString:@"{size}" withString:@"63"];
    NSDateFormatter *df = [[NSDateFormatter alloc] init] ;
    [df setDateFormat:@"HH:mm"];
    df.timeZone = [NSTimeZone timeZoneForSecondsFromGMT:0];
    
    
    self.tripId = [[data valueForKey:@"id"] intValue];
    self.imgUrl = [NSURL URLWithString:url];
    self.priceInEuro = [data valueForKey:@"price_in_euros"];
    self.departureTime = [df dateFromString:[data valueForKey:@"departure_time"]];
    self.arrivalTime = [df dateFromString:[data valueForKey:@"arrival_time"]];
    self.totalDifference = [self.arrivalTime timeIntervalSinceDate:self.departureTime];
    self.numberOfStop = [[data valueForKey:@"number_of_stops"] intValue];
    self.tripType = [[data valueForKey:@"trip_type"] intValue];
    
}

-(NSString*)depatureTimeString
{
    NSDateFormatter *df = [[NSDateFormatter alloc] init] ;
    [df setDateFormat:@"HH:mm"];
    df.timeZone = [NSTimeZone timeZoneForSecondsFromGMT:0];
    
    return [df stringFromDate:self.departureTime];
}
-(NSString*)arrivalTimeString
{
    NSDateFormatter *df = [[NSDateFormatter alloc] init] ;
    [df setDateFormat:@"HH:mm"];
    df.timeZone = [NSTimeZone timeZoneForSecondsFromGMT:0];
    
    return [df stringFromDate:self.arrivalTime];
}
-(NSString*)hoursString
{
    int hours = self.totalDifference  / 3600;
    int minutes = (self.totalDifference  - (hours*3600)) / 60;
    return [NSString stringWithFormat:@"%d:%02d", hours, minutes];
    
}

@end
