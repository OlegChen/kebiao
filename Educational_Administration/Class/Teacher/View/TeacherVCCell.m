//
//  TeacherVCCell.m
//  Educational_Administration
//
//  Created by Apple on 2018/5/19.
//  Copyright © 2018年 chen. All rights reserved.
//

#import "TeacherVCCell.h"

@interface TeacherVCCell()

@property (weak, nonatomic) IBOutlet UIView *bgView;

@end

@implementation TeacherVCCell

- (void)awakeFromNib {
    [super awakeFromNib];

    self.bgView.backgroundColor = [UIColor whiteColor];

    
    self.bgView.layer.shadowColor = [UIColor grayColor].CGColor;
    self.bgView.layer.shadowRadius = 3;
    self.bgView.layer.shadowOpacity = 0.3;
    self.bgView.layer.shadowOffset = CGSizeMake(0,0 );
    
    
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
