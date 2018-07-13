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

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
    {
        
    }
    return self;
}

- (void)setAttributedText:(NSAttributedString *)attributedText
{
    if (self.attributedText != nil){
        [self.attributedText enumerateAttribute:NSAttachmentAttributeName inRange:NSMakeRange(0, self.attributedText.length) options:NSAttributedStringEnumerationReverse usingBlock:^(CFTextAttachment* value, NSRange range, BOOL * _Nonnull stop) {
            if (value && CGRectEqualToRect(value.bounds, gifRect)) {
                [value reset];
            }
        }];
    }
    
    [super setAttributedText:attributedText];
    
    [self.attributedText enumerateAttribute:NSAttachmentAttributeName inRange:NSMakeRange(0, self.attributedText.length) options:NSAttributedStringEnumerationReverse usingBlock:^(CFTextAttachment* value, NSRange range, BOOL * _Nonnull stop) {
        if (value && CGRectEqualToRect(value.bounds, gifRect)) {
            value.containerView = self;
        }
    }];
    
    [self setNeedsDisplay];
}

@end
