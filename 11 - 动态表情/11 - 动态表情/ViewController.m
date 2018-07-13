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
#import "CFTableViewCell.h"

@interface ViewController ()
@property (nonatomic, strong) NSMutableArray *models;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    self.tableView.rowHeight = UITableViewAutomaticDimension;
    
    self.models = [[NSMutableArray alloc] init];
    for ( int i = 0; i<100; i++ )
    {
        CFTextModel* model = [[CFTextModel alloc] init];
        if (i % 2)
        {
           model.contentString = @"/咸蛋超人“没人在乎你怎样在深夜痛哭，/飞翔/网络图片2/飞翔也没人在乎你辗转反侧的要熬几个这是个网络下载图片这是个网络下载图片/网络图片1这是个网络下载图片这是个网络下载图片这是个网络下载图片秋。/我撞";
        }else{
            model.contentString = @"/点头等你明白了这个道理，这是个网络下载图片/网络图片1便不会再在人前矫情，/我撞四处诉说以求宽慰。/烧烤”当你知道了许多真实、虚假的东西，这是个网络下载图片这是个网络下载图片/网络图片2也就没有那么多酸情了。你越来越沉默，越来越不想说。/心烦";
            [model.attributedString addAttribute:NSForegroundColorAttributeName value:[UIColor blueColor] range:NSMakeRange(0, model.attributedString.length)];
        }
        [self.models addObject:model];
    }
//    self.textView.attributedText = model.attributedString;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 100;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CFTableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    CFTextModel* model = self.models[indexPath.row];
    cell.textView.attributedText = model.attributedString;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CFTextModel* model = self.models[indexPath.row];
    return model.height;
}

//- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    return 40;
//}


@end
