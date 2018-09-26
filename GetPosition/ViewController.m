//
//  ViewController.m
//  GetPosition
//
//  Created by Pan on 2018/9/26.
//  Copyright © 2018 陈攀. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property CLLocationManager *locationManager;
@property NSString* lastPositionS;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    _isStart = false;
    [self initView];
    self.locationManager = [[CLLocationManager alloc] init];
    self.locationManager.delegate = self;
    
    [self.locationManager requestAlwaysAuthorization];
    [self.locationManager requestWhenInUseAuthorization];
}

- (void) btnEvent{
    NSLog(@"click here!");
    if(!_isStart){
        [self.locationManager startUpdatingLocation];
        _isStart = TRUE;
        _button.backgroundColor = [UIColor redColor];
        [_button setTitle:@"Stop" forState:UIControlStateNormal];
        NSLog(@"start");
    }else{
        [self.locationManager stopUpdatingLocation];
        _isStart = FALSE;
        _button.backgroundColor = [UIColor greenColor];
        [_button setTitle:@"Start" forState:UIControlStateNormal];
        NSLog(@"stop");
        [_positions insertObject:_lastPositionS atIndex:[_positions count]];
    }
    //[_tableView insertRowsAtIndexPaths:[_positions objectAtIndex:0] withRowAnimation:UITableViewRowAnimationTop];
    [_tableView reloadData];
}

- (void) initView{
    NSLog(@"init view");
    _button = [UIButton buttonWithType:UIButtonTypeCustom];
    CGRect bounds = [UIScreen mainScreen].bounds;
    
    _button.frame = CGRectMake(bounds.size.width/2-100,bounds.size.height/2+150,200, 100);
    _button.backgroundColor = [UIColor greenColor];
    [_button setTitle:@"Start" forState:UIControlStateNormal];
    [_button addTarget:self action:@selector(btnEvent) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_button];

    _positions = [[NSMutableArray alloc] initWithObjects:@"the first one",nil];
    
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0,0,bounds.size.width,bounds.size.height-200) style:UITableViewStylePlain];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    [self.view addSubview:_tableView];
    _tableView.rowHeight = 50;
    _tableView.backgroundColor = [UIColor whiteColor];
    

}


- (void) didReceiveMemoryWarning{
    [super didReceiveMemoryWarning];
}

-(void)tableView:(UITableView* )tableView willDisplayCell:(UITableViewCell* )cell forRowAtIndexPath:(NSIndexPath* )indexPath{
    NSLog(@"will display cell");
}

-(void) locationManager:(CLLocationManager *)manager didUpdateLocations:(nonnull NSArray<CLLocation *> *)locations{
    CLLocation *location = [locations lastObject];
    NSLog(@"经度：%f,纬度：%f,海拔：%f,航向：%f,行走速度：%f", location.coordinate.longitude, location.coordinate.latitude,location.altitude,location.course,location.speed);
    _lastPositionS =  [NSString stringWithFormat:@"%lu 经度 %f,纬度 %f", [_positions count],location.coordinate.longitude , location.coordinate.latitude];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
     return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [self.positions count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    // 1.定义一个cell的复用标识
    static NSString *ID = @"cell";
    
    // 2.根据复用标识，从缓存池中取出带有同样的复用标识的cell
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    
    // 3.如果缓存池中没有带有这种复用标识的cell，就创建一个带有这种复用标识的cell
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
    }
    
    // 4.设置cell的一些属性
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.textLabel.text = [_positions objectAtIndex:indexPath.row];
    NSLog(@"%ld",(long)indexPath.row);
    cell.textLabel.textColor = [UIColor grayColor];
//cell.accessoryType=UITableViewCellAccessoryCheckmark;
    return cell;
}

- (NSString *)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section{
    // 在这个方法中设置第section组的尾部标题
    return @"head";
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    // 在这个方法中设置第section组的头部标题
    return @"foot";
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    // 当选中了某一行的时候就会调用这个方法，可以在这里进行一些操作
}

-(void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated]; //所有的数据重新被加载，然后在放到复用队列中
    
    [self.tableView reloadData];
    
}

@end
