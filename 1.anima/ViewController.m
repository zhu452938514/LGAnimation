//
//  ViewController.m
//  1.anima
//
//  Created by OTC on 16/10/13.
//  Copyright © 2016年 OTC. All rights reserved.
//
#define screenW [UIScreen mainScreen].bounds.size.width
#define screenH [UIScreen mainScreen].bounds.size.height
#import "ViewController.h"
#import "SecondViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.

    self.view.backgroundColor = [UIColor blackColor];
    
    
    
    
    
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    //BOSS直聘的modal效果
    //创建弹出的控制器
    SecondViewController *SecondVc = [[SecondViewController alloc]init];
    //设置转场的代理
    SecondVc.transitioningDelegate = SecondVc;
    //设置转场的样式
    SecondVc.modalPresentationStyle = UIModalPresentationCustom;
    [self presentViewController:SecondVc animated:true completion:nil];
}


@end
