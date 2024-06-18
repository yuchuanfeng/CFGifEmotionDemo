//
//  CPTextView.m
//  InputView
//
//  Created by yuchuanfeng on 2024/6/17.
//

#import "CPTextView.h"
#import "CPAttachingTextViewManager.h"
#import <YYCategories/NSString+YYAdd.h>
#import "CPTextAttachment.h"

@interface CPTextView ()
@property (nonatomic, strong) CPAttachingTextViewManager *viewManager;
@end

@implementation CPTextView

- (instancetype)initWithFrame:(CGRect)frame  {
    if (self = [super initWithFrame:frame]) {
        self.viewManager.textView = self;
        self.layoutManager.delegate = self.viewManager;
        self.textStorage.delegate = self.viewManager;
    }
    return self;
}

- (void)appendTitleBlockWithTitle:(NSString *)title {
    UILabel *label = [[UILabel alloc] init];
    label.textColor = [UIColor redColor];
    label.font = self.font;
    label.textAlignment = NSTextAlignmentCenter;
    label.backgroundColor = [UIColor blueColor];
    label.layer.cornerRadius = 5;
    label.layer.masksToBounds = YES;
    label.text = title;
    label.userInteractionEnabled = YES;

    CGFloat labelWidth = [title widthForFont:label.font];
    CPTextAttachment *attachment = [[CPTextAttachment alloc] initWithView:label bounds:CGRectMake(0, self.font.descender, labelWidth, self.font.lineHeight)];
//    NSTextAttachment *attachment = [[NSTextAttachment alloc] init];
//    attachment.bounds = CGRectMake(0, self.font.descender, labelWidth, self.font.lineHeight);
    NSMutableAttributedString *attr = [[NSAttributedString attributedStringWithAttachment:attachment] mutableCopy];
//    NSMutableAttributedString *attr = [[[NSAttributedString alloc] initWithString:@"test"] mutableCopy];
    [attr insertAttributedString:[[NSAttributedString alloc] initWithString:@"尼玛啊"] atIndex:0];
    [attr addAttributes:@{
        NSForegroundColorAttributeName: self.textColor,
        NSFontAttributeName: self.font
    } range:NSMakeRange(0, attr.length)];
    self.attributedText = attr;
}

- (CPAttachingTextViewManager *)viewManager {
    if (!_viewManager) {
        _viewManager = [[CPAttachingTextViewManager alloc] init];
    }
    return _viewManager;
}

- (void)setTextContainerInset:(UIEdgeInsets)textContainerInset {
    [super setTextContainerInset:textContainerInset];
    [self.viewManager layoutAttachedSubviews];
}
@end
