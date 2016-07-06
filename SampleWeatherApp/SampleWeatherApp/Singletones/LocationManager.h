//
//  LocationManger.h
//  SampleWeatherApp
//
//  Created by Shoeb Amin on 7/6/16.
//  Copyright © 2016 SiliconOrchard. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

@interface LocationManager : NSObject<CLLocationManagerDelegate> 

typedef void (^GetCityName)(NSString *cityName);
typedef void (^GeLocation)(NSString *latitude, NSString *longitude);
typedef void (^Failure)(NSError *error);

+(LocationManager*)sharedManager;

-(void)updateLocation;

-(void)GetLocationWithLocation:(GeLocation)locationCompletionHandler cityName:(GetCityName)cityNameCompletionHandler onFailure:(Failure)FailCompletetionHeandler;

@end
