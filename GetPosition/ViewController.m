//
//  ViewController.m
//  GetPosition
//
//  Created by Pan on 2018/9/26.
//  Copyright © 2018 陈攀. All rights reserved.
//

#import "ViewController.h"

@interface ViewController (){
    CLLocationManager *_locationManager;
}

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    _locationManager = [[CLLocationManager alloc] init];
    _locationManager.delegate = self;
    
    [_locationManager requestAlwaysAuthorization];
    [_locationManager startUpdatingLocation];
}

- (void) didReceiveMemoryWarning{
    [super didReceiveMemoryWarning];
}

-(void) locationManager:(CLLocationManager *)manager didUpdateLocations:(nonnull NSArray<CLLocation *> *)locations{
    CLLocation *location = [locations lastObject];
    NSLog(@"经度：%f,纬度：%f,海拔：%f,航向：%f,行走速度：%f", location.coordinate.longitude, location.coordinate.latitude,location.altitude,location.course,location.speed);
}


@end
