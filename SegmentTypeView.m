//
//  SegmentTypeView.m
//  GuoranCommunity
//
//  Created by yrtt on 16/12/6.
//  Copyright © 2016年 vector. All rights reserved.
//

#import "SegmentTypeView.h"

@interface SegmentTypeView () <UIScrollViewDelegate>

@property (strong, nonatomic) NSArray *items;
@property (strong, nonatomic) UIView  *progress;
@property (strong, nonatomic) UIScrollView *scrollView;

@end

@implementation SegmentTypeView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame items:(NSArray<NSString *> *)items {
    self = [super initWithFrame:frame];
    if (self) {
        
        self.items = items;
        [self setSubviews];
    }
    
    return self;
}

#define textWidth     kScreenWidth/320*85.f
#define buttonTag     1234

- (void)setSubviews {
    
    self.scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.frame), CGRectGetHeight(self.frame))];
    self.scrollView.pagingEnabled = NO;
    self.scrollView.showsVerticalScrollIndicator = NO;
    self.scrollView.showsHorizontalScrollIndicator = NO;
    self.scrollView.contentSize = CGSizeMake(kScreenWidth, 0);
    self.scrollView.delegate = self;
    [self addSubview:self.scrollView];
    
    self.backgroundColor = [UIColor whiteColor];
    CGFloat widthX = 5;
    if (self.items && self.items.count != 0) {
        for (int i=0; i<self.items.count; i++) {
            CGRect frame = CGRectMake(textWidth*i+((i*2)+1)*widthX, 0, textWidth, self.height-5);
            UIButton *button = [self createSubview:frame title:self.items[i][@"title"]];
            if (i == 0) {
                [button setTitleColor:TabBarTitleSelectedColor forState:UIControlStateNormal];
            }
            button.tag = buttonTag+[self.items[i][@"id"] integerValue];
            [self.scrollView addSubview:button];
        }
        
        self.progress = [[UIView alloc] initWithFrame:CGRectMake(widthX, self.height-5, textWidth, 3)];
        self.progress.backgroundColor = TabBarTitleSelectedColor;
        [self.scrollView addSubview:self.progress];
    }
    
    self.scrollView.contentSize = CGSizeMake(textWidth*(self.items.count+2), 0);
}


- (UIButton *)createSubview:(CGRect)frame title:(NSString *)title {
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = frame;
    [button setTitle:title forState:UIControlStateNormal];
    button.titleLabel.font = [UIFont systemFontOfSize:16];
    [button setTitleColor:[UIColor darkTextColor] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(clickButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    
    return button;
}

- (void)clickButtonAction:(UIButton *)sender {
    
    [sender setTitleColor:TabBarTitleSelectedColor forState:UIControlStateNormal];
    for (UIView *view in sender.superview.subviews) {
        if ([view isKindOfClass:[UIButton class]]) {
            UIButton *button = (UIButton *)view;
            if (button.tag != sender.tag) {
                [button setTitleColor:[UIColor darkTextColor] forState:UIControlStateNormal];
            }
        }
    }
    
    [UIView animateWithDuration:0.3 animations:^{
        self.progress.left = sender.frame.origin.x;
        NSLog(@"%f",self.scrollView.contentSize.width);
        NSLog(@"%f",sender.right);

        if ((self.scrollView.contentSize.width - sender.right) < kScreenWidth/2) {
            
        }
        else if (sender.left > kScreenWidth/2) {
            self.scrollView.contentOffset = CGPointMake(sender.left-kScreenWidth/2+sender.width/2, 0);
        }
    }];
    
    if (self.selectedIndex) {
        self.selectedIndex(sender.currentTitle,sender.tag-buttonTag);
    }
}

- (void)setCurrentIndex:(NSInteger)currentIndex {
    
    _currentIndex = currentIndex;
    UIButton *sender = (UIButton *)[self viewWithTag:buttonTag+currentIndex];
    [self clickButtonAction:sender];
}

@end
