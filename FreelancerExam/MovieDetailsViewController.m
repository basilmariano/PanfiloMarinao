//
//  MovieDetailsViewController.m
//  FreelancerExam
//
//  Created by Sil Piplay on 7/10/15.
//  Copyright (c) 2015 Panfilo. All rights reserved.
//

#import "MovieDetailsViewController.h"
#import "UIImageView+Helper.h"

@interface MovieDetailsViewController ()

@property (nonatomic, weak) IBOutlet UIImageView *cover;
@property (nonatomic, weak) IBOutlet UILabel *titleLabel;
@property (nonatomic, weak) IBOutlet UILabel *timeLabel;
@property (nonatomic, weak) IBOutlet UIImageView *ratingImageView;
@property (nonatomic, weak) IBOutlet NSLayoutConstraint *ratingImageViewWidthConstr;
@property (nonatomic, weak) IBOutlet NSLayoutConstraint *ratingImageViewHeightConstr;

@end

@implementation MovieDetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = self.movie.name;
    
    NSString *ratingImageName = self.movie.rating;
    NSString *timeSchedule = [NSString stringWithFormat:@"%@ - %@", self.movie.startTime, self.movie.endTime];
    
    self.titleLabel.text = self.movie.name;
    self.timeLabel.text = timeSchedule;
    self.cover.image = [UIImage imageNamed:self.movie.name];
    
    if (!ratingImageName.length) {
        ratingImageName = @"NR";
        self.ratingImageViewWidthConstr.constant = 60.0f;
        self.ratingImageViewHeightConstr.constant = 14.0f;
    } else {
        self.ratingImageViewWidthConstr.constant = 33.0f;
        self.ratingImageViewHeightConstr.constant = 18.0f;
    }
    
    self.ratingImageView.image = [UIImage imageNamed:ratingImageName];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
