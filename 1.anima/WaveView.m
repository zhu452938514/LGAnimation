//
//  WaveView.m
//  1.anima
//
//  Created by OTC on 16/10/13.
//  Copyright © 2016年 OTC. All rights reserved.
//

#import "WaveView.h"

@interface WaveView ()
@property(nonatomic,strong)CAShapeLayer *waveLayer;
@property(nonatomic,strong)CADisplayLink *displayLink;
@property (nonatomic, assign) CGFloat offset;

@property (nonatomic, assign) CGFloat radius;
//波浪颜色
@property(nonatomic,strong)UIColor *waveColor;

//距离底部距离
@property(nonatomic,assign)CGFloat bottomEdge;

//波浪速度(1-10,10最快)
@property(nonatomic,assign)CGFloat waveSpeed;

//波浪高度
@property(nonatomic,assign)CGFloat waveHeight;

@end

@implementation WaveView

-(CAShapeLayer *)waveLayer{
    if (!_waveLayer) {
        _waveLayer = [CAShapeLayer layer];
    }
    return _waveLayer;
}
-(CADisplayLink *)displayLink{
    if (!_displayLink) {
        _displayLink = [CADisplayLink displayLinkWithTarget:self selector:@selector(getCurrent)];
    }
    return _displayLink;
}
-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self initConfig];
    }
    return self;
}
-(void)initConfig{
    
    self.bottomEdge = 50 ;
    
    self.waveSpeed =  0.3;
    
    self.radius = 0.009;
    
    self.waveHeight = 10;
    self.waveLayer.frame = self.bounds;
    self.waveLayer.fillColor = [UIColor redColor].CGColor;
    [self.layer addSublayer:self.waveLayer];
    
    [self.displayLink addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSRunLoopCommonModes];
}

-(void)getCurrent{
    self.offset += self.waveSpeed;
    CGMutablePathRef path = CGPathCreateMutable();
    CGFloat width = [UIScreen mainScreen].bounds.size.width;
    CGFloat height = self.waveHeight;
    CGPathMoveToPoint(path, nil, 0, 150);
    CGFloat y = 0.0;
    for (CGFloat x = 0; x < width; x++) {
        y = height * sin(self.radius * x + self.offset) +  self.frame.size.height - self.bottomEdge;
        CGPathAddLineToPoint(path, nil, x, y);
    }
    CGPathAddLineToPoint(path, NULL, width, self.frame.size.height);
    CGPathAddLineToPoint(path, NULL, 0, self.frame.size.height);
    CGPathCloseSubpath(path);
    self.waveLayer.path = path;
    
    CGPathRelease(path);
}

@end
