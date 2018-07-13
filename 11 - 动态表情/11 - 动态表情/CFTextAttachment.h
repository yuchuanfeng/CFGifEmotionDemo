//
//  CFTextAttachment.h
//  11 - 动态表情
//
//  Created by 于传峰 on 15/12/29.
//  Copyright © 2015年 于传峰. All rights reserved.
//

#import <UIKit/UIKit.h>

#define gifRect CGRectMake(0, 0, 60, 50)

@interface CFTextAttachment : NSTextAttachment
@property (nonatomic, copy) NSString *gifName;
@property (nonatomic, copy) NSString *imageUrl;
@property (nonatomic, weak) UIView *containerView;

- (void)reset;

@end
