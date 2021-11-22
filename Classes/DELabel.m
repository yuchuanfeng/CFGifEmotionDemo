//
//  CFTextView.m
//  11 - 动态表情
//
//  Created by 于传峰 on 15/12/29.
//  Copyright © 2015年 于传峰. All rights reserved.
//

#import "DELabel.h"
#import "NSMutableAttributedString+DEText.h"
#import "DETextAttachment.h"

@implementation DELabel

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
    {
        
    }
    return self;
}

- (void)setAttributedText:(NSAttributedString *)attributedText
{
    if (self.attributedText){
        [self.attributedText enumerateAttribute:NSAttachmentAttributeName inRange:NSMakeRange(0, self.attributedText.length) options:NSAttributedStringEnumerationReverse usingBlock:^(DETextAttachment* value, NSRange range, BOOL * _Nonnull stop) {
            if ([value isKindOfClass:[DETextAttachment class]] && value.de_contentView) {
                [value.de_contentView removeFromSuperview];
            }
        }];
    }
    [super setAttributedText:attributedText];
    [self.attributedText enumerateAttribute:NSAttachmentAttributeName inRange:NSMakeRange(0, self.attributedText.length) options:NSAttributedStringEnumerationReverse usingBlock:^(DETextAttachment* value, NSRange range, BOOL * _Nonnull stop) {
        if ([value isKindOfClass:[DETextAttachment class]]) {
            [value.de_contentView removeFromSuperview];
            UIView *contentView = value.de_contentViewBlock ? value.de_contentViewBlock() : nil;
            value.de_contentView = contentView;
            [self addSubview:value.de_contentView];
        }
    }];
    [self setNeedsDisplay];
}

@end
