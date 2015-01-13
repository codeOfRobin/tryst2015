//
//  EventCell.m
//  tryst2015
//
//  Created by Robin Malhotra on 13/01/15.
//  Copyright (c) 2015 Robin's code kitchen. All rights reserved.
//

#import "EventCell.h"

@implementation EventCell

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
        
        self.subtitleLabel=[[UILabel alloc] initWithFrame:CGRectMake(0, 0, 1000, 100)];
        self.cellImage=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 75, 75)];
        [self.cellImage setCenter:CGPointMake(40, 37.5)];
        [self.contentView addSubview:self.subtitleLabel];
        [self.contentView addSubview:self.cellImage];
        self.subtitleLabel.textColor=[UIColor whiteColor];
        self.textLabel.textColor=[UIColor whiteColor];
        self.cellImage.layer.cornerRadius=37.5;
        self.cellImage.clipsToBounds=YES;
        [self.textLabel setFont:[UIFont fontWithName:@"HelveticaNeue-Light" size:24]];
        [self.subtitleLabel setFont:[UIFont fontWithName:@"HelveticaNeue-Light" size:15]];
    }
    return self;
}

- (void) layoutSubviews {
    [super layoutSubviews];
    [self.textLabel setFrame:CGRectMake(CGRectGetMaxX(self.cellImage.frame)+10,-30, 400, 100)];
    [self.subtitleLabel setFrame:CGRectMake(CGRectGetMinX(self.textLabel.frame), CGRectGetMinY(self.textLabel.frame)+30, 400, 100)];
}

-(void)prepareForReuse
{
    self.subtitleLabel.text=@"";
}
@end
