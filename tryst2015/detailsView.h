//
//  detailsView.h
//  tryst2015
//
//  Created by Robin Malhotra on 14/01/15.
//  Copyright (c) 2015 Robin's code kitchen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>
#define WIDTH_MARGIN 12
#define HEIGHT_MARGIN_TOP 95
#define HEIGHT_MARGIN_BOTTOM 60
@interface detailsView : UIView
@property (nonatomic,strong) UIView *mainView;
@property (nonatomic,strong) PFObject *data;
@end
