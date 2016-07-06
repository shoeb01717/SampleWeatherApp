//
//  WeatherDataHandler.m
//  SampleWeatherApp
//
//  Created by Shoeb Amin on 7/7/16.
//  Copyright © 2016 SiliconOrchard. All rights reserved.
//

#import "WeatherDataHandler.h"

@implementation WeatherDataHandler

+(WeatherDataHandler*)sharedManager{
    static WeatherDataHandler *mySharedHandler = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        mySharedHandler = [[WeatherDataHandler alloc] init];
        // Do any other initialisation stuff here
        
    });
    
    return mySharedHandler;
}
-(NSDictionary*)getWeatherDetailsforCurrentLocation{

    __block NSDictionary *weatherDetailDictionary;
    [[LocationManager sharedManager] GetLocationWithLocation:^(NSString *latitude, NSString *longitude) {
        
        
    } cityName:^(NSString *cityName) {
        [[YWeatherAPI sharedManager] todaysForecastForLocation:cityName success:^(NSDictionary *result) {
            weatherDetailDictionary = [[NSDictionary alloc] initWithDictionary:result];
        } failure:^(id response, NSError *error) {
            
        }];
    } onFailure:^(NSError *error) {
        
    }];
    
    return weatherDetailDictionary;
}

@end
