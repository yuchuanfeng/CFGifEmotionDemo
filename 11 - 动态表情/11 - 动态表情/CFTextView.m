//
//  CFTextView.m
//  11 - 动态表情
//
//  Created by 于传峰 on 15/12/29.
//  Copyright © 2015年 于传峰. All rights reserved.
//

#import "CFTextView.h"
#import "UIImage+GIF.h"
#import "CFTextAttachment.h"

@implementation CFTextView

- (void)setAttributedText:(NSAttributedString *)attributedText
{
    [super setAttributedText:attributedText];
    for (UIView* subView in self.subviews) {
        if ([subView isKindOfClass:[UIImageView class]]) {
            [subView removeFromSuperview];
        }
    }
    
    [self.attributedText enumerateAttribute:NSAttachmentAttributeName inRange:NSMakeRange(0, self.attributedText.length) options:NSAttributedStringEnumerationReverse usingBlock:^(CFTextAttachment* value, NSRange range, BOOL * _Nonnull stop) {
        if (value && CGRectEqualToRect(value.bounds, CGRectMake(0, 0, 60, 50))) {
            self.selectedRange = range;
            CGRect rect = [self firstRectForRange:self.selectedTextRange];
            self.selectedRange = NSMakeRange(0, 0);
    
            UIImageView* imageView = [[UIImageView alloc] init];
            [self addSubview:imageView];
            imageView.frame = rect;
            imageView.image = [UIImage sd_animatedGIFNamed:value.gifName];
//            imageView.backgroundColor = [UIColor greenColor];
        }
    }];

}

@end
