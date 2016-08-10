//
//  ViewController.m
//  weatherOnTV
//
//  Created by Alessandro Giacomella on 18/05/16.
//  Copyright © 2016 Alessandro Giacomella. All rights reserved.
//

#import "ViewController.h"
@import CoreLocation;

@interface ViewController()

@property (nonatomic) NSTimer *timer;
@property (weak, nonatomic) IBOutlet UILabel *dayLabel;
@property (weak, nonatomic) IBOutlet UILabel *monthLabel;
@property (weak, nonatomic) IBOutlet UILabel *hourMinuteLabel;
@property (weak, nonatomic) IBOutlet UILabel *dayOfWeekLabel;
@property (weak, nonatomic) IBOutlet UILabel *ampmLabel;
@property (weak, nonatomic) IBOutlet UILabel *locationLabel;
@property (weak, nonatomic) IBOutlet UILabel *temperatureLabel;
@property (weak, nonatomic) IBOutlet UILabel *temperatureScaleLabel;
@property (weak, nonatomic) IBOutlet UILabel *weatherIcon;
@property (weak, nonatomic) IBOutlet UIImageView *backgroundImageView;

@end

@implementation ViewController

-(void)updateDate
{
    NSDate *date = [NSDate date];
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents* components = [calendar components:NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay|NSCalendarUnitHour|NSCalendarUnitMinute|NSCalendarUnitSecond|NSCalendarUnitWeekday fromDate:date];
    if (components.hour >= 19 || components.hour <= 6) {
        NSLog(@"It's night shift");
    } else {
        NSLog(@"It's day shift");
    }
    
    [_dayLabel setText:[NSString stringWithFormat:@"%02ld",(long) components.day]];
    NSString *monthName = [[[[NSDateFormatter alloc] init] monthSymbols] objectAtIndex:(components.month-1)];
    NSString *dowName = [[[[NSDateFormatter alloc]init]weekdaySymbols] objectAtIndex:(components.weekday-1)];
    
    [_monthLabel setText:monthName];
    [_dayOfWeekLabel setText:dowName];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self updateDate];
    
    self.timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(updateDate) userInfo:nil repeats:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
