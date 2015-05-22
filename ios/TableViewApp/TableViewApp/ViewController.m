//
//  ViewController.m
//  TableViewApp
//
//  Created by doortts on 5/21/15.
//  Copyright (c) 2015 com.doortts. All rights reserved.
//


#import "ViewController.h"


@interface ViewController ()

@end

@implementation ViewController


- (void)viewDidLoad {
    [super viewDidLoad];

    [[self view] setBackgroundColor:[UIColor whiteColor]];
    CGRect sBounds = [[self view] bounds];
    self.mTableView = [[UITableView alloc] initWithFrame:sBounds];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc {
    [self.mTableView release];
    [super dealloc];
}

@end
