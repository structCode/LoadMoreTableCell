//
//  LoadMoreCell.m
//  LoadMoreTableCell
//
//  Created by Kenvin on 16/8/21.
//  Copyright © 2016年 上海方创金融股份服务有限公司. All rights reserved.
//

#import "LoadMoreCell.h"

@implementation LoadMoreCell

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}
- (IBAction)clickButton:(UIButton*)sender {
    sender.selected = !sender.selected;
    if (!sender.selected ==NO) {
        self.label.numberOfLines = 0;
    }else{
        self.label.numberOfLines = 5;
    }
    if (_expandCellBlock){
        _expandCellBlock();
    }
}
@end
