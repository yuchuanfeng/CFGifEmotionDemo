//
//  DETextAttachment.h
//  Demo
//
//  Created by yuchuanfeng on 2021/11/20.
//  Copyright © 2021 于传峰. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DETextDefine.h"

NS_ASSUME_NONNULL_BEGIN

@interface DETextAttachment : NSTextAttachment
/// 内容view
@property (nonatomic, weak, nullable) UIView *de_contentView;
@property (nonatomic, copy) DEContentViewBlock de_contentViewBlock;
@end

NS_ASSUME_NONNULL_END
