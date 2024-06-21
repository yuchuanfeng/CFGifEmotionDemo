//
//  UIView+CPToImage.m
//  InputView
//
//  Created by yuchuanfeng on 2024/6/21.
//

#import "UIView+CPToImage.h"

@implementation UIView (CPToImage)
- (UIImage *)cp_toImage {
    UIGraphicsImageRenderer *imageRenderer = [[UIGraphicsImageRenderer alloc] initWithBounds:self.bounds];
    UIImage *image = [imageRenderer imageWithActions:^(UIGraphicsImageRendererContext * _Nonnull rendererContext) {
        [self.layer renderInContext:rendererContext.CGContext];
    }];
    return image;
}
@end
