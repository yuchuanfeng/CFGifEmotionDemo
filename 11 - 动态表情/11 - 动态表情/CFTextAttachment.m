//
//  CFTextAttachment.m
//  11 - 动态表情
//
//  Created by 于传峰 on 15/12/29.
//  Copyright © 2015年 于传峰. All rights reserved.
//

#import "CFTextAttachment.h"
#import "UIImage+GIF.h"
#import "UIImageView+WebCache.h"

@interface CFTextAttachment()
@property (nonatomic, strong) UIImageView *imageView;
@end

@implementation CFTextAttachment

- (UIImageView *)imageView{
    if (_imageView == nil){
        _imageView = [[UIImageView alloc] init];
    }
    return _imageView;
}


- (UIImage *)imageForBounds:(CGRect)imageBounds textContainer:(NSTextContainer *)textContainer characterIndex:(NSUInteger)charIndex {
    [_imageView removeFromSuperview];
    UIImage* image = [super imageForBounds:imageBounds textContainer:textContainer characterIndex:charIndex];
    CGRect frame = imageBounds;
    if (textContainer != nil){
        frame = CGRectMake(frame.origin.x, frame.origin.y - frame.size.height, frame.size.width, frame.size.height);
    }
    self.imageView.frame = frame;
    if (_gifName != nil) {
        self.imageView.image = [UIImage sd_animatedGIFNamed:_gifName];
    }else if (_imageUrl != nil){
        [self.imageView sd_setImageWithURL:[[NSURL alloc] initWithString:_imageUrl]];
    }
    
    [self.containerView addSubview:_imageView];
    return  image;
}
@end
