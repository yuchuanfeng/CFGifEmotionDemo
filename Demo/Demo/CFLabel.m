//
//  CFTextView.m
//  11 - 动态表情
//
//  Created by 于传峰 on 15/12/29.
//  Copyright © 2015年 于传峰. All rights reserved.
//

#import "CFLabel.h"
#import "UIImage+GIF.h"
#import "CFTextAttachment.h"

@implementation CFLabel

//- (instancetype)initWithFrame:(CGRect)frame
//{
//    if (self = [super initWithFrame:frame])
//    {
//        
//    }
//    return self;
//}
//
- (void)setAttributedText:(NSAttributedString *)attributedText
{
    [super setAttributedText:attributedText];
    NSLog(@"%@", @(self.subviews.count));
}

@end
