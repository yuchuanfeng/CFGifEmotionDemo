//
//  NSAttributedString+CPAttachment.m
//  InputView
//
//  Created by yuchuanfeng on 2024/6/17.
//

#import "NSAttributedString+CPAttachment.h"

@implementation CPAttachInfo


@end

@implementation NSAttributedString (CPAttachment)
- (NSArray<CPAttachInfo*> *)cp_subviewAttachmentRanges {
    NSMutableArray *array = [NSMutableArray array];
    [self enumerateAttribute:NSAttachmentAttributeName inRange:NSMakeRange(0, self.length) options:NSAttributedStringEnumerationReverse usingBlock:^(CPTextAttachment* value, NSRange range, BOOL * _Nonnull stop) {
        if ([value isKindOfClass:[CPTextAttachment class]]) {
            CPAttachInfo *info = [[CPAttachInfo alloc] init];
            info.range = range;
            info.attachment = value;
            [array addObject:info];
        }
    }];
    return array;
}
@end
