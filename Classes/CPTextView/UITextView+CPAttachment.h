//
//  UITextView+CPAttachment.h
//  InputView
//
//  Created by yuchuanfeng on 2024/6/17.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UITextView (CPAttachment)
/// 坐标偏移，增加 textContainerInset 兼容
- (CGRect)cp_convertRectFromTextContainer:(CGRect)rect;
@end

NS_ASSUME_NONNULL_END
