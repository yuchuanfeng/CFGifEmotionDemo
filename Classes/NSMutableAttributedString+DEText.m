//
//  NSMutableAttributedString+DEText.m
//  Demo
//
//  Created by yuchuanfeng on 2021/11/20.
//  Copyright © 2021 于传峰. All rights reserved.
//

#import "NSMutableAttributedString+DEText.h"
#import "DETextAttachment.h"
#import <objc/runtime.h>


@interface NSMutableAttributedString ()
@end

@implementation NSMutableAttributedString (DEText)
+ (NSMutableAttributedString *)de_attachmentStringWithContentViewBlock:(DEContentViewBlock)contentViewBlock attachmentSize:(CGSize)attachmentSize alignment:(DETextVerticalAlignment)alignment {
    DETextAttachment *attachment = [[DETextAttachment alloc] init];
    attachment.de_contentViewBlock = contentViewBlock;
    attachment.bounds = CGRectMake(0, 0, attachmentSize.width, attachmentSize.height);
    NSMutableAttributedString *attr = [[NSMutableAttributedString alloc] initWithAttributedString:[NSAttributedString attributedStringWithAttachment:attachment]];
    return attr;
}
//+ (NSMutableDictionary *)de_contentViewMap {
//    return objc_getAssociatedObject(self, @selector(de_contentViewMap));
//}
//+ (void)setDe_contentViewMap:(NSMutableDictionary *)dict {
//    objc_setAssociatedObject(self, @selector(de_contentViewMap), dict, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
//}
//+ (NSMutableDictionary *)de_contentViewMap {
//    return objc_getAssociatedObject(self, @selector(de_contentViewMap));
//}
//+ (void)setDe_contentViewMap:(NSMutableDictionary *)dict {
//    objc_setAssociatedObject(self, @selector(de_contentViewMap), dict, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
//}
@end
