//
//  scheduleViewController.m
//  tryst2015
//
//  Created by Robin Malhotra on 27/01/15.
//  Copyright (c) 2015 Robin's code kitchen. All rights reserved.
//

#import "scheduleViewController.h"

@interface scheduleViewController ()
@property(nonatomic,strong) NSMutableArray *strings;

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
    
    
    V8HorizontalPickerView *picker=[[V8HorizontalPickerView alloc]initWithFrame:CGRectMake(0, self.navigationController.navigationBar.frame.size.height, self.view.frame.size.width, 158)];
    [picker setDataSource:self];
    [picker setDelegate:self];
    [self.view addSubview:picker];
    picker.backgroundColor   = [UIColor blackColor];
    picker.selectionPoint = CGPointMake(picker.frame.origin.x, 0);
    picker.elementFont = [UIFont boldSystemFontOfSize:14.0f];
    [self.view addSubview:picker];
    
    self.schedule=[[UITableView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(picker.frame), self.view.frame.size.width, CGRectGetHeight(self.view.frame)-CGRectGetHeight(picker.frame))];
    [self.schedule setDataSource:self];
    [self.schedule setDelegate:self];
    // Do any additional setup after loading the view.
}

#pragma mark 

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

- (void)horizontalPickerView:(V8HorizontalPickerView *)picker didSelectElementAtIndex:(NSInteger)index
{
    NSLog(@"%d",index);
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
