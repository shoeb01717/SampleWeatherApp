//
//  ViewController.m
//  SampleWeatherApp
//
//  Created by Shoeb Amin on 6/29/16.
//  Copyright © 2016 SiliconOrchard. All rights reserved.
//

#import "ViewController.h"
#import "LocationManager.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [[LocationManager sharedManager] updateLocation];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
