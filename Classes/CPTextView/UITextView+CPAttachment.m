//
//  UITextView+CPAttachment.m
//  InputView
//
//  Created by yuchuanfeng on 2024/6/17.
//

#import "UITextView+CPAttachment.h"

@implementation UITextView (CPAttachment)
- (CGRect)cp_convertRectFromTextContainer:(CGRect)rect {
    UIEdgeInsets insets = self.textContainerInset;
    return CGRectOffset(rect, insets.left, insets.top);
}
@end
