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

    
    self.schedule=[[UITableView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(_picker.frame), self.view.frame.size.width, CGRectGetHeight(self.view.frame)-CGRectGetHeight(_picker.frame))];
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
        NSString *x=[NSDateFormatter localizedStringFromDate:[[self.morningEvents objectAtIndex:indexPath.row] objectForKey:@"startingTime"]dateStyle:NSDateFormatterLongStyle timeStyle:NSDateFormatterShortStyle];
        [cell.subtitleLabel setText:x];
    }
    if (indexPath.section==1)
    {
        cell.textLabel.text=[[self.afternoonEvents objectAtIndex:indexPath.row] objectForKey:@"name"];
        NSString *x=[NSDateFormatter localizedStringFromDate:[[self.morningEvents objectAtIndex:indexPath.row] objectForKey:@"startingTime"]dateStyle:NSDateFormatterLongStyle timeStyle:NSDateFormatterShortStyle];
        [cell.subtitleLabel setText:x];
    }
    if (indexPath.section==2)
    {
        cell.textLabel.text=[[self.eveningEvents objectAtIndex:indexPath.row] objectForKey:@"name"];
        NSString *x=[NSDateFormatter localizedStringFromDate:[[self.morningEvents objectAtIndex:indexPath.row] objectForKey:@"startingTime"]dateStyle:NSDateFormatterLongStyle timeStyle:NSDateFormatterShortStyle];
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
    UIView *view=[[UIView alloc]initWithFrame:CGRectMake(0, 0, 145, 100)];
    UILabel *month=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, 145, 26)];
    [month setTextColor:[UIColor whiteColor]];
    if (index<2)
    {
        [month setText:@"FEB"];
    }
    else
    {
        [month setText:@"MAR"];
    }
    
    UILabel *day=[[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(month.frame), 145, 85)];
    [month setFont:[UIFont fontWithName:@"DIN" size:30]];
    [month setTextAlignment:NSTextAlignmentCenter];
    [day setTextAlignment:NSTextAlignmentCenter];
    switch (index) {
        case 0:
            [day setText:@"27"];
            break;
        case 1:
            [day setText:@"28"];
            break;
        case 2:
            [day setText:@"1"];
            break;
        case 3:
            [day setText:@"2"];
            break;
            
        default:
            break;
    }
    [day setTextColor:[UIColor whiteColor]];
    [day setFont:[UIFont fontWithName:@"DIN" size:50]];
    [view addSubview:month];
    [view addSubview:day];
    return view;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UILabel *label=[[UILabel alloc] initWithFrame:CGRectMake(0,0, self.view.frame.size.width, 35)];
    if (section==0)
    {
        [label setText:@"MORNING"];
        [label setTextColor:[UIColor greenColor]];
    }
    else if (section==1)
    {
        [label setText:@"AFTERNOON"];
        [label setTextColor:[UIColor blueColor]];
    }
    else if (section==2)
    {
        [label setText:@"EVENING"];
        [label setTextColor:[UIColor whiteColor]];
    }
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
    [components setHour:0];
    [components setMinute:0];
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
            break;
        case 3:
            [components setDay:2];
            break;
        default:
            break;
    }
    NSDate *morningStart = [calendar dateFromComponents:components];
    [components setHour:13];
    NSDate *aftStart = [calendar dateFromComponents:components];
    [components setHour:17];
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

    [query2 whereKey:@"startingTime" greaterThan:aftStart];
    [query2 whereKey:@"startingTime" lessThan:eveStart];
    [query2 findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (!error) {
            self.eveningEvents=objects;
            [self.schedule reloadData];
        }
    }];
    
    
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
