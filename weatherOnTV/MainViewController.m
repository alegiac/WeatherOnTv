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

@property (strong,nonatomic) CLLocationManager *locationManager;
@property (strong, nonatomic) IBOutlet UIView *locationSelectionContainer;
@property (strong, nonatomic) IBOutlet UIView *titleContainer;
@end

@implementation MainViewController

- (IBAction)didTapOnGPS:(id)sender
{
    if (!self.locationManager) {
        self.locationManager = [CLLocationManager new];
        self.locationManager.delegate = self;
        self.locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters;
        [self.locationManager requestWhenInUseAuthorization];
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Does the user own a location?
    if ([[NSUserDefaults standardUserDefaults] objectForKey:@"default_location"]) {
        [self performSegueWithIdentifier:@"To_Weather_Page" sender:self];
    }
}


- (void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    
    [UIView animateWithDuration:1.0f animations:^{
    
        CGRect titleRect = self.titleContainer.frame;
        titleRect.origin.x = 0;
        [self.titleContainer setFrame:titleRect];
        
        CGRect locationSelectionRect = self.locationSelectionContainer.frame;
        locationSelectionRect.origin.x-=locationSelectionRect.size.width;
        [self.locationSelectionContainer setFrame:locationSelectionRect];
    }];
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
    [self performSegueWithIdentifier:@"To_Weather_Page" sender:self];
}

-(void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error
{
    
}

-(void)locationManager:(CLLocationManager *)manager didChangeAuthorizationStatus:(CLAuthorizationStatus)status
{
    switch (status) {
        case kCLAuthorizationStatusDenied:
            NSLog(@"DENIED");
            break;
        case kCLAuthorizationStatusRestricted:
            NSLog(@"RESTRICTED");
            break;
        case kCLAuthorizationStatusNotDetermined:
            NSLog(@"NOT DETERMINED");
            break;
        case kCLAuthorizationStatusAuthorizedAlways:
        case kCLAuthorizationStatusAuthorizedWhenInUse:
            [self.locationManager requestLocation];
            break;
        default:
            break;
    }
}

@end
