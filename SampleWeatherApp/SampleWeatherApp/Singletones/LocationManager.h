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

+(LocationManager*)sharedManager;

-(void)updateLocation;

@end
