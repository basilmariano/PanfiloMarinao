//
//  MoviesViewController.m
//  FreelancerExam
//
//  Created by Sil Piplay on 7/10/15.
//  Copyright (c) 2015 Panfilo. All rights reserved.
//

#import "MoviesViewController.h"
#import "LibraryAPI.h"
#import "MoviesTableViewCell.h"
#import "Movie.h"
#import "MovieDetailsViewController.h"

@interface MoviesViewController () <UITableViewDataSource, UITableViewDelegate> {
     NSInteger page;
}

@property (nonatomic, weak) IBOutlet UITableView *tableView;
@property (nonatomic, strong) UIView * footerView;
@property (nonatomic, strong) NSMutableArray *movieList;
@property (nonatomic, strong) UIActivityIndicatorView *spinner;
@property (nonatomic) BOOL isLoading;

@end

@implementation MoviesViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.movieList = [[NSMutableArray alloc] init];
    [self requestContentAtPage:0];
    [self initFooterView];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
   return self.movieList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    Movie *movie = [self.movieList objectAtIndex:indexPath.row];
    NSString *timeSchedule = [NSString stringWithFormat:@"%@ - %@", movie.startTime, movie.endTime];
    NSString *ratingImageName = movie.rating;
    
    MoviesTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"moviesCell" forIndexPath:indexPath];
    cell.stationImageView.image = [UIImage imageNamed:movie.channel];
    cell.titleLabel.text = movie.name;
    cell.shedTimeLabel.text = timeSchedule;
    
    if (!ratingImageName.length) {
        ratingImageName = @"NR";
        cell.ratingImageViewWidthConstr.constant = 60.0f;
        cell.ratingImageViewHeightConstr.constant = 14.0f;
    } else {
        cell.ratingImageViewWidthConstr.constant = 33.0f;
        cell.ratingImageViewHeightConstr.constant = 18.0f;
    }
    
    cell.ratingImageView.image = [UIImage imageNamed:ratingImageName];
    return cell;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {

    CGSize screenSize = [UIScreen mainScreen].bounds.size;
            
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, screenSize.width, 30.0f)];
    view.backgroundColor = [UIColor colorWithRed:242/255.0f green:242/255.0f blue:242/255.0f alpha:1];
            
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(8, 0, view.frame.size.width, 30.0f)];
    [label setFont:[UIFont fontWithName:@"HelveticaNeue-Medium" size:15.0f]];
    [label setTextColor:[UIColor blackColor]];
    label.text = @"TONIGHT";
            
    [view addSubview:label];
    return view;

}

#pragma mark UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 30.0f;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    Movie *movie = [self.movieList objectAtIndex:indexPath.row];
    MovieDetailsViewController *movieDetailsVc = [self.storyboard instantiateViewControllerWithIdentifier:@"MovieDetailsViewController"];
    movieDetailsVc.movie = movie;
    [self.navigationController pushViewController:movieDetailsVc animated:YES];
}

#pragma mark UIScrollViewDelegate
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    BOOL endOfTable = (scrollView.contentOffset.y >= ((self.movieList.count * 78) - scrollView.frame.size.height)); // Here 78 is row height
    
    if (endOfTable && !self.isLoading && !scrollView.dragging && !scrollView.decelerating){
        self.tableView.tableFooterView = self.footerView;
        [self requestContent];
        [(UIActivityIndicatorView *)[self.footerView viewWithTag:10] startAnimating];
    }
    
}

#pragma mark Private 
- (void)requestContent {
    [self requestContentAtPage:page];
}

- (void)requestContentAtPage: (NSUInteger)pageNumber {
    self.isLoading = YES;
    [[LibraryAPI sharedInstance] requestMovieListAtPage:pageNumber success:^(NSMutableArray *movieList) {
        page++;
        self.isLoading = NO;
        for (NSDictionary *movieItem in movieList) {
            [self.movieList addObject:movieItem];
        }
        [self.tableView reloadData];
    } failure:^(NSError *error) {
        self.isLoading = NO;
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Freelancer.com" message:@"Request error! Please contact administrator." delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles: nil];
        [alertView show];
    }];
}

-(void)initFooterView {
    self.footerView = [[UIView alloc] initWithFrame:CGRectMake(0.0, 0.0, [UIScreen mainScreen].bounds.size.width, 44.0)];
    UIActivityIndicatorView * activityIndicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    activityIndicator.tag = 10;
    activityIndicator.frame = CGRectMake(self.footerView.frame.size.width / 2, self.footerView.frame.size.height / 2, 20.0, 20.0);
    activityIndicator.hidesWhenStopped = YES;
    [self.footerView addSubview:activityIndicator];
    activityIndicator = nil;
}

@end
