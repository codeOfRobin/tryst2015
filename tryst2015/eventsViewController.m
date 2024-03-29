//
//  eventsViewController.m
//  tryst2015
//
//  Created by Robin Malhotra on 12/01/15.
//  Copyright (c) 2015 Robin's code kitchen. All rights reserved.
//

#import "eventsViewController.h"
#import <Parse/Parse.h>
#import <MGSwipeTableCell/MGSwipeTableCell.h>
#import <MGSwipeButton.h>
#import <SystemConfiguration/SystemConfiguration.h>
#import "EventCell.h"
#import "detailsView.h"
#define TABLEVIEW_FIX 200
@interface eventsViewController ()
@end
@implementation eventsViewController
@synthesize scroll;
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
   
    

}
- (BOOL)isConnectionAvailable
{
    NSURL *url=[NSURL URLWithString:@"http://www.google.com"];
    NSMutableURLRequest *request=[NSMutableURLRequest requestWithURL:url];
    [request setHTTPMethod:@"HEAD"];
    NSHTTPURLResponse *response;
    [NSURLConnection sendSynchronousRequest:request returningResponse:&response error: NULL];
    
    return ([response statusCode]==200)?YES:NO;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.segmentCategory=[[UISegmentedControl alloc]initWithItems:@[@"EVENTS",@"WORKSHOPS",@"LECTURES"]];
    [self.segmentCategory setCenter:CGPointMake(self.navigationController.navigationBar.center.x, self.navigationController.navigationBar.frame.size.height/2)];
    [self.navigationController.navigationBar addSubview:self.segmentCategory];
    [self.segmentCategory addTarget:self action:@selector(MySegmentControlAction:) forControlEvents: UIControlEventAllEvents];
    self.segmentCategory.selectedSegmentIndex = 0; 
    self.navigationController.navigationBar.barStyle=UIBarStyleBlackTranslucent;
    self.navigationController.navigationBar.tintColor=[UIColor whiteColor];
    self.navigationController.navigationBar.translucent = YES;
    
    self.image=[[AsyncImageView alloc] initWithFrame:CGRectMake(0, -TABLEVIEW_FIX, CGRectGetWidth(self.view.frame),2*TABLEVIEW_FIX)];
    [self.image setContentMode:UIViewContentModeScaleToFill];
    [self.image setImage:[UIImage imageNamed:@"Home"]];
    [self.image setUserInteractionEnabled:NO];
    [self.view addSubview:self.image];
    
    
    [self.navigationController.navigationBar setBackgroundColor:[UIColor blackColor]];
    
    self.eventTable=[[UITableView alloc] initWithFrame:CGRectMake(0,CGRectGetMaxY(self.image.frame),CGRectGetWidth(self.view.frame),self.view.frame.size.height-TABLEVIEW_FIX)];
    [self.eventTable registerClass:[EventCell class] forCellReuseIdentifier:@"cell"];
    self.eventTable.delegate=self;
    self.eventTable.dataSource=self;
    self.eventTable.separatorStyle=UITableViewCellSeparatorStyleNone;
    self.eventTable.backgroundColor=[UIColor blackColor];
        [self.view addSubview:self.eventTable];
    // Do any additional setup after loading the view.
    
    
    PFQuery *query=[PFQuery queryWithClassName:@"event"];
    if (self.segmentCategory.selectedSegmentIndex==0)
    {
        [query whereKey:@"category" equalTo:@"events"];
        if (![self isConnectionAvailable])
        {
            [query fromLocalDatastore];
            [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
                if(!error)
                {
                    NSLog(@"local thingie complete");
                    self.quizEvents=[objects mutableCopy];
                    [self.eventTable reloadData];
                    
                }
            }];
        }
        else
        {
            
            [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
                self.quizEvents=[objects mutableCopy];
                NSLog(@"%@",self.quizEvents);
                [PFObject pinAllInBackground:objects];
                [self.eventTable reloadData];
                
            }];
            
        }
    }
    
    
    
}


