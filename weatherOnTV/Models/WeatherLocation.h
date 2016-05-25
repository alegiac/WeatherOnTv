//
//  WeatherLocation.h
//  weatherOnTV
//
//  Created by Alessandro Giacomella on 24/05/16.
//  Copyright © 2016 Alessandro Giacomella. All rights reserved.
//

#import <Foundation/Foundation.h>
@import CoreLocation;

@interface WeatherLocation : NSObject

@property (nonatomic) NSString* name;
@property (nonatomic) CLLocationCoordinate2D coordinate;

@end
