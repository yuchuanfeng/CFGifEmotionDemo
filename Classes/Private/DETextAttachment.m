//
//  DETextAttachment.m
//  Demo
//
//  Created by yuchuanfeng on 2021/11/20.
//  Copyright © 2021 于传峰. All rights reserved.
//

#import "DETextAttachment.h"

@implementation DETextAttachment


- (UIImage *)imageForBounds:(CGRect)imageBounds textContainer:(NSTextContainer *)textContainer characterIndex:(NSUInteger)charIndex {
    UIImage* image = [super imageForBounds:imageBounds textContainer:textContainer characterIndex:charIndex];
    CGRect frame = imageBounds;
    if (textContainer != nil){
        frame = CGRectMake(frame.origin.x, frame.origin.y - frame.size.height, frame.size.width, frame.size.height);
    }
    self.de_contentView.frame = frame;
    return  image;
}


@end
