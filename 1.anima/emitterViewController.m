//
//  emitterViewController.m
//  1.anima
//
//  Created by OTC on 16/10/21.
//  Copyright © 2016年 OTC. All rights reserved.
//
#define ScreenW [UIScreen mainScreen].bounds.size.width
#define ScreenH [UIScreen mainScreen].bounds.size.height
#define LGColor(r, g, b) [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:1]
#import "emitterViewController.h"
#import "BarrageHeader.h"
@interface emitterViewController ()
{
    BarrageRenderer *_renderer;
}
@property(strong,nonatomic)CAEmitterLayer *emitterLayer;
@property(strong,nonatomic)NSTimer *timer;
@end

@implementation emitterViewController
-(CAEmitterLayer *)emitterLayer{
    if (!_emitterLayer) {
        _emitterLayer = [CAEmitterLayer layer];
        //发射位置
        _emitterLayer.emitterPosition = CGPointMake(ScreenW * 0.5, ScreenH - 50);
        //发射源大小
        _emitterLayer.emitterSize = CGSizeMake(20, 30);
        //渲染模式
        _emitterLayer.renderMode = kCAEmitterLayerUnordered;
        //发射源的形状
        _emitterLayer.emitterShape = kCAEmitterLayerPoint;
        //开启三维效果
        //_emitterLayer.preservesDepth = YES;
        NSMutableArray *arr = [NSMutableArray array];
        //创建粒子
        for (int i= 0; i<10; i++) {
            //发射单元
            CAEmitterCell *stepCell = [CAEmitterCell emitterCell];
            //粒子创建速率 默认是1/s;
            stepCell.birthRate = 1;
            //粒子存活时间
            stepCell.lifetime = arc4random_uniform(4) + 1;
            //粒子存活时间容差
            stepCell.lifetimeRange = 1.5;
            UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"good%d_30x30", i]];
            stepCell.contents = (__bridge id _Nullable)([image CGImage]);
            // 粒子的运动速度
            stepCell.velocity = arc4random_uniform(100) + 100;
            // 粒子速度的容差
            stepCell.velocityRange = 80;
            // 粒子在xy平面的发射角度
            stepCell.emissionLongitude = M_PI+M_PI_2;;
            // 粒子发射角度的容差
            stepCell.emissionRange = M_PI_2/6;
            // 缩放比例
            stepCell.scale = 0.3;
            [arr addObject:stepCell];
        }
        _emitterLayer.emitterCells = arr;
    }
    return _emitterLayer;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"直播点赞动画";
    self.view.backgroundColor = [UIColor whiteColor];
    [self.emitterLayer setHidden:false];
    [self.view.layer addSublayer:_emitterLayer];
    [self initBarrage];
    
    
    self.timer = [NSTimer scheduledTimerWithTimeInterval:0.8 target:self selector:@selector(autoSendBarrage) userInfo:nil repeats:YES];
}
-(void)initBarrage{
    _renderer = [[BarrageRenderer alloc] init];
    _renderer.canvasMargin = UIEdgeInsetsMake(self.view.frame.size.height * 0.3, 10, 10, 10);
    [_renderer start];
    [self.view addSubview:_renderer.view];
}
-(void)dealloc{
    [self.emitterLayer removeFromSuperlayer];
    _emitterLayer = nil;
}
- (void)autoSendBarrage
{
    NSInteger spriteNumber = [_renderer spritesNumberWithName:nil];
    if (spriteNumber <= 50) { // 限制屏幕上的弹幕量
        [_renderer receive:[self walkTextSpriteDescriptorWithDirection:BarrageWalkDirectionR2L]];
    }
}
- (BarrageDescriptor *)walkTextSpriteDescriptorWithDirection:(NSInteger)direction
{
    BarrageDescriptor * descriptor = [[BarrageDescriptor alloc]init];
    descriptor.spriteName = NSStringFromClass([BarrageWalkTextSprite class]);
    descriptor.params[@"text"] = self.danMuText[arc4random_uniform((uint32_t)self.danMuText.count)];
    descriptor.params[@"textColor"] = LGColor(arc4random_uniform(256), arc4random_uniform(256), arc4random_uniform(256));
    descriptor.params[@"speed"] = @(100 * (double)random()/RAND_MAX+50);
    descriptor.params[@"direction"] = @(direction);
    descriptor.params[@"clickAction"] = ^{
        
        NSLog(@"弹幕被点击");
        
    };
    return descriptor;
}
- (NSArray *)danMuText
{
    return [NSArray arrayWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"danmu.plist" ofType:nil]];
}
@end
