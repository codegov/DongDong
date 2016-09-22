//
//  DDLabel.m
//  DongDong
//
//  Created by javalong on 16/9/22.
//  Copyright © 2016年 javalong. All rights reserved.
//

#import "DDLabel.h"

@implementation DDLabel

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (void)drawTextInRect:(CGRect)rect
{
    CGSize shadowOffset = self.shadowOffset;
    UIColor *textColor = self.textColor;

    self.textColor = [UIColor redColor];
    
    CGContextRef c = UIGraphicsGetCurrentContext();
    CGContextSetLineWidth(c, 2);
    CGContextSetLineJoin(c, kCGLineJoinBevel);
    CGContextSetTextDrawingMode(c, kCGTextStroke);
    [super drawTextInRect:rect];
    
    self.textColor = textColor;
    CGContextSetTextDrawingMode(c, kCGTextFill);
    [super drawTextInRect:rect];

//    self.shadowOffset = shadowOffset;
}

//- (void)drawTextInRect:(CGRect)rect
//{
//    CGSize shadowOffset = self.shadowOffset;
//    UIColor *textColor = self.textColor;
//    
//    CGContextRef c = UIGraphicsGetCurrentContext();
//    CGContextSetLineWidth(c, 2);
//    CGContextSetLineJoin(c, kCGLineJoinBevel);
//    CGContextSetTextDrawingMode(c, kCGTextStroke);
//    self.textColor = [UIColor redColor];
//    [super drawTextInRect:rect];
//    
//    CGContextSetTextDrawingMode(c, kCGTextFill);
//    self.textColor = textColor;
//    self.shadowOffset = CGSizeMake(0, 0);
//    [super drawTextInRect:rect];
//    
//    self.shadowOffset = shadowOffset;
//}

@end
