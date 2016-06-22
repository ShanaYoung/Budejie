//
//  SNRecmmendCategoryCell.m
//  百思不得姐练习
//
//  Created by qianfeng on 16/5/17.
//  Copyright © 2016年 Shana. All rights reserved.
//

#import "SNRecmmendCategoryCell.h"
#import "SNRecomendCategory.h"

@interface SNRecmmendCategoryCell ()
/** 选中时显示的指示器控件 */
@property (weak, nonatomic) IBOutlet UIView *selectedIndicator;

@end

@implementation SNRecmmendCategoryCell

- (void)awakeFromNib {
    self.backgroundColor=SNRGBColor(244, 244, 244);
    self.selectedIndicator.backgroundColor=SNRGBColor(219, 21, 26);
    
    //当cell的selection为none时，即使cell被选中了，内部的子控件也不会进入高亮状态
}

-(void)setCategory:(SNRecomendCategory *)category
{
    _category=category;
    self.textLabel.text=category.name;
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    
    //重新调整内部textLabel的frame
    self.textLabel.y=2;
    self.textLabel.height=self.contentView.height-2*self.textLabel.y;
}

/** 可以在这个方法中监听cell的选中和取消选中 */
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    //如果这个cell被选中，则显示左侧的view
    self.selectedIndicator.hidden=!selected;
    //如果这cell被选中，则自带的textLabel的颜色会改变，改变为与左侧的indicator一致
    self.textLabel.textColor=selected?self.selectedIndicator.backgroundColor:SNRGBColor(78, 78, 78);
}

@end
