//
//  ViewController.m
//  SampleWeatherApp
//
//  Created by Shoeb Amin on 6/29/16.
//  Copyright © 2016 SiliconOrchard. All rights reserved.
//

#import "ViewController.h"
#import "LocationManager.h"
#import <YWeatherAPI/YWeatherAPI.h>


@interface ViewController ()

@property (strong, nonatomic) IBOutlet UILabel *currentLocationLabel;
@property (strong, nonatomic) IBOutlet UIImageView *weatherIconImageView;
@property (strong, nonatomic) IBOutlet UILabel *temparatureLabel;
@property (strong, nonatomic) IBOutlet UILabel *lowTemparatureLabel;
@property (strong, nonatomic) IBOutlet UIImageView *windDirectionImageView;
@property (strong, nonatomic) IBOutlet UILabel *windSpeedLabel;

@property (strong, nonatomic) IBOutlet UILabel *humidityLabel;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [[LocationManager sharedManager] updateLocation];
    
    [[LocationManager sharedManager] GetLocationWithLocation:^(NSString *latitude, NSString *longitude) {
        NSLog(@"Latitude and Longitude: %@,%@",latitude,longitude);
    } cityName:^(NSString *cityName) {
        NSLog(@"CityName: %@",cityName);
        self.currentLocationLabel.text = cityName;
        [self settingUpUIWithCityName:[[LocationManager sharedManager] getCityName]];
    } onFailure:^(NSError *error) {
        
    }];
}


-(void)settingUpUIWithCityName:(NSString *) cityName {

    [[YWeatherAPI sharedManager] todaysForecastForLocation:cityName success:^(NSDictionary *result) {
        [self.weatherIconImageView setImage:[UIImage imageNamed:[result objectForKey:kYWAShortDescription]]];
        self.temparatureLabel.text = [NSString stringWithFormat:@"%@°F",[result objectForKey:kYWAHighTemperatureForDay]];
        self.lowTemparatureLabel.text = [NSString stringWithFormat:@"%@°F",[result objectForKey:kYWALowTemperatureForDay]];
    } failure:^(id response, NSError *error) {
        
    }];
    
    [[YWeatherAPI sharedManager] humidityForLocation:cityName success:^(NSDictionary *result) {
        self.humidityLabel.text = [NSString stringWithFormat:@"%@%%",[result objectForKey:kYWAHumidity]];
    } failure:^(id response, NSError *error) {
        
    }];
    
    [[YWeatherAPI sharedManager] windDirectionForLocation:cityName success:^(NSDictionary *result) {
        self.windDirectionImageView.transform = CGAffineTransformMakeRotation(-[[result objectForKey:kYWAWindDirectionInDegrees] floatValue]);
    } failure:^(id response, NSError *error) {
        
    }];
    
    [[YWeatherAPI sharedManager] windSpeedForLocation:cityName success:^(NSDictionary *result) {
        self.windSpeedLabel.text = [NSString stringWithFormat:@"%@ MPH",[result objectForKey:kYWAWindSpeedInMPH]];
    } failure:^(id response, NSError *error) {
        
    }];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
