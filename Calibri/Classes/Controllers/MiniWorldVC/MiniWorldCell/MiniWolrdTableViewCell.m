//
//  MiniWolrdTableViewCell.m
//  Calibri
//
//  Created by SeaHub on 15/9/4.
//  Copyright (c) 2015年 CalibriDevelop. All rights reserved.
//

#import "MiniWolrdTableViewCell.h"
#import "AppDelegate.h"

@implementation MiniWolrdTableViewCell


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        NSArray *views = [[NSBundle mainBundle] loadNibNamed:@"MiniWorldTableViewCell"
                                                       owner:nil
                                                     options:nil];
        self = [views firstObject];
    }
    [self headPortraitButtonConstruct];
    [self belowImageViewConstruct];
    [self belowButtonConstruct];
    [self zanConstruct];
    [self.zanButton addTarget:self action:@selector(zanButtonCliked)
             forControlEvents:UIControlEventTouchUpInside];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    
    
    return self;
}

#pragma mark - constructView
- (void)headPortraitButtonConstruct{
    UIColor *color = [[UIColor alloc]initWithRed:140/255.0 green:200/255.0 blue:110/255.0 alpha:1];
    self.headPortraitButton.layer.cornerRadius = self.headPortraitButton.bounds.size.width * 0.5;
    self.headPortraitButton.layer.borderWidth = 1.5;
    self.headPortraitButton.layer.borderColor = color.CGColor;
    [self.headPortraitButton addTarget:self
                                action:@selector(headPortraitButtonCliked)
                      forControlEvents:UIControlEventTouchUpInside];
}

-(void)zanConstruct{
    if (!self.ifZan) {
        self.zanButton.alpha = 0.2;
        UIImage *image = [UIImage imageNamed:@"unget"];
        [self.zanButton setBackgroundImage:image forState:UIControlStateNormal];
    }else{
        self.zanButton.alpha = 1;
        UIImage *image = [UIImage imageNamed:@"get"];
        [self.zanButton setBackgroundImage:image forState:UIControlStateNormal];
    }

}

- (void)belowImageViewConstruct{
    UIColor *color = [[UIColor alloc]initWithRed:140/255.0 green:200/255.0 blue:110/255.0 alpha:1];
    [self.belowImageView setBackgroundColor:color];
}

- (void)belowButtonConstruct{
    [self.belowButton setBackgroundColor:[UIColor clearColor]];
    [self.belowButton addTarget:self
                         action:@selector(belowButtonCliked)
               forControlEvents:UIControlEventTouchUpInside];
}


#pragma mark - ButtonMethod
- (void)belowButtonCliked{
    NSLog(@"进入内容详情页");
}

- (void)headPortraitButtonCliked{
    NSLog(@"进入个人详情页");
}

- (void)zanButtonCliked{
    NSInteger temp;
    if (!self.ifZan) {
        self.ifZan = YES;
        temp = [self.zanNumberLabel.text integerValue];
        ++ temp;
        self.zanNumberLabel.text = [NSString stringWithFormat:@"%ld",(long)temp];
        self.zanButton.alpha = 1;
        UIImage *image = [UIImage imageNamed:@"get"];
        [self.zanButton setBackgroundImage:image forState:UIControlStateNormal];
        NSLog(@"zan");
    }else{
        self.ifZan = NO;
        temp = [self.zanNumberLabel.text integerValue];
        -- temp;
        self.zanNumberLabel.text = [NSString stringWithFormat:@"%ld",(long)temp];
        self.zanButton.alpha = 0.2;
        UIImage *image = [UIImage imageNamed:@"unget"];
        [self.zanButton setBackgroundImage:image forState:UIControlStateNormal];
        NSLog(@"Unzan");
    }
    
}

#pragma mark - else
- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

@end
