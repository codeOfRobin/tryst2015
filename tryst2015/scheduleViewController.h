//
//  scheduleViewController.h
//  tryst2015
//
//  Created by Robin Malhotra on 27/01/15.
//  Copyright (c) 2015 Robin's code kitchen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <V8HorizontalPickerView.h>
@interface scheduleViewController : UIViewController<V8HorizontalPickerViewDataSource,V8HorizontalPickerViewDelegate,V8HorizontalPickerElementState,UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong) NSMutableArray *morningEvents;
@property (nonatomic,strong) NSMutableArray *afternoonEvents;
@property (nonatomic,strong) NSMutableArray *eveningEvents;
@property (nonatomic,strong) UITableView *schedule;
@property (nonatomic) NSInteger selectedIndex;
@end
