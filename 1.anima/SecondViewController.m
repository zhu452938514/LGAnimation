//
//  SecondViewController.m
//  1.anima
//
//  Created by OTC on 16/10/13.
//  Copyright © 2016年 OTC. All rights reserved.
//

#import "SecondViewController.h"

@interface SecondViewController ()<UIViewControllerTransitioningDelegate,UIViewControllerAnimatedTransitioning>
@property(nonatomic,assign)BOOL isPresented;
@end

@implementation SecondViewController


-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor redColor];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self dismissViewControllerAnimated:true completion:nil];
}
#pragma mark:UIViewControllerTransitioningDelegate
// 目的:改变弹出View的尺寸(弹出的是整个View所以不用此方法)
//-(UIPresentationController *)presentationControllerForPresentedViewController:(UIViewController *)presented presentingViewController:(UIViewController *)presenting sourceViewController:(UIViewController *)source{
    
//}
//自定义弹出动画
-(id<UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source{
    _isPresented = true;
    return  self;
}
//自定义消失电话
-(id<UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed{
     _isPresented = false;
    return self;
}
#pragma mark:UIViewControllerAnimatedTransitioning 弹出消失动画的代理的方法
//动画执行时长..感觉没啥用..
-(NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext{
    return 1.0;
}
/// 获取`转场的上下文`:可以通过转场上下文获取弹出的View和消失的View
// UITransitionContextFromViewKey : 获取消失的View
// UITransitionContextToViewKey : 获取弹出的View
-(void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext{
    if (_isPresented) {
        //自定义的弹出动画
        UIView *presentView = [transitionContext viewForKey:UITransitionContextToViewKey];
        // 将弹出的View添加到containerView中
        [[transitionContext containerView] addSubview:presentView];
        presentView.transform = CGAffineTransformScale(presentView.transform, 1.0, 0.0);
        //设置锚点
        presentView.layer.anchorPoint = CGPointMake(0.5, 0.5);
        [UIView animateWithDuration:0.5 animations:^{
            presentView.transform = CGAffineTransformIdentity;
        } completion:^(BOOL finished) {
            presentView.alpha = 1.0;
            //完成必须执行下面这行代码
            [transitionContext completeTransition:true];
        }];
    }else{
        UIView *fromView = [transitionContext viewForKey:UITransitionContextFromViewKey];
        
        [UIView animateWithDuration:0.25 animations:^{
            fromView.transform = CGAffineTransformTranslate(fromView.transform, 0, self.view.frame.size.height);
            
        } completion:^(BOOL finished) {
            [transitionContext completeTransition:true];
        }];
    }
}
@end
