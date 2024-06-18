//
//  NSAttributedString+CPAttachment.h
//  InputView
//
//  Created by yuchuanfeng on 2024/6/17.
//

#import <Foundation/Foundation.h>
#import "CPTextAttachment.h"

NS_ASSUME_NONNULL_BEGIN

@interface CPAttachInfo : NSObject
@property (nonatomic, assign) NSRange range;
@property (nonatomic, strong) CPTextAttachment *attachment;
@end


@interface NSAttributedString (CPAttachment)
/// 获取当前展示的所有 attach 信息
@property (nonatomic, strong, readonly) NSArray <CPAttachInfo*>*cp_subviewAttachmentRanges;
@end

NS_ASSUME_NONNULL_END
