//
//  CPTextAttachment.m
//  InputView
//
//  Created by yuchuanfeng on 2024/6/17.
//

#import "CPTextAttachment.h"

@interface CPTextAttachment ()
@property (nonatomic, strong) CPTextAttachedViewProvider *viewProvider;
@end

@implementation CPTextAttachment
- (instancetype)initWithView:(UIView *)view bounds:(CGRect)bounds {
    if (self = [super initWithData:nil ofType:nil]) {
        CPTextAttachedViewProvider *provider = [[CPTextAttachedViewProvider alloc] init];
        provider.view = view;
        _viewProvider = provider;
        self.bounds = bounds;
    }
    return self;
}

- (CGRect)attachmentBoundsForTextContainer:(NSTextContainer *)textContainer proposedLineFragment:(CGRect)lineFrag glyphPosition:(CGPoint)position characterIndex:(NSUInteger)charIndex {
    CGRect rect = self.bounds;
    return rect;
}

/// 不展示 image
- (UIImage *)imageForBounds:(CGRect)imageBounds textContainer:(NSTextContainer *)textContainer characterIndex:(NSUInteger)charIndex {
    return nil;
}


@end
