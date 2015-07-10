//
//  MoviesTableViewCell.h
//  FreelancerExam
//
//  Created by Sil Piplay on 7/10/15.
//  Copyright (c) 2015 Panfilo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MoviesTableViewCell : UITableViewCell

@property (nonatomic, weak) IBOutlet UIImageView *stationImageView;
@property (nonatomic, weak) IBOutlet UIImageView *ratingImageView;
@property (nonatomic, weak) IBOutlet UILabel *titleLabel;
@property (nonatomic, weak) IBOutlet UILabel *shedTimeLabel;
@property (nonatomic, weak) IBOutlet NSLayoutConstraint *ratingImageViewWidthConstr;
@property (nonatomic, weak) IBOutlet NSLayoutConstraint *ratingImageViewHeightConstr;

@end
