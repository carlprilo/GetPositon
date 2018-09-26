//
//  ViewController.h
//  GetPosition
//
//  Created by Pan on 2018/9/26.
//  Copyright © 2018 陈攀. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>

@interface ViewController : UIViewController<CLLocationManagerDelegate,UITableViewDataSource,UITableViewDelegate>
@property UIButton *button;
@property bool isStart;
@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic) NSMutableArray *positions;
@end
