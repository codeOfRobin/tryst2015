//
//  detailsView.m
//  tryst2015
//
//  Created by Robin Malhotra on 14/01/15.
//  Copyright (c) 2015 Robin's code kitchen. All rights reserved.
//

#import "detailsView.h"

@implementation detailsView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (nil != self)
    {
        UIBlurEffect *blur=[UIBlurEffect effectWithStyle:UIBlurEffectStyleDark];
        UIVisualEffectView *view=[[UIVisualEffectView alloc] initWithEffect:blur];
        [view setFrame:self.frame];
        [self addSubview:view];
        
        self.mainView=[[UIScrollView alloc]initWithFrame:CGRectMake(WIDTH_MARGIN, HEIGHT_MARGIN_TOP, CGRectGetWidth(self.frame)-2*WIDTH_MARGIN, CGRectGetHeight(self.frame)-HEIGHT_MARGIN_TOP-HEIGHT_MARGIN_BOTTOM)];
        [self addSubview:self.mainView];
        
        [self.mainView.layer setCornerRadius:8.0f];
        self.mainView.layer.borderColor = [UIColor whiteColor].CGColor;
        self.mainView.layer.borderWidth = 2.0f;
        [self.mainView.layer setMasksToBounds:YES];
        
        UIImageView *image=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"Arduino"]];
        [image setFrame:CGRectMake(0, 0, CGRectGetWidth(self.mainView.frame), self.mainView.frame.size.height/3)];
        [image setClipsToBounds:YES];
        [image setContentMode:UIViewContentModeScaleAspectFill];
        
        [self.mainView addSubview:image];
        
        
        UIBlurEffect *headingBlur=[UIBlurEffect effectWithStyle:UIBlurEffectStyleDark];
        UIVisualEffectView *headingBlurView=[[UIVisualEffectView alloc]initWithEffect:headingBlur];
        [headingBlurView setFrame:CGRectMake(CGRectGetMinX(image.frame), CGRectGetMaxY(image.frame)-40, CGRectGetWidth(self.mainView.frame), 40)];
        [self.mainView addSubview:headingBlurView];
        
        
        UILabel *heading=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, CGRectGetWidth(headingBlurView.frame), CGRectGetHeight(headingBlurView.frame))];
        [heading setText:@"kasjncdksa"];
        [headingBlurView addSubview:heading];
        [heading setTextColor:[UIColor whiteColor]];
        
        UILabel *StartTimeHeading=[[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(image.frame)+10, self.mainView.frame.size.width/2, 30)];
        [StartTimeHeading setTextColor:[UIColor whiteColor]];
        [StartTimeHeading setText:@"START TIME"];
        [self.mainView addSubview:StartTimeHeading];
        
        UILabel *endTimeHeading=[[UILabel alloc]initWithFrame:CGRectMake(self.mainView.frame.size.width/2, CGRectGetMaxY(image.frame)+10,  self.mainView.frame.size.width/2, 30)];
        [endTimeHeading setTextColor:[UIColor whiteColor]];
        [endTimeHeading setText:@"END TIME"];
        [self.mainView addSubview:endTimeHeading];
        
        UILabel *startTime=[[UILabel alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(StartTimeHeading.frame),  self.mainView.frame.size.width/2, 30)];
        [startTime setTextColor:[UIColor whiteColor]];
        [startTime setText:@"adkfjkasdf"];
        [self.mainView addSubview:startTime];
        
        UILabel *endTime=[[UILabel alloc]initWithFrame:CGRectMake( self.mainView.frame.size.width/2, CGRectGetMaxY(StartTimeHeading.frame), self.mainView.frame.size.width/2, 30)];
        [endTime setTextColor:[UIColor whiteColor]];
        [endTime setText:@"adkfjkasdf"];
        [self.mainView addSubview:endTime];
        
        UILabel *venueHeading=[[UILabel alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(endTime.frame), CGRectGetWidth(self.mainView.frame), 30)];
        [venueHeading setText:@"VENUE"];
        [venueHeading setTextColor:[UIColor whiteColor]];
        [self.mainView addSubview:venueHeading];
        
        UILabel *venue=[[UILabel alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(venueHeading.frame),CGRectGetWidth(self.mainView.frame), 30)];
        [venue setTextColor:[UIColor whiteColor]];
        [venue setText:@"ghjkl"];
        [self.mainView addSubview:venue];
        
        UILabel *contactHeading=[[UILabel alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(venue.frame), CGRectGetWidth(self.mainView.frame), 30)];
        [contactHeading setTextColor:[UIColor whiteColor]];
        [contactHeading setText:@"CONTACT"];
        [self.mainView addSubview:contactHeading];
        
        UILabel *contact=[[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(contactHeading.frame), CGRectGetWidth(self.mainView.frame), 30)];
        [contact setTextColor:[UIColor whiteColor]];
        [contact setText:@"asdkcjnakscd"];
        [self.mainView addSubview:contact];
        
        [self.mainView setContentSize:CGSizeMake(CGRectGetWidth(self.mainView.frame), 1000)];

        UIButton *done=[[UIButton alloc]initWithFrame:CGRectMake(CGRectGetWidth(self.mainView.frame)-100 , CGRectGetMinY(self.mainView.frame)-30, 100, 30)];
        [done setTitle:@"Done" forState:UIControlStateNormal];
        [done addTarget:self action:@selector(buttonHandle:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:done];
    }
    return self;
    


}


-(void)buttonHandle:(id)sender
{
    [self removeFromSuperview];
}



@end
