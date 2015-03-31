//
//  UIButton+Custom.m
//  EduAndCerti
//
//  Created by SangChan on 2015. 3. 31..
//  Copyright (c) 2015년 sangchan. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>
#import "UIButton+Custom.h"

@implementation UIButton (Custom)

-(void)defaultStyle {
    self.layer.borderWidth = 1;
    self.layer.cornerRadius = 4.0;
    self.layer.masksToBounds = YES;
    [self setAdjustsImageWhenHighlighted:NO];
    [self setTitleColor:[UIColor colorWithRed:0.05 green:0.58 blue:0.99 alpha:1.0] forState:UIControlStateNormal];
    self.backgroundColor = [UIColor whiteColor];
    self.layer.borderColor = [[UIColor colorWithRed:0.05 green:0.58 blue:0.99 alpha:1.0] CGColor];
    [self setBackgroundImage:[self buttonImageFromColor:[UIColor colorWithRed:235/255.0 green:235/255.0 blue:235/255.0 alpha:1]] forState:UIControlStateHighlighted];
}

- (UIImage *) buttonImageFromColor:(UIColor *)color {
    CGRect rect = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return img;
}

@end
