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
        [self settingUpUIWithWeather];
    } onFailure:^(NSError *error) {
        
    }];
}


-(void)settingUpUIWithWeather{

    [[YWeatherAPI sharedManager] todaysForecastForLocation:[[LocationManager sharedManager] getCityName]success:^(NSDictionary *result) {
        [self.weatherIconImageView setImage:[UIImage imageNamed:[result objectForKey:kYWAShortDescription]]];
        self.temparatureLabel.text = [result objectForKey:kYWAHighTemperatureForDay];
    } failure:^(id response, NSError *error) {
        
    }];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
