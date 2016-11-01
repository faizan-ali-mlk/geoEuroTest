//
//  CommonMethods.h
//  ValtransLimousine
//
//  Created by Faizan Ali on 12/21/15.
//  Copyright © 2015 Faizan Ali. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>



@interface CommonMethods : NSObject


+(void)showAlertViewWith:(UIViewController*)controller Title:(NSString*)title Description:(NSString*)desc YesTxt:(NSString*)yTxt NoTxt:(NSString*)nTxt andComplitionHandler:(void(^)(BOOL isSuccess))complitionHandler;
+(void)showAlertViewWith:(UIViewController *)controller Title:(NSString *)title Description:(NSString *)desc;
+(void)setUserDefaultValue:(NSString*)value forKey:(NSString*)key;
+(id)getUserDefaultValueForKey:(NSString*)key;
+(void)removeUserDefaultValueForKey:(NSString*)key;

+(void)showOKAlertView:(NSString*)Title withDescription:(NSString*)desc;

@end
