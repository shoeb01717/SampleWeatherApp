//
//  LocationManger.m
//  SampleWeatherApp
//
//  Created by Shoeb Amin on 7/6/16.
//  Copyright © 2016 SiliconOrchard. All rights reserved.
//

#import "LocationManager.h"
#import <YWeatherAPI.h>


@implementation LocationManager{
    CLLocationManager *_locationManager;
    
    NSString *_lattitude;
    NSString *_longitude;
    NSString *_cityName;
    
    __block GetCityName _completionCityName;
    __block GeLocation _completionLocation;
    __block Failure _completionFailure;
}


+(LocationManager*)sharedManager{
    static LocationManager *mySharedHandler = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        mySharedHandler = [[LocationManager alloc] init];
        // Do any other initialisation stuff here
        [mySharedHandler initializeLocationCall];
        
    });
    
    return mySharedHandler;
}

-(void) initializeLocationCall {
    _locationManager = [[CLLocationManager alloc] init];
    _locationManager.delegate = self;
    _locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    
    _lattitude = [[NSString alloc] init];
    _longitude = [[NSString alloc] init];
    _cityName = [[NSString alloc] init];
    _completionCityName = nil;
    _completionLocation = nil;
    _completionFailure = nil;
}

-(NSString*)getCityName{

    return _cityName;
}
-(NSString*)getLatitude{

    return _lattitude;
}
-(NSString*)getLongitude{

    return _longitude;
}

-(void)updateLocation {
    if (_locationManager!=nil) {
        if ([_locationManager respondsToSelector:@selector(requestWhenInUseAuthorization)]) {
            [_locationManager requestWhenInUseAuthorization];
        }
        
        [_locationManager startUpdatingLocation];
    }
}

-(void)GetLocationWithLocation:(GeLocation)locationCompletionHandler cityName:(GetCityName)cityNameCompletionHandler onFailure:(Failure)FailCompletetionHeandler {

    _completionFailure = [FailCompletetionHeandler copy];
    _completionCityName = [cityNameCompletionHandler copy];
    _completionLocation = [locationCompletionHandler copy];
}

#pragma mark - CLLocationManagerDelegate

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error
{
    NSLog(@"didFailWithError: %@", error);
    if (_completionFailure) {
        _completionFailure(error);
        _completionFailure = nil;
    }

}

- (void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation
{
    NSLog(@"didUpdateToLocation: %@", newLocation);
    CLLocation *currentLocation = newLocation;
    
    if (currentLocation != nil) {
        _lattitude = [NSString stringWithFormat:@"%.8f", currentLocation.coordinate.longitude];
        _longitude = [NSString stringWithFormat:@"%.8f", currentLocation.coordinate.latitude];
        
        if (_completionLocation) {
            _completionLocation(_lattitude,_longitude);
            _completionLocation = nil;
        }
        
        [[YWeatherAPI sharedManager] locationStringForCoordinate:currentLocation success:^(NSString *locationString) {
            NSLog(@"%@",locationString);
            if (_completionCityName) {
                _cityName = [NSString stringWithFormat:@"%@",locationString];
                _completionCityName(_cityName);
                _completionCityName = nil;
            }
        } failure:^(id response, NSError *error) {
            
        }];
    }
}


@end
