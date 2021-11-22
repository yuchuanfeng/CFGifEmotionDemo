//
//  NSMutableAttributedString+DEText.h
//  Demo
//
//  Created by yuchuanfeng on 2021/11/20.
//  Copyright © 2021 于传峰. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DETextDefine.h"
NS_ASSUME_NONNULL_BEGIN

/**
 Text vertical alignment.
 */
typedef NS_ENUM(NSInteger, DETextVerticalAlignment) {
    DETextVerticalAlignmentTop =    0, ///< Top alignment.
    DETextVerticalAlignmentCenter = 1, ///< Center alignment.
    DETextVerticalAlignmentBottom = 2, ///< Bottom alignment.
};


@interface NSMutableAttributedString (DEText)

/// 会强持有 contentViewBlock，注意内存泄漏问题, alignment(TO DO)
+ (NSMutableAttributedString *)de_attachmentStringWithContentViewBlock:(DEContentViewBlock)contentViewBlock attachmentSize:(CGSize)attachmentSize alignment:(DETextVerticalAlignment)alignment;
@end

NS_ASSUME_NONNULL_END
