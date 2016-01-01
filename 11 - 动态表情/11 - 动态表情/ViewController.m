//
//  ViewController.m
//  11 - 动态表情
//
//  Created by 于传峰 on 15/12/28.
//  Copyright © 2015年 于传峰. All rights reserved.
//

#import "ViewController.h"
#import "UIImage+GIF.h"
#import "CFTextModel.h"
#import "CFTextView.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet CFTextView *textView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    CFTextModel* model = [[CFTextModel alloc] init];
    model.contentString = @"/咸蛋超人“没人在乎你怎样在深夜痛哭，/飞翔/飞翔/飞翔也没人在乎你辗转反侧的要熬几个秋。外人只看结果，/奥特曼自己独撑过程。/点头等你明白了这个道理，便不会再在人前矫情，/我撞四处诉说以求宽慰。/烧烤”当你知道了许多真实、虚假的东西，/咸蛋超人也就没有那么多酸情了。你越来越沉默，越来越不想说。/心烦";
    self.textView.attributedText = model.attributedString;
}


@end
