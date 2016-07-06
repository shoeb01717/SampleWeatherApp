//
//  WeatherDataHandler.h
//  SampleWeatherApp
//
//  Created by Shoeb Amin on 7/7/16.
//  Copyright © 2016 SiliconOrchard. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <YWeatherAPI/YWeatherAPI.h>
#import "LocationManager.h"

@interface WeatherDataHandler : NSObject

+(WeatherDataHandler*)sharedManager;

-(NSDictionary*)getWeatherDetailsforCurrentLocation;

@end
