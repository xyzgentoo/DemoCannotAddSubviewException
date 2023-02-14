//
//  SecondViewController.m
//  testCannotAddSubview
//
//  Created by Hong Li on 2023/2/14.
//

#import "SecondViewController.h"

@interface SecondViewController ()

@end

@implementation SecondViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.navigationItem.title = @"SecondVC";
    self.view.backgroundColor = [UIColor yellowColor];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];

//    [self.navigationController popViewControllerAnimated:YES];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
