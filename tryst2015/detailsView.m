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
        
        self.mainView=[[UIView alloc]initWithFrame:CGRectMake(WIDTH_MARGIN, HEIGHT_MARGIN_TOP, CGRectGetWidth(self.frame)-2*WIDTH_MARGIN, CGRectGetHeight(self.frame)-HEIGHT_MARGIN_TOP-HEIGHT_MARGIN_BOTTOM)];
        [self addSubview:self.mainView];
        
        [self.mainView.layer setCornerRadius:8.0f];
        self.mainView.layer.borderColor = [UIColor whiteColor].CGColor;
        self.mainView.layer.borderWidth = 2.0f;
        [self.mainView.layer setMasksToBounds:YES];
        
        UIImageView *image=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"molecule"]];
        [image setFrame:CGRectMake(0, 0, CGRectGetWidth(self.mainView.frame), self.mainView.frame.size.height/3)];
        [image setClipsToBounds:YES];
        [image setContentMode:UIViewContentModeScaleAspectFill];
        
        [self.mainView addSubview:image];
        
        
        UIBlurEffect *headingBlur=[UIBlurEffect effectWithStyle:UIBlurEffectStyleDark];
        UIVisualEffectView *headingBlurView=[[UIVisualEffectView alloc]initWithEffect:headingBlur];
        [headingBlurView setFrame:CGRectMake(CGRectGetMinX(image.frame), CGRectGetMaxY(image.frame)-40, CGRectGetWidth(self.mainView.frame), 40)];
        [self.mainView addSubview:headingBlurView];
        
        
        UILabel *heading=[[UILabel alloc]initWithFrame:CGRectMake(10, 0, CGRectGetWidth(headingBlurView.frame), CGRectGetHeight(headingBlurView.frame))];
        [heading setText:@"BIZ QUIZ"];
        [heading setFont:[UIFont fontWithName:@"DIN" size:30]];
        [headingBlurView addSubview:heading];
        [heading setTextColor:[UIColor whiteColor]];
        
        UILabel *StartTimeHeading=[[UILabel alloc] initWithFrame:CGRectMake(10, CGRectGetMaxY(image.frame)+10, self.mainView.frame.size.width/2, 30)];
        [StartTimeHeading setTextColor:[UIColor whiteColor]];
        [StartTimeHeading setText:@"START TIME"];
        [StartTimeHeading setFont:[UIFont fontWithName:@"HelveticaNeue-Light" size:24]];
        [self.mainView addSubview:StartTimeHeading];
        
        UILabel *endTimeHeading=[[UILabel alloc]initWithFrame:CGRectMake(10+self.mainView.frame.size.width/2, CGRectGetMaxY(image.frame)+10,  self.mainView.frame.size.width/2, 30)];
        [endTimeHeading setTextColor:[UIColor whiteColor]];
        [endTimeHeading setText:@"END TIME"];
        [endTimeHeading setFont:[UIFont fontWithName:@"HelveticaNeue-Light" size:24]];
        [self.mainView addSubview:endTimeHeading];
        
        UILabel *startTime=[[UILabel alloc]initWithFrame:CGRectMake(10, CGRectGetMaxY(StartTimeHeading.frame),  self.mainView.frame.size.width/2, 30)];
        [startTime setTextColor:[UIColor whiteColor]];
        [startTime setText:@"adkfjkasdf"];
        [self.mainView addSubview:startTime];
        
        UILabel *endTime=[[UILabel alloc]initWithFrame:CGRectMake( 10+self.mainView.frame.size.width/2, CGRectGetMaxY(StartTimeHeading.frame), self.mainView.frame.size.width/2, 30)];
        [endTime setTextColor:[UIColor whiteColor]];
        [endTime setText:@"adkfjkasdf"];
        [self.mainView addSubview:endTime];
        
        UIView *border0=[[UIView alloc]initWithFrame:CGRectMake(CGRectGetMinX(endTimeHeading.frame)-10, CGRectGetMaxY(image.frame), 1,70)];
        [border0 setBackgroundColor:[UIColor whiteColor]];
        [self.mainView addSubview:border0];
        
        UIView *border1=[[UIView alloc] initWithFrame:CGRectMake(0,CGRectGetMaxY(endTime.frame), CGRectGetWidth(self.mainView.frame), 1)];
        [border1 setBackgroundColor:[UIColor whiteColor]];
        [self.mainView addSubview:border1];
        
        UILabel *venueHeading=[[UILabel alloc]initWithFrame:CGRectMake(10, CGRectGetMaxY(endTime.frame), CGRectGetWidth(self.mainView.frame), 30)];
        [venueHeading setText:@"VENUE"];
        [venueHeading setTextColor:[UIColor whiteColor]];
        [venueHeading setFont:[UIFont fontWithName:@"HelveticaNeue-Light" size:24]];
        [self.mainView addSubview:venueHeading];
        
        UILabel *venue=[[UILabel alloc]initWithFrame:CGRectMake(10, CGRectGetMaxY(venueHeading.frame),CGRectGetWidth(self.mainView.frame), 30)];
        [venue setTextColor:[UIColor whiteColor]];
        [venue setText:@"ghjkl"];
        [self.mainView addSubview:venue];
        
        UIView *border2=[[UIView alloc] initWithFrame:CGRectMake(0,CGRectGetMaxY(venue.frame), CGRectGetWidth(self.mainView.frame), 1)];
        [border2 setBackgroundColor:[UIColor whiteColor]];
        [self.mainView addSubview:border2];
        
        UILabel *contactHeading=[[UILabel alloc]initWithFrame:CGRectMake(10, CGRectGetMaxY(venue.frame), CGRectGetWidth(self.mainView.frame), 30)];
        [contactHeading setTextColor:[UIColor whiteColor]];
        [contactHeading setText:@"CONTACT"];
        [contactHeading setFont:[UIFont fontWithName:@"HelveticaNeue-Light" size:24]];
        [self.mainView addSubview:contactHeading];
        
        UILabel *contact=[[UILabel alloc] initWithFrame:CGRectMake(10, CGRectGetMaxY(contactHeading.frame), CGRectGetWidth(self.mainView.frame), 30)];
        [contact setTextColor:[UIColor whiteColor]];
        [contact setText:@"asdkcjnakscd"];
        [self.mainView addSubview:contact];
        

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
