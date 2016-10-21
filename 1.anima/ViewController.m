//
//  ViewController.m
//  1.anima
//
//  Created by OTC on 16/10/13.
//  Copyright © 2016年 OTC. All rights reserved.
//
#define LGscreenW [UIScreen mainScreen].bounds.size.width
#define LGscreenH [UIScreen mainScreen].bounds.size.height
#define LGHeadH 150
#import "ViewController.h"
#import "SecondViewController.h"
#import "emitterViewController.h"
#import "UIView+LG.h"


@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>


@property(strong,nonatomic)UITableView *tableView;
@property(weak,nonatomic)UIImageView *headImageView;
@end

@implementation ViewController
-(UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc]init];
        _tableView.frame = CGRectMake(0, 64, LGscreenW, LGscreenH - 64);
        _tableView.delegate = self;
        _tableView.dataSource = self;
    }
    return _tableView;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.view.backgroundColor = [UIColor whiteColor];
    self.automaticallyAdjustsScrollViewInsets = false;
    [self.view addSubview:self.tableView];
    [self setUpHeader];
}

-(void)setUpHeader{
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, LGscreenW, LGHeadH)];
    UIImageView *imageView = [[UIImageView alloc] init];
    imageView.image = [UIImage imageNamed:@"photo"];
    imageView.frame = CGRectMake(0, 0,LGscreenW, LGHeadH);
    imageView.contentMode = UIViewContentModeScaleAspectFill;
    [view addSubview:imageView];
    self.tableView.sectionHeaderHeight = LGHeadH;	
    self.tableView.tableHeaderView = view;
    self.headImageView = imageView;
    
}

#pragma mark:- delegate,dataSource

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 2;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellId = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellId];
    }
    switch (indexPath.row) {
        case 0:
        {
            cell.textLabel.text = @"BOSS直聘转场动画";
        }
            break;
        case 1:
        {
            cell.textLabel.text = @"直播点赞弹幕动画";

        }
            break;
        default:
            break;
    }
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:false];
    
    switch (indexPath.row) {
        case 0:
        {
            //BOSS直聘的modal效果
            //创建弹出的控制器
            SecondViewController *SecondVc = [[SecondViewController alloc]init];
            //设置转场的代理
            SecondVc.transitioningDelegate = SecondVc;
            //设置转场的样式
            SecondVc.modalPresentationStyle = UIModalPresentationCustom;
            [self presentViewController:SecondVc animated:true completion:nil];
        }
            break;
        case 1:
        {
            emitterViewController *emiVc = [[emitterViewController alloc]init];
            [self.navigationController pushViewController:emiVc animated:YES];
            
        }
            break;
        default:
            break;
    }
}
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    CGFloat currentOffsetY  = scrollView.contentOffset.y;
    if (currentOffsetY <= 0) {
        self.headImageView.y = currentOffsetY;
        self.headImageView.height = (- currentOffsetY) + LGHeadH;
    }
}



@end
