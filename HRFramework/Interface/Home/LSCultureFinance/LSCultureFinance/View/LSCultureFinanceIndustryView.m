
//
//  LSCultureFinanceIndustryView.m
//  LSZH
//
//  Created by risenb-ios5 on 16/6/2.
//  Copyright © 2016年 obgniyum. All rights reserved.
//

#import "LSCultureFinanceIndustryView.h"

#import "LSCultureFinanceTopCell.h"
#define CELL_CultureFinanceTop  @"CultureFinanceTopCell"

@interface  LSCultureFinanceIndustryView()

@property (strong, nonatomic) IBOutlet UITableView *myCustomTableView;
@property (strong, nonatomic) NSMutableArray *dataSourceArr;

@end


@implementation LSCultureFinanceIndustryView



#pragma mark @ UITableViewDataSource && UITableViewDelegate @
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 5;
}


//返回cell高度
- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath {
    self.myCustomTableView.estimatedRowHeight = self.myCustomTableView.rowHeight;
    self.myCustomTableView.rowHeight = UITableViewAutomaticDimension;
    return self.myCustomTableView.rowHeight;
}




-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    LSCultureFinanceTopCell *cell = [self.myCustomTableView dequeueReusableCellWithIdentifier:CELL_CultureFinanceTop forIndexPath:indexPath];
    
        //去掉分割线
    self.myCustomTableView.separatorStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
}



/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
