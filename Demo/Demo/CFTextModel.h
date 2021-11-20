//
//  CFTextModel.h
//  11 - 动态表情
//
//  Created by 于传峰 on 15/12/29.
//  Copyright © 2015年 于传峰. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreGraphics/CoreGraphics.h>

@interface CFTextModel : NSObject

@property (nonatomic, strong) NSMutableAttributedString *attributedString;
@property (nonatomic, copy) NSString *contentString;
@property (nonatomic, assign) CGFloat height;
@end
