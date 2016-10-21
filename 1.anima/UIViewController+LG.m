//
//  UIViewController+LG.m
//  1.anima
//
//  Created by OTC on 16/10/21.
//  Copyright © 2016年 OTC. All rights reserved.
//

#import "UIViewController+LG.h"
#import <objc/runtime.h>

@implementation UIViewController (LG)
+(void)load{
#ifdef DEBUG
    
    Method viewWillAppear = class_getInstanceMethod(self, @selector(viewWillAppear:));

    
    Method logViewAppear = class_getInstanceMethod(self, @selector(logViewAppear));
    
    method_exchangeImplementations(viewWillAppear, logViewAppear);
    
    
#endif
}

-(void)logViewAppear{
    NSString *className =  NSStringFromClass([self class]);
    
    NSLog(@"%@ will appear",className);
}
@end
