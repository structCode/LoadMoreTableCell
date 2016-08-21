//
//  LoadMoreCell.h
//  LoadMoreTableCell
//
//  Created by Kenvin on 16/8/21.
//  Copyright © 2016年 上海方创金融股份服务有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^ExpandCellBlock) (void);

static NSString *const LoadMoreCellIdentifier = @"LoadMoreCellIdentifier";
@interface LoadMoreCell : UITableViewCell

- (IBAction)clickButton:(id)sender;
@property (nonatomic,copy ) ExpandCellBlock expandCellBlock;
@property (weak, nonatomic) IBOutlet UILabel *label;
@property (weak, nonatomic) IBOutlet UIButton *button;
@end
