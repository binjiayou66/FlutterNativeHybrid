//
//  ViewController.m
//  NativePart
//
//  Created by Andy on 2019/8/25.
//  Copyright © 2019 Andy. All rights reserved.
//

#import "ViewController.h"
#import <Flutter/Flutter.h>
#import "AppDelegate.h"

@interface ViewController ()

@property (nonatomic, strong) FlutterViewController *flutterViewController;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button addTarget:self
               action:@selector(handleButtonAction)
     forControlEvents:UIControlEventTouchUpInside];
    [button setTitle:@"Press me" forState:UIControlStateNormal];
    [button setBackgroundColor:[UIColor blueColor]];
    button.frame = CGRectMake(80.0, 210.0, 160.0, 40.0);
    [self.view addSubview:button];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];

}

- (void)handleButtonAction {
    [self pushFlutterViewController];
    
//    [self presentViewController:self.flutterViewController animated:false completion:nil];

    // 不可以用methodChannel
//    FlutterViewController *flVC = [[FlutterViewController alloc] init];
//    [flVC setInitialRoute:@"pageA"];
//    [self presentViewController:flVC animated:YES completion:nil];
}

- (void)pushFlutterViewController {
    __block FlutterViewController* flutterViewController = [[FlutterViewController alloc] initWithProject:nil nibName:nil bundle:nil];
    [flutterViewController setInitialRoute:@"pageA"];
    __weak __typeof(self) weakSelf = self;
    
    // 要与main.dart中一致
    NSString *channelName = @"com.andy.666";
    
    FlutterMethodChannel *messageChannel = [FlutterMethodChannel methodChannelWithName:channelName binaryMessenger:flutterViewController];
    [messageChannel setMethodCallHandler:^(FlutterMethodCall * _Nonnull call, FlutterResult  _Nonnull result) {
        // call.method 获取 flutter 给回到的方法名，要匹配到 channelName 对应的多个 发送方法名，一般需要判断区分
        // call.arguments 获取到 flutter 给到的参数，（比如跳转到另一个页面所需要参数）
        // result 是给flutter的回调， 该回调只能使用一次
        NSLog(@"method=%@ \narguments = %@", call.method, call.arguments);
        if ([call.method isEqualToString:@"platformNavBack"]) {
            [flutterViewController dismissViewControllerAnimated:YES completion:^{
                flutterViewController = nil;
            }];
            result(@"");
        }
    }];
    [self presentViewController:flutterViewController animated:YES completion:nil];
//    [self.navigationController pushViewController:flutterViewController animated:YES];
}

- (FlutterViewController *)flutterViewController
{
//    if (!_flutterViewController) {
        FlutterEngine *flutterEngine = [(AppDelegate *)[[UIApplication sharedApplication] delegate] flutterEngine];
        _flutterViewController = [[FlutterViewController alloc] initWithEngine:flutterEngine nibName:nil bundle:nil];
        [_flutterViewController setInitialRoute:@"pageA"];
//    }
    return _flutterViewController;
}

@end
