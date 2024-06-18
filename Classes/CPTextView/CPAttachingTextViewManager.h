//
//  CPAttachingTextViewManager.h
//  InputView
//
//  Created by yuchuanfeng on 2024/6/17.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface CPAttachingTextViewManager : NSObject <NSLayoutManagerDelegate, NSTextStorageDelegate>
/// 需要添加到的 textView
@property (nonatomic, weak) UITextView *textView;
/// 重新布局
- (void)layoutAttachedSubviews;
@end

NS_ASSUME_NONNULL_END
