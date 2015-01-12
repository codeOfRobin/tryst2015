//
//  eventsViewController.h
//  tryst2015
//
//  Created by Robin Malhotra on 12/01/15.
//  Copyright (c) 2015 Robin's code kitchen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AsyncImageView.h"

@interface eventsViewController : UIViewController<UIScrollViewDelegate,UITableViewDataSource,UITableViewDelegate>
@property (nonatomic,strong) AsyncImageView *image;
@property (nonatomic,strong) UIScrollView *scroll;
@property (nonatomic,strong) UITableView *eventTable;
@property (nonatomic,strong) NSMutableArray *quizEvents;
@property (nonatomic,strong) NSMutableArray *workshopEvents;
@property (nonatomic,strong) NSMutableArray *lectureEvents;
@property (nonatomic,strong) UISegmentedControl *segmentCategory;
@end
