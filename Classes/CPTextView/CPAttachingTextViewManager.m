//
//  CPAttachingTextViewManager.m
//  InputView
//
//  Created by yuchuanfeng on 2024/6/17.
//

#import "CPAttachingTextViewManager.h"
#import "CPTextAttachedViewProvider.h"
#import "NSAttributedString+CPAttachment.h"
#import "UITextView+CPAttachment.h"

@interface CPAttachingTextViewManager ()
/// 缓存的 attach 信息
@property (nonatomic, strong) NSMapTable <CPTextAttachedViewProvider *, UIView *>*attachedViews;
/// 缓存的 attach 信息 （attachedViews 取 keys）
@property (nonatomic, strong, readonly) NSArray <CPTextAttachedViewProvider *>*attachedProviders;
@end

@implementation CPAttachingTextViewManager
/// 更新 attach 内容，移除删除的，增加新增的
- (void)updateAttachedSubviews {
    if (!self.textView) {
        return;
    }
    // 获取当前展示的 attach
    NSMutableArray *attachments = [NSMutableArray array];
    [self.textView.textStorage.cp_subviewAttachmentRanges enumerateObjectsUsingBlock:^(CPAttachInfo * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [attachments addObject:obj.attachment];
    }];
    // 当前展示和已缓存的对比
    [self.attachedProviders enumerateObjectsUsingBlock:^(CPTextAttachedViewProvider * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        __block BOOL needRemove = YES;
        [attachments enumerateObjectsUsingBlock:^(CPTextAttachment  *_Nonnull attachment, NSUInteger idx, BOOL * _Nonnull stop2) {
            if (attachment.viewProvider == obj) {
                *stop2 = YES;
                needRemove = NO;
            }
        }];
        // 不展示的删除
        if (needRemove) {
            [[self.attachedViews objectForKey:obj] removeFromSuperview];
            [self.attachedViews removeObjectForKey:obj];
        }
    }];
    // 需要添加的
    NSMutableArray *attachmentsToAdd = [attachments mutableCopy];
    [attachmentsToAdd filterUsingPredicate:[NSPredicate predicateWithBlock:^BOOL(CPTextAttachment  *_Nullable attachment, NSDictionary<NSString *,id> * _Nullable bindings) {
        // 当前缓存的没有，而展示的有，代表需要添加
        if ([self.attachedViews objectForKey:attachment.viewProvider]) {
            return NO;
        }
        return YES;
    }]];
    [attachmentsToAdd enumerateObjectsUsingBlock:^(CPTextAttachment  *_Nonnull attachment, NSUInteger idx, BOOL * _Nonnull stop) {
        UIView *view = attachment.viewProvider.view;
        view.translatesAutoresizingMaskIntoConstraints = YES;
        view.autoresizingMask = UIViewAutoresizingNone;
        // 添加并更新缓存
        [self.textView addSubview:view];
        [self.attachedViews setObject:view forKey:attachment.viewProvider];
    }];
}
/// 更新 attach 布局
- (void)layoutAttachedSubviews {
    if (!self.textView) {
        return;
    }
    NSLayoutManager *layoutManager = self.textView.layoutManager;
    // 当前展示的 attach
    NSArray<CPAttachInfo*> *attachmentRanges = self.textView.textStorage.cp_subviewAttachmentRanges;
    for (CPAttachInfo * obj in attachmentRanges) {
        UIView *view = [self.attachedViews objectForKey:obj.attachment.viewProvider];
        if (!view) {
            continue;
        }
        if (view.superview != self.textView) {
            continue;
        }
        // 获取坐标
        CGRect attachmentRect = [CPAttachingTextViewManager boundingRectForAttachmentCharacterAt:obj.range.location layoutManager:layoutManager];
        if (CGRectEqualToRect(CGRectZero, attachmentRect)) {
            view.hidden = YES;
            continue;
        }
        CGRect convertedRect = [self.textView cp_convertRectFromTextContainer:attachmentRect];
        [UIView performWithoutAnimation:^{
            view.frame = convertedRect;
            view.hidden = NO;
        }];
    }
}

#pragma mark - help methods
/// 移除所有 attach
- (void)removeAttachedSubviews {
    for (CPTextAttachedViewProvider *provider in self.attachedProviders) {
        [[self.attachedViews objectForKey:provider] removeFromSuperview];
    }
    [self.attachedViews removeAllObjects];
}
/// 获取 attach 坐标
+ (CGRect)boundingRectForAttachmentCharacterAt:(NSInteger)characterIndex layoutManager:(NSLayoutManager *)layoutManager {
    NSRange glyphRange = [layoutManager glyphRangeForCharacterRange:NSMakeRange(characterIndex, 1) actualCharacterRange:nil];
    NSInteger glyphIndex = glyphRange.location;
    if (glyphIndex != NSNotFound && glyphRange.length == 1) {
        CGSize attachmentSize = [layoutManager attachmentSizeForGlyphAtIndex:glyphIndex];
        if (attachmentSize.width > 0.0 && attachmentSize.height > 0.0) {
            CGRect lineFragmentRect = [layoutManager lineFragmentRectForGlyphAtIndex:glyphIndex effectiveRange:nil];
            CGPoint glyphLocation = [layoutManager locationForGlyphAtIndex:glyphIndex];
            if (lineFragmentRect.size.width > 0.0 && lineFragmentRect.size.height > 0.0) {
                CGRect rect = CGRectMake(lineFragmentRect.origin.x + glyphLocation.x, lineFragmentRect.origin.y + glyphLocation.y - attachmentSize.height, attachmentSize.width, attachmentSize.height);
                return rect;
            }
        }
    }
    return CGRectZero;
}

#pragma mark - NSLayoutManagerDelegate
// 布局完成
- (void)layoutManager:(NSLayoutManager *)layoutManager didCompleteLayoutForTextContainer:(NSTextContainer *)textContainer atEnd:(BOOL)layoutFinishedFlag {
    if (layoutFinishedFlag) {
        [self layoutAttachedSubviews];
    }
}

#pragma mark - NSTextStorageDelegate
// 编辑
- (void)textStorage:(NSTextStorage *)textStorage didProcessEditing:(NSTextStorageEditActions)editedMask range:(NSRange)editedRange changeInLength:(NSInteger)delta {
    if (editedMask & NSTextStorageEditedAttributes) {
        [self updateAttachedSubviews];
    }
}

#pragma mark - Setter  Getter

- (NSMapTable *)attachedViews {
    if (!_attachedViews) {
        _attachedViews = [NSMapTable strongToStrongObjectsMapTable];
    }
    return _attachedViews;
}

- (NSArray<CPTextAttachedViewProvider *> *)attachedProviders {
    return self.attachedViews.keyEnumerator.allObjects;
}

- (void)setTextView:(UITextView *)textView {
    [self removeAttachedSubviews];
    _textView = textView;
    [self updateAttachedSubviews];
    [self layoutAttachedSubviews];
}

@end
