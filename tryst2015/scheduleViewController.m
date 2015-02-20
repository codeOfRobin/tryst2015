//
//  scheduleViewController.m
//  tryst2015
//
//  Created by Robin Malhotra on 27/01/15.
//  Copyright (c) 2015 Robin's code kitchen. All rights reserved.
//

#import "scheduleViewController.h"
#import "EventCell.h"
#import <Parse/Parse.h>
@interface scheduleViewController ()
@property(nonatomic,strong) NSMutableArray *strings;
@property (nonatomic,strong) V8HorizontalPickerView *picker;
@end

@implementation scheduleViewController

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.strings=[[NSMutableArray alloc]init];
    for (int i=0; i<4; i++)
    {
        [self.strings addObject:[NSString stringWithFormat:@" asdkhbk%d",i]];
    }
    
    self.selectedIndex=0;
    _picker=[[V8HorizontalPickerView alloc]initWithFrame:CGRectMake(0, self.navigationController.navigationBar.frame.size.height, self.view.frame.size.width, 158)];
    [_picker setDataSource:self];
    [_picker setDelegate:self];
    [self.view addSubview:_picker];
    _picker.backgroundColor   = [UIColor blackColor];
    _picker.selectionPoint = CGPointMake(_picker.frame.origin.x, 0);
    _picker.elementFont = [UIFont boldSystemFontOfSize:14.0f];
    [self.view addSubview:_picker];

    
    self.schedule=[[UITableView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(_picker.frame), self.view.frame.size.width, CGRectGetHeight(self.view.frame)-CGRectGetHeight(_picker.frame)-self.tabBarController.tabBar.frame.size.height)];
    [self.schedule setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    [self.schedule setDataSource:self];
    [self.schedule setDelegate:self];
    [self.schedule setBackgroundColor:[UIColor blackColor]];
    [self.schedule registerClass:[EventCell class] forCellReuseIdentifier:@"cell"];

    [self.view addSubview:self.schedule];
    // Do any additional setup after loading the view.
}

#pragma mark tableView
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 100;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section==0)
    {
        return [self.morningEvents count];
    }
    else if (section==1)
    {
        return [self.afternoonEvents count];
    }
    else
    {
        return [self.eveningEvents count];
    }
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
    if (indexPath.section==0)
    {
        cell.textLabel.text=[[self.morningEvents objectAtIndex:indexPath.row] objectForKey:@"name"];
        NSString *x=[self getUTCFormateDate:[[self.morningEvents objectAtIndex:indexPath.row] objectForKey:@"startingTime"]];
        [cell.subtitleLabel setText:x];
    }
    if (indexPath.section==1)
    {
        cell.textLabel.text=[[self.afternoonEvents objectAtIndex:indexPath.row] objectForKey:@"name"];
        NSString *x=[self getUTCFormateDate:[[self.afternoonEvents objectAtIndex:indexPath.row] objectForKey:@"startingTime"]];
        [cell.subtitleLabel setText:x];
    }
    if (indexPath.section==2)
    {
        cell.textLabel.text=[[self.eveningEvents objectAtIndex:indexPath.row] objectForKey:@"name"];
        NSString *x=[self getUTCFormateDate:[[self.eveningEvents objectAtIndex:indexPath.row] objectForKey:@"startingTime"]];
        [cell.subtitleLabel setText:x];
    }
    [cell.cellImage setImage:[UIImage imageNamed:@"Home"]];
    cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
    cell.contentView.backgroundColor=[UIColor blackColor];
    cell.backgroundColor=[UIColor blackColor];
    return cell;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


//- (NSString *)horizontalPickerView:(V8HorizontalPickerView *)picker titleForElementAtIndex:(NSInteger)index
//{
//    return [self.strings objectAtIndex:index];
//}

- (NSInteger)numberOfElementsInHorizontalPickerView:(V8HorizontalPickerView *)picker {
    return [self.strings count];
}


- (NSInteger) horizontalPickerView:(V8HorizontalPickerView *)picker widthForElementAtIndex:(NSInteger)index
{
    return 145;
}



