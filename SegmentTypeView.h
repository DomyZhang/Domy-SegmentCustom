//
//  SegmentTypeView.h
//  GuoranCommunity
//
//  Created by yrtt on 16/12/6.
//  Copyright © 2016年 vector. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SegmentTypeView : UIView

@property (nonatomic) NSInteger currentIndex;
// block 回调
@property (copy, nonatomic) void (^selectedIndex)(NSString *title,NSInteger index);

// 初始化
- (instancetype)initWithFrame:(CGRect)frame items:(NSArray<NSString *> *)items;

@end
