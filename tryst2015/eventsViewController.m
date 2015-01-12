//
//  eventsViewController.m
//  tryst2015
//
//  Created by Robin Malhotra on 12/01/15.
//  Copyright (c) 2015 Robin's code kitchen. All rights reserved.
//

#import "eventsViewController.h"
#import <Parse/Parse.h>
#define TABLEVIEW_FIX 200
@interface eventsViewController ()
@end
@implementation eventsViewController
@synthesize scroll;
-(void)viewWillAppear:(BOOL)animated
{
    [self performSelector:@selector(retrieveFromParse)];
}

-(void)retrieveFromParse
{
    PFQuery *query=[PFQuery queryWithClassName:@"event"];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        self.events=[objects mutableCopy];
        NSLog(@"%@",self.events);
    }];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    scroll=[[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.frame), 1000)];
    [self.view addSubview:scroll];
    [scroll setBounces:YES];
    self.image=[[AsyncImageView alloc] initWithFrame:CGRectMake(0, -TABLEVIEW_FIX, CGRectGetWidth(self.view.frame),2*TABLEVIEW_FIX)];
    [self.image setContentMode:UIViewContentModeScaleToFill];
    [self.image setImageURL:[NSURL URLWithString:@"https://lh5.googleusercontent.com/-JA86V17JQyE/AAAAAAAAAAI/AAAAAAAAGcY/QBFOpGZAxwo/photo.jpg"]];
    [scroll addSubview:self.image];
    [scroll setContentSize:CGSizeMake(self.view.frame.size.width, 1000)];
    [scroll setDelegate:self];
    [self.navigationController.navigationBar setBackgroundColor:[UIColor blackColor]];
    
    self.eventTable=[[UITableView alloc] initWithFrame:CGRectMake(0,CGRectGetMaxY(self.image.frame),CGRectGetWidth(self.view.frame),1000)];
    self.eventTable.delegate=self;
    // Do any additional setup after loading the view.
    
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    NSLog(@"%f",scrollView.contentOffset.y);
    self.image.contentMode = UIViewContentModeScaleAspectFill;
    self.image.clipsToBounds = YES;
    if (scrollView.contentOffset.y<0)
    {
//        [self.image setContentScaleFactor:-scrollView.contentOffset.y/100];
//        [self.image setTransform:CGAffineTransformMakeScale(-scrollView.contentOffset.y/100, -scrollView.contentOffset.y/100)];
        [self.image setFrame:CGRectMake(scrollView.contentOffset.y, scrollView.contentOffset.y, self.view.frame.size.width-2*scrollView.contentOffset.y, TABLEVIEW_FIX-scrollView.contentOffset.y)];
    }
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
#pragma mark Table View 

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.events.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 100;
}




@end
