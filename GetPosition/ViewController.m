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
    _isStart = false;
    [self initView];
    _locationManager = [[CLLocationManager alloc] init];
    _locationManager.delegate = self;
    
    [_locationManager requestAlwaysAuthorization];
    [_locationManager requestWhenInUseAuthorization];
    
}

- (void) btnEvent{
    NSLog(@"click here!");
    if(!_isStart){
        [_locationManager startUpdatingLocation];
        _isStart = TRUE;
        NSLog(@"start");
    }else{
        [_locationManager stopUpdatingLocation];
        _isStart = FALSE;
        NSLog(@"stop");
    }
    
}

- (void) initView{
    NSLog(@"init view");
    _button = [UIButton buttonWithType:UIButtonTypeCustom];
    CGRect bounds = [UIScreen mainScreen].bounds;
    
    _button.frame = CGRectMake(bounds.size.width-300,bounds.size.height-300,200, 100);
    _button.backgroundColor = [UIColor redColor];
    [_button setTitle:@"GetPosition" forState:UIControlStateNormal];
    [_button addTarget:self action:@selector(btnEvent) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_button];
}


- (void) didReceiveMemoryWarning{
    [super didReceiveMemoryWarning];
}

-(void) locationManager:(CLLocationManager *)manager didUpdateLocations:(nonnull NSArray<CLLocation *> *)locations{
    CLLocation *location = [locations lastObject];
    NSLog(@"经度：%f,纬度：%f,海拔：%f,航向：%f,行走速度：%f", location.coordinate.longitude, location.coordinate.latitude,location.altitude,location.course,location.speed);
}


@end