-(void)MySegmentControlAction:(id)sender
{
    PFQuery *query=[PFQuery queryWithClassName:@"event"];
    if (self.segmentCategory.selectedSegmentIndex==0)
    {
        [query whereKey:@"category" equalTo:@"events"];
        if (![self isConnectionAvailable])
        {
            [query fromLocalDatastore];
            [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
                if(!error)
                {
                    NSLog(@"local thingie complete");
                    self.quizEvents=[objects mutableCopy];
                    [self.eventTable reloadData];

                }
            }];
        }
        else
        {

        [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
            self.quizEvents=[objects mutableCopy];
            NSLog(@"%@",self.quizEvents);
            [PFObject pinAllInBackground:objects];
            [self.eventTable reloadData];
            
        }];
        
        }
    }
    
    else if (self.segmentCategory.selectedSegmentIndex==1)
    {
        [query whereKey:@"category" equalTo:@"workshop"];
        if (![self isConnectionAvailable])
        {
            [query fromLocalDatastore];
            [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
                if(!error)
                {
                    NSLog(@"local thingie complete");
                    self.workshopEvents=[objects mutableCopy];
                    [self.eventTable reloadData];

                }
            }];
        }
        
        else
        {
        [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
            self.workshopEvents=[objects mutableCopy];
            NSLog(@"%@",self.workshopEvents);
            [PFObject pinAllInBackground:objects];
            [self.eventTable reloadData];
        
        }];
        }
    }
    
    else if (self.segmentCategory.selectedSegmentIndex==2)
    {
        [query whereKey:@"category" equalTo:@"lecture"];
        if (![self isConnectionAvailable])
        {
            [query fromLocalDatastore];
            [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
                if(!error)
                {
                    NSLog(@"local thingie complete");
                    self.lectureEvents=[objects mutableCopy];
                    [self.eventTable reloadData];

                }
            }];
        }
        
        else
        {
        [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
            self.lectureEvents=[objects mutableCopy];
            NSLog(@"%@",self.lectureEvents);
            [PFObject pinAllInBackground:objects];
            [self.eventTable reloadData];
            
        }];
        }

    }
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
    if (self.segmentCategory.selectedSegmentIndex==0)
    {
        return self.quizEvents.count;
    }
    else if (self.segmentCategory.selectedSegmentIndex==1)
    {
        return self.workshopEvents.count;
    }
    return self.lectureEvents.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 100;
}
-(NSString *)getUTCFormateDate:(NSDate *)localDate
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    NSTimeZone *timeZone = [NSTimeZone timeZoneWithName:@"UTC"];
    [dateFormatter setTimeZone:timeZone];
    [dateFormatter setDateStyle:NSDateFormatterLongStyle];
    [dateFormatter setTimeStyle:NSDateFormatterShortStyle];
    NSString *dateString = [dateFormatter stringFromDate:localDate];
    return dateString;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    EventCell *cell=[tableView dequeueReusableCellWithIdentifier:@"cell"forIndexPath:indexPath];
    
    if (cell==nil)
    {
        cell = [[EventCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    
    [cell setNeedsLayout];
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    if (self.segmentCategory.selectedSegmentIndex==0)
    {
        cell.textLabel.text=[[self.quizEvents objectAtIndex:indexPath.row] objectForKey:@"name"];
        NSString *x=[self getUTCFormateDate:[[self.quizEvents objectAtIndex:indexPath.row] objectForKey:@"startingTime"]];
        [cell.subtitleLabel setText:x];
    }
    else if (self.segmentCategory.selectedSegmentIndex==1)
    {
        cell.textLabel.text=[[self.workshopEvents objectAtIndex:indexPath.row] objectForKey:@"name"];
        NSString *x=[self getUTCFormateDate:[[self.workshopEvents objectAtIndex:indexPath.row] objectForKey:@"startingTime"]];
        [cell.subtitleLabel setText:x];
    }
    else if (self.segmentCategory.selectedSegmentIndex==2)
    {
        cell.textLabel.text=[[self.lectureEvents objectAtIndex:indexPath.row] objectForKey:@"name"];
        
        NSString *x=[self getUTCFormateDate:[[self.lectureEvents objectAtIndex:indexPath.row] objectForKey:@"startingTime"]];
        [cell.subtitleLabel setText:x];
    }
    
    cell.leftButtons = @[[MGSwipeButton buttonWithTitle:@"favorite" backgroundColor:[UIColor grayColor] callback:^BOOL(MGSwipeTableCell *sender) {
        NSLog(@"asdhjkfn");
        return TRUE;
    }]];
    
    switch (self.segmentCategory.selectedSegmentIndex)
    {
        case 0:
            [cell.cellImage setImage:[UIImage imageNamed:@"event0"]];
            break;
        case 1:
            [cell.cellImage setImage:[UIImage imageNamed:@"event1"]];
            break;
        case 2:
            [cell.cellImage setImage:[UIImage imageNamed:@"event2"]];
            break;

            
        default:
            break;
    }
    cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
    cell.leftExpansion.fillOnTrigger = YES;
    cell.leftSwipeSettings.transition = MGSwipeTransitionDrag;
    cell.leftExpansion.buttonIndex=0;
    cell.contentView.backgroundColor=[UIColor blackColor];
    cell.backgroundColor=[UIColor blackColor];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    PFObject *data;
    switch (self.segmentCategory.selectedSegmentIndex)
    {
        case 0:
            data=[self.quizEvents objectAtIndex:indexPath.row];
            break;
        case 1:
            data=[self.workshopEvents objectAtIndex:indexPath.row];
            break;
        case 2:
            data=[self.lectureEvents objectAtIndex:indexPath.row];
            break;
            
        default:
            break;
    }
    
    detailsView *view2=[[detailsView alloc] initWithFrame:[[UIScreen mainScreen]bounds]andData:data];

    
    [self.view addSubview:view2];
}

@end
