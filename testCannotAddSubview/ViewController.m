//
//  ViewController.m
//  testCannotAddSubview
//
//  Created by Hong Li on 2023/2/10.
//

#import "ViewController.h"
#import "SecondViewController.h"
#import "ThirdViewController.h"
#import "FourthViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.navigationItem.title = @"FirstVC";
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Demo" style:UIBarButtonItemStylePlain target:self action:@selector(testPush:)];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];

    // 尝试反复push-pop，无果，无法重现崩溃
//    SecondViewController *secondVC = [[SecondViewController alloc] init];
//    [self.navigationController pushViewController:secondVC animated:YES];
}

- (void)testPush:(UIBarButtonItem *)sender {
    SecondViewController *secondVC = [[SecondViewController alloc] init];
    ThirdViewController *thirdVC = [[ThirdViewController alloc] init];
    FourthViewController *fourVC = [[FourthViewController alloc] init];

    [self.navigationController pushViewController:secondVC animated:NO]; // 重要：一定是NO-YES-YES的这种，然后在第二次返回，也就是从thirdVC->secondVC的时候，触发崩溃
    [self.navigationController pushViewController:thirdVC animated:YES];
    [self.navigationController pushViewController:fourVC animated:YES];  // 这个执行之后的状态，已经不太对了，fourVC的UI没展示，但是navigationTitle变了，所以第一次返回之后，进入黑色的界面，已经状态错了；再点返回，就触发崩溃了

    // 尝试在push之后，延迟0.3秒，再push一次，无果，未复现
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.3f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//        [self.navigationController pushViewController:[[ThirdViewController alloc] init] animated:YES];
//    });
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 30;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *identifier = @"HelloCell";

    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }

    cell.textLabel.text = @"Hello";
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    // 同时push相同的VC，可以触发崩溃，但是调用栈显示的内容不同
    UIViewController *firstVC = [[UIViewController alloc] init];
    [self.navigationController pushViewController:firstVC animated:YES];
    [self.navigationController pushViewController:firstVC animated:YES];
}


@end
