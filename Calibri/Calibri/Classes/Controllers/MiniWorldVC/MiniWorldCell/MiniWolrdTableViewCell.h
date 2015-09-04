//
//  MiniWolrdTableViewCell.h
//  Calibri
//
//  Created by SeaHub on 15/9/4.
//  Copyright (c) 2015年 CalibriDevelop. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MiniWolrdTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIButton *headPortraitButton;
@property (weak, nonatomic) IBOutlet UIImageView *belowImageView;
@property (weak, nonatomic) IBOutlet UIButton *belowButton;
@property (weak, nonatomic) IBOutlet UIButton *zanButton;
@property (weak, nonatomic) IBOutlet UILabel *zanNumberLabel;
@property (nonatomic) BOOL ifZan;//默认为NO

@end