-(UIView *)horizontalPickerView:(V8HorizontalPickerView *)picker viewForElementAtIndex:(NSInteger)index
{
    UIImageView *view=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 145, 100)];
    [view setContentMode:UIViewContentModeScaleAspectFit];
    switch (index)
    {
        case 0:
            [view setImage:[UIImage imageNamed:@"Feb27"]];
            break;
        case 1:
            [view setImage:[UIImage imageNamed:@"Feb28"]];
            break;
        case 2:
            [view setImage:[UIImage imageNamed:@"Mar01"]];
            break;
        case 3:
            [view setImage:[UIImage imageNamed:@"Mar02"]];
            break;
        
            
        default:
            break;
    }
    return view;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UILabel *label=[[UILabel alloc] initWithFrame:CGRectMake(0,0, self.view.frame.size.width, 35)];
    if (section==0)
    {
        [label setText:@"MORNING"];
        [label setTextColor:[UIColor colorWithRed:28.0/255 green:164.0/255 blue:226.0/255 alpha:1]];
        [label setBackgroundColor:[UIColor colorWithRed:3.0/255 green:24.0/255 blue:33.0/255 alpha:1]];
    }
    else if (section==1)
    {
        [label setText:@"AFTERNOON"];
        [label setTextColor:[UIColor colorWithRed:255.0/255 green:178.0/255 blue:85.0/255 alpha:1]];
        [label setBackgroundColor:[UIColor colorWithRed:38.0/255 green:21.0/255 blue:4.0/255 alpha:1]];
    }
    else if (section==2)
    {
        [label setText:@"EVENING"];
        [label setTextColor:[UIColor redColor]];
        [label setBackgroundColor:[UIColor colorWithRed:170.0/255 green:21.0/255 blue:4.0/255 alpha:0.3]];
    }
    [label setFont:[UIFont fontWithName:@"DIN" size:18]];
    return label;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 35.0f;
}

- (void)horizontalPickerView:(V8HorizontalPickerView *)picker didSelectElementAtIndex:(NSInteger)index
{
    self.selectedIndex=index;
    PFQuery *query = [PFQuery queryWithClassName:@"event"];
    NSDate *now = [NSDate date];
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *components = [calendar components:( NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute |NSCalendarUnitYear|NSCalendarUnitTimeZone) fromDate:now];
    [components setYear:2015];
    [components setHour:5];
    [components setMinute:30];
    [components setSecond:1];
    [components setMonth:2];
    switch (self.selectedIndex)
    {
        case 0:
            [components setDay:27];
            break;
        case 1:
            [components setDay:28];
            break;
        case 2:
            [components setDay:1];
            [components setMonth:3];

            break;
        case 3:
            [components setDay:2];
            [components setMonth:3];
            break;
        default:
            break;
    }
    NSDate *morningStart = [calendar dateFromComponents:components];
    [components setHour:18];
    NSDate *aftStart = [calendar dateFromComponents:components];
    [components setHour:23 ];
    NSDate *eveStart=[calendar dateFromComponents:components];
    [query whereKey:@"startingTime" greaterThan:morningStart];
    [query whereKey:@"startingTime" lessThan:aftStart];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (!error) {
            self.morningEvents=objects;
            [self.schedule reloadData];
        }
    }];
    PFQuery *query1 = [PFQuery queryWithClassName:@"event"];

    [query1 whereKey:@"startingTime" greaterThan:aftStart];
    [query1 whereKey:@"startingTime" lessThan:eveStart];
    [query1 findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (!error) {
            self.afternoonEvents=objects;
            [self.schedule reloadData];
        }
    }];
    PFQuery *query2 = [PFQuery queryWithClassName:@"event"];

    [query2 whereKey:@"startingTime" greaterThan:eveStart];
    [components setDay:components.day+1];
    [components setHour:5];
    [components setMinute:30];
    NSDate *dateBeforeNextDay=[calendar dateFromComponents:components];
    [query2 whereKey:@"startingTime" lessThan:dateBeforeNextDay];
    [query2 findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (!error) {
            self.eveningEvents=objects;
            [self.schedule reloadData];

        }
    }];
    
    [self.schedule reloadData];

}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
