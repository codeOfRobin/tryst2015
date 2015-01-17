//
//  mapsViewController.h
//  tryst2015
//
//  Created by Robin Malhotra on 18/01/15.
//  Copyright (c) 2015 Robin's code kitchen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface mapsViewController : UIViewController<UIScrollViewDelegate>
@property (nonatomic, strong) IBOutlet UIScrollView *scrollView;
@property (nonatomic, strong) IBOutlet UIPageControl *pageControl;
@property (nonatomic, strong) NSMutableArray *pageImages;
@property (nonatomic, strong) NSMutableArray *pageViews;

- (void)loadVisiblePages;
- (void)loadPage:(NSInteger)page;
- (void)purgePage:(NSInteger)page;
@end
