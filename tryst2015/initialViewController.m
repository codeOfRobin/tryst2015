//
//  initialViewController.m
//  tryst2015
//
//  Created by Robin Malhotra on 22/02/15.
//  Copyright (c) 2015 Robin's code kitchen. All rights reserved.
//

#import "initialViewController.h"
#import "AppDelegate.h"
@interface initialViewController ()

@end

@implementation initialViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.pager=[[UIPageControl alloc] initWithFrame:CGRectMake(0,0, 100, 10)];
    [self.pager setCenter:CGPointMake(CGRectGetWidth(self.view.frame)/2 , CGRectGetHeight([[UIScreen mainScreen] bounds])-30)];
    self.pager.numberOfPages=4;
    self.pager.currentPage=0;
    UIScrollView *scroll=[[UIScrollView alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    [scroll setBackgroundColor:[UIColor blackColor]];
    [scroll setContentSize:CGSizeMake(4*CGRectGetWidth([[UIScreen mainScreen] bounds]), CGRectGetHeight([[UIScreen mainScreen] bounds]))];
    [scroll setContentOffset:CGPointMake(0, 0)];
    [scroll setBouncesZoom:NO];
    self.automaticallyAdjustsScrollViewInsets = NO;
    [scroll setPagingEnabled:YES];
    for (int i=0; i<3; i++)
    {
        UIImageView *imView=[[UIImageView alloc]initWithFrame:CGRectMake(i*CGRectGetWidth([[UIScreen mainScreen] bounds])+10, 10, CGRectGetWidth([[UIScreen mainScreen] bounds])-20, CGRectGetHeight([[UIScreen mainScreen] bounds]))];
        [imView setImage:[UIImage imageNamed:[NSString stringWithFormat:@"group%d",i]]];
        [imView setContentMode:UIViewContentModeScaleAspectFit];
        [scroll addSubview:imView];
    }
    [scroll setDelegate:self];
    [self.view addSubview:scroll];
    [self.view addSubview:self.pager];
    UIButton *button=[[UIButton alloc] init];
    [button setFrame:CGRectMake(0, 0, 513/2, 101/2)];
    [button setImage:[UIImage imageNamed:@"unselectedStartButton"] forState:UIControlStateNormal];
    [button setImage:[UIImage imageNamed:@"selectedStartButton"] forState:UIControlStateHighlighted];
    [button setCenter:CGPointMake(3.5*CGRectGetWidth(self.view.frame), CGRectGetHeight(self.view.frame)/2)];
    [button addTarget:self action:@selector(touchButton:) forControlEvents:UIControlEventTouchUpInside];
    [scroll addSubview:button];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    int page = scrollView.contentOffset.x/scrollView.frame.size.width;
    self.pager.currentPage=page;
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
-(void)touchButton:(id)sender
{
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    UIStoryboard * myStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    UITabBarController * defaultViewController = [myStoryboard instantiateInitialViewController];
    [appDelegate.window setRootViewController:defaultViewController];
}

@end
