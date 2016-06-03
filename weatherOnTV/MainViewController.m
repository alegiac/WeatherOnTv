//
//  MainViewController.m
//  weatherOnTV
//
//  Created by Alessandro Giacomella on 02/06/16.
//  Copyright © 2016 Alessandro Giacomella. All rights reserved.
//

@import CoreLocation;

#import "MainViewController.h"
#import "WeatherLocation.h"

@interface MainViewController () <CLLocationManagerDelegate>

@property(strong,nonatomic) CLLocationManager *locationManager;

@end

@implementation MainViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    _locationManager = [[CLLocationManager alloc]init];
    [_locationManager setDelegate:self];
    [_locationManager setDesiredAccuracy:kCLLocationAccuracyHundredMeters];
    if ([_locationManager respondsToSelector:@selector(requestWhenInUseAuthorization)]) {
        [self.locationManager requestWhenInUseAuthorization];
    }
    
    [_locationManager requestLocation];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - CoreLocation

-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations
{
    CLLocation *current = (CLLocation *)[locations lastObject];
    WeatherLocation *defLocation = [[WeatherLocation alloc] init];
    [defLocation setCoordinate:[current coordinate]];
    
    [[NSUserDefaults standardUserDefaults] setObject:defLocation forKey:@"default_location"];
    [[NSUserDefaults standardUserDefaults] synchronize];

}

-(void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error
{
    
}

-(void)locationManager:(CLLocationManager *)manager didChangeAuthorizationStatus:(CLAuthorizationStatus)status
{
    switch (status) {
        case kCLAuthorizationStatusDenied:
            break;
        case kCLAuthorizationStatusRestricted:
            break;
        case kCLAuthorizationStatusNotDetermined:
            break;
        case kCLAuthorizationStatusAuthorizedAlways:
            break;
        case kCLAuthorizationStatusAuthorizedWhenInUse:
            break;
        default:
            break;
    }
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
