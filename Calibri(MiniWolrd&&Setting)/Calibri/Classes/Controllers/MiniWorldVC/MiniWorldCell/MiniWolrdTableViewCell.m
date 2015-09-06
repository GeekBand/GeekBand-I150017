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
    AppDelegate *appdelegate = [UIApplication sharedApplication].delegate;
    if ([[appdelegate.ifZanArray objectAtIndex:self.indexPath.row] isEqualToString:@"NO"]) {
        temp = [self.zanNumberLabel.text integerValue];
        ++ temp;
        self.zanNumberLabel.text = [NSString stringWithFormat:@"%ld",(long)temp];
        self.zanButton.alpha = 1;
        UIImage *image = [UIImage imageNamed:@"get"];
        [self.zanButton setBackgroundImage:image forState:UIControlStateNormal];
        NSLog(@"zan");
        
        //从全局变量取自身cell的值，加一后以新值取代
        NSNumber *changeNumber = [appdelegate.zanNumberArray objectAtIndex:self.indexPath.row];
        NSInteger changeValue = [changeNumber integerValue];
        ++changeValue;
        changeNumber = [NSNumber numberWithInteger:changeValue];
        [appdelegate.zanNumberArray replaceObjectAtIndex:self.indexPath.row withObject:changeNumber];
        //从全局变量取值自身cell的ifZan值，若原为NO则改成YES
        [appdelegate.ifZanArray objectAtIndex:self.indexPath.row];
        NSString *tempString = @"YES";
        [appdelegate.ifZanArray replaceObjectAtIndex:self.indexPath.row withObject:tempString];
        
    }else{
        temp = [self.zanNumberLabel.text integerValue];
        -- temp;
        self.zanNumberLabel.text = [NSString stringWithFormat:@"%ld",(long)temp];
        self.zanButton.alpha = 0.2;
        UIImage *image = [UIImage imageNamed:@"unget"];
        [self.zanButton setBackgroundImage:image forState:UIControlStateNormal];
        NSLog(@"Unzan");
        
        //从全局变量取自身cell的值，减一后以新值取代
        NSNumber *changeNumber = [appdelegate.zanNumberArray objectAtIndex:self.indexPath.row];
        NSInteger changeValue = [changeNumber integerValue];
        --changeValue;
        changeNumber = [NSNumber numberWithInteger:changeValue];
        [appdelegate.zanNumberArray replaceObjectAtIndex:self.indexPath.row withObject:changeNumber];
        //从全局变量取值自身cell的ifZan值，若原为YES则改成NO
        [appdelegate.ifZanArray objectAtIndex:self.indexPath.row];
        NSString *tempString = @"NO";
        [appdelegate.ifZanArray replaceObjectAtIndex:self.indexPath.row withObject:tempString];

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
