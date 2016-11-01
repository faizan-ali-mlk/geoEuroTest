//
//  CommonMethods.m
//  ValtransLimousine
//
//  Created by Faizan Ali on 12/21/15.
//  Copyright © 2015 Faizan Ali. All rights reserved.
//

#import "CommonMethods.h"

@implementation CommonMethods

+(void)showAlertViewWith:(UIViewController*)controller Title:(NSString*)title Description:(NSString*)desc YesTxt:(NSString*)yTxt NoTxt:(NSString*)nTxt andComplitionHandler:(void(^)(BOOL isSuccess))complitionHandler
{
    UIAlertController *alertController = [UIAlertController
                                          alertControllerWithTitle:title
                                          message:desc
                                          preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *cancelAction = [UIAlertAction
                                   actionWithTitle:yTxt
                                   style:UIAlertActionStyleCancel
                                   handler:^(UIAlertAction *action)
                                   {
                                       complitionHandler(YES);
                                   }];
    
    UIAlertAction *okAction = [UIAlertAction
                               actionWithTitle:nTxt
                               style:UIAlertActionStyleDefault
                               handler:^(UIAlertAction *action)
                               {
                                   
                                   complitionHandler(NO);
                                   
                               }];
    
    [alertController addAction:cancelAction];
    [alertController addAction:okAction];
    [controller presentViewController:alertController animated:YES completion:nil];

}
+(void)showAlertViewWith:(UIViewController *)controller Title:(NSString *)title Description:(NSString *)desc
{
    UIAlertController *alertController = [UIAlertController
                                          alertControllerWithTitle:title
                                          message:desc
                                          preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *okAction = [UIAlertAction
                               actionWithTitle:@"OK"
                               style:UIAlertActionStyleDefault
                               handler:^(UIAlertAction *action)
                               {
                                   
                                   
                                   
                               }];
    
    [alertController addAction:okAction];
    [controller presentViewController:alertController animated:YES completion:nil];
}
+(void)setUserDefaultValue:(NSString*)value forKey:(NSString*)key
{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    
    [userDefaults setObject:value forKey:key];
    
    [userDefaults synchronize];
}
+(id)getUserDefaultValueForKey:(NSString*)key
{
    return [[NSUserDefaults standardUserDefaults] objectForKey:key];
}
+(void)removeUserDefaultValueForKey:(NSString*)key
{
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:key];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

+(void)showOKAlertView:(NSString*)Title withDescription:(NSString*)desc
{
    UIAlertView *myAlertView = [[UIAlertView alloc] initWithTitle:Title
                                                          message:desc
                                                         delegate:nil
                                                cancelButtonTitle:@"OK"
                                                otherButtonTitles: nil];
    
    [myAlertView show];
}


@end
