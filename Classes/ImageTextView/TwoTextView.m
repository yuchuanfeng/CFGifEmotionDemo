//
//  TwoTextView.m
//  InputView
//
//  Created by yuchuanfeng on 2024/6/21.
//

#import "TwoTextView.h"
#import <Masonry/Masonry.h>
#import "UIView+CPToImage.h"

@implementation TwoTextView

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
    [self addSubview:label];
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(@0);
    }];
    [label layoutIfNeeded];
    
    UIImage *image = [label cp_toImage];

    NSTextAttachment *attachment = [[NSTextAttachment alloc] init];
    attachment.bounds = CGRectMake(0, self.font.descender, label.frame.size.width, label.frame.size.height);
    attachment.image = image;
    NSMutableAttributedString *attr = [[NSAttributedString attributedStringWithAttachment:attachment] mutableCopy];
    [attr insertAttributedString:[[NSAttributedString alloc] initWithString:self.text] atIndex:0];
    [attr addAttributes:@{
        NSForegroundColorAttributeName: self.textColor,
        NSFontAttributeName: self.font
    } range:NSMakeRange(0, attr.length)];
    self.attributedText = attr;
    [label removeFromSuperview];
}

@end
