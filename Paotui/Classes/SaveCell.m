//
//  SaveCell.m
//  Paotui
//
//  Created by Tim on 14-9-15.
//  Copyright (c) 2014年 Johnson. All rights reserved.
//

#import "SaveCell.h"

@implementation SaveCell

@synthesize logoImage,Title,distance;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        
        UIImageView *image = [[UIImageView alloc]initWithFrame:CGRectMake(10, 5, 80, 80)];
//        image.backgroundColor = [UIColor blackColor];
        image.image = [UIImage imageNamed:@"animatedCar_4.png"];
        [self addSubview:image];
        self.logoImage = image;
        
        UILabel *_title = [[UILabel alloc]initWithFrame:CGRectMake(100, 0, 200, 40)];
        _title.backgroundColor = [UIColor clearColor];
        _title.text = @"全家便利店";
        self.Title = _title;
        [self addSubview:_title];
        
        UILabel *_lltitle = [[UILabel alloc]initWithFrame:CGRectMake(100, 30, 200, 40)];
        _lltitle.font = [UIFont systemFontOfSize:13];
        _lltitle.backgroundColor = [UIColor clearColor];
        _lltitle.text = @"500米";
        self.distance = _lltitle;
        [self addSubview:_lltitle];
        
        TQStarRatingView *starRatingView = [[TQStarRatingView alloc] initWithFrame:CGRectMake(100, 60, 140, 26) numberOfStar:5];
//        starRatingView.delegate = self;
        [self addSubview:starRatingView];
        
    }
    return self;
}

- (void)awakeFromNib
{
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
