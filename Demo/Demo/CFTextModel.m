//
//  CFTextModel.m
//  11 - 动态表情
//
//  Created by 于传峰 on 15/12/29.
//  Copyright © 2015年 于传峰. All rights reserved.
//

#import "CFTextModel.h"
#import <UIKit/UIKit.h>
#import <SDWebImage/SDWebImage.h>
#import <DEText/NSMutableAttributedString+DEText.h>

@interface CFTextModel ()
@property (nonatomic, strong, class, readonly) NSMutableDictionary *gifImageCache;
@end

@implementation CFTextModel {
    NSRegularExpression *_regex;
    NSDictionary *_mapper;
    dispatch_semaphore_t _lock;
}

- (void)setupEmoticonMapper:(NSDictionary *)emoticonMapper {
    _mapper = emoticonMapper.copy;
    if (_mapper.count == 0) {
        _regex = nil;
    } else {
        NSMutableString *pattern = @"(".mutableCopy;
        NSArray *allKeys = _mapper.allKeys;
        NSCharacterSet *charset = [NSCharacterSet characterSetWithCharactersInString:@"$^?+*.,#|{}[]()\\"];
        for (NSUInteger i = 0, max = allKeys.count; i < max; i++) {
            NSMutableString *one = [allKeys[i] mutableCopy];
            
            // escape regex characters
            for (NSUInteger ci = 0, cmax = one.length; ci < cmax; ci++) {
                unichar c = [one characterAtIndex:ci];
                if ([charset characterIsMember:c]) {
                    [one insertString:@"\\" atIndex:ci];
                    ci++;
                    cmax++;
                }
            }
            
            [pattern appendString:one];
            if (i != max - 1) [pattern appendString:@"|"];
        }
        [pattern appendString:@")"];
        _regex = [[NSRegularExpression alloc] initWithPattern:pattern options:kNilOptions error:nil];
    }
}

- (BOOL)parseText:(NSMutableAttributedString *)text {
    if (text.length == 0) return NO;
    
    NSDictionary *mapper;
    NSRegularExpression *regex;
    mapper = _mapper; regex = _regex;
    if (mapper.count == 0 || regex == nil) return NO;
    
    NSArray *matches = [regex matchesInString:text.string options:kNilOptions range:NSMakeRange(0, text.string.length)];
    if (matches.count == 0) return NO;
    
    NSUInteger cutLength = 0;
    for (NSUInteger i = 0, max = matches.count; i < max; i++) {
        NSTextCheckingResult *one = matches[i];
        NSRange oneRange = one.range;
        if (oneRange.length == 0) continue;
        oneRange.location -= cutLength;
//        if (oneRange.location < 0 || oneRange.location > text.string.length - 2 || oneRange.location + oneRange.length > text.string.length - 1) {
//            continue;
//        }
        NSString *subStr = [text.string substringWithRange:oneRange];
        NSString *emoticonStr = mapper[subStr];
        if (!emoticonStr) continue;
        [self replaceRange:oneRange imageStr:emoticonStr contentAttr:text];
        cutLength += oneRange.length - 1;
    }
    
    return YES;
}

- (void)replaceRange: (NSRange)range imageStr: (NSString *)imageStr contentAttr: (NSMutableAttributedString *)text {
    NSMutableAttributedString *attr = [NSMutableAttributedString de_attachmentStringWithContentViewBlock:^UIView *{
        UIImageView *imageView = [[UIImageView alloc] init];
        imageView.backgroundColor = [UIColor redColor];
        if ([imageStr hasPrefix:@"https://"]){ // 网络图片
            [imageView sd_setImageWithURL:[NSURL URLWithString:imageStr]];
        }else {
            UIImage *gifImage = CFTextModel.gifImageCache[imageStr];
            if (!gifImage) {
                NSString *gifPath = [[NSBundle mainBundle] pathForResource:imageStr ofType:@"gif"];
                NSData *gifData = [NSData dataWithContentsOfFile:gifPath];
                gifImage = [UIImage sd_imageWithGIFData:gifData];
                CFTextModel.gifImageCache[imageStr] = gifImage;
            }
            imageView.image = gifImage;
        }
        return imageView;
    } attachmentSize:CGSizeMake(50, 50) alignment:DETextVerticalAlignmentBottom];
    [text replaceCharactersInRange:range withAttributedString:attr];
}


- (void)setContentString:(NSString *)contentString
{
    _contentString = contentString;
    NSString* path = [[NSBundle mainBundle] pathForResource:@"EmotionGifList" ofType:@"plist"];
    NSDictionary* emotionDic = [NSDictionary dictionaryWithContentsOfFile:path];
    NSMutableAttributedString* attributedString = [[NSMutableAttributedString alloc] initWithString:contentString];
    [self setupEmoticonMapper:emotionDic];
    [self parseText:attributedString];
    [attributedString addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(0, attributedString.length)];
    [attributedString addAttribute:NSFontAttributeName value:[UIFont boldSystemFontOfSize:17] range:NSMakeRange(0, attributedString.length)];
    
    NSMutableParagraphStyle* paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle setParagraphStyle:[NSParagraphStyle defaultParagraphStyle]];
    paragraphStyle.lineBreakMode = NSLineBreakByCharWrapping;
    paragraphStyle.lineSpacing = 10;
    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, attributedString.length)];
    
    self.attributedString = attributedString;
}

- (void)setAttributedString:(NSMutableAttributedString *)attributedString
{
    _attributedString = attributedString;
    self.height = [attributedString boundingRectWithSize:CGSizeMake([UIScreen mainScreen].bounds.size.width-40 , CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesDeviceMetrics|NSStringDrawingTruncatesLastVisibleLine context:NULL].size.height+20;
//    NSLog(@"heigt = %f", self.height);
}
+ (NSMutableDictionary *)gifImageCache {
    static NSMutableDictionary *_gifImageCache;
    if (!_gifImageCache) {
        _gifImageCache = [NSMutableDictionary dictionary];
    }
    return _gifImageCache;
}
@end
