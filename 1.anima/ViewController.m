//
//  ViewController.m
//  1.anima
//
//  Created by OTC on 16/10/13.
//  Copyright © 2016年 OTC. All rights reserved.
//

#import "ViewController.h"
#import "WaveView.h"

@interface ViewController ()

@end

@implementation ViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.

    
    
    WaveView *view = [[WaveView alloc]initWithFrame:CGRectMake(0, 100, self.view.frame.size.width, 200)];
    view.backgroundColor = [UIColor grayColor];

    [self.view addSubview:view];
    
    
}




@end
