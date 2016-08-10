//
//  WeatherLocation.m
//  weatherOnTV
//
//  Created by Alessandro Giacomella on 24/05/16.
//  Copyright © 2016 Alessandro Giacomella. All rights reserved.
//
#import "WeatherLocation.h"

@implementation WeatherLocation

#pragma mark NSCoding

- (void) encodeWithCoder:(NSCoder *)encoder
{
    [encoder encodeObject:_name forKey:@"name"];
    [encoder encodeDouble:_coordinates.latitude forKey:@"coordinates_lat"];
    [encoder encodeDouble:_coordinates.longitude forKey:@"coordinates_lon"];
    [encoder encodeObject:_cityId forKey:@"city_id"];
}

- (id) initWithCoder:(NSCoder *)decoder
{
    
    NSString *name = [decoder decodeObjectForKey:@"name"];
    CLLocationDegrees latitude = [decoder decodeDoubleForKey:@"coordinates_lat"];
    CLLocationDegrees longitude = [decoder decodeDoubleForKey:@"coordinates_lon"];
    NSString *cityId = [decoder decodeObjectForKey:@"city_id"];
    
    if (self = [super init]) {
        self.name = name;
        self.coordinates = CLLocationCoordinate2DMake(latitude, longitude);
        self.cityId = cityId;
    }
    return self;
}

@end
