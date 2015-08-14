//
//  UIButton+BackgroundColorForState.m
//  CloudDJ
//
//  Created by Dulio Denis on 8/14/15.
//  Copyright (c) 2015 Dulio Denis. All rights reserved.
//

#import "UIButton+BackgroundColorForState.h"

@implementation UIButton (BackgroundColorForState)

- (void)setBackgroundColor:(UIColor *)backgroundColor forState:(UIControlState)state {
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 1, 1)];
    view.backgroundColor = backgroundColor;
    
    UIGraphicsBeginImageContext(view.frame.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    [view.layer renderInContext:context];
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    [self setBackgroundImage:image forState:state];
}

@end
