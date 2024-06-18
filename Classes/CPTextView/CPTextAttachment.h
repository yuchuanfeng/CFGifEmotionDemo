//
//  CPTextAttachment.h
//  InputView
//
//  Created by yuchuanfeng on 2024/6/17.
//

#import <UIKit/UIKit.h>
#import "CPTextAttachedViewProvider.h"

NS_ASSUME_NONNULL_BEGIN

@interface CPTextAttachment : NSTextAttachment
/// view 绑定对象
@property (nonatomic, strong, readonly) CPTextAttachedViewProvider *viewProvider;
/// 如果展示的 view 偏上时，可以将 y += font.descender
- (instancetype)initWithView:(UIView *)view bounds:(CGRect)bounds;
@end

NS_ASSUME_NONNULL_END
