//
//  ViewController.m
//  iAdTeset
//
//  Created by Dev Perfecular on 6/4/13.
//  Copyright (c) 2013 Test. All rights reserved.
//

#import "ViewController.h"
#import <iAd/iAd.h>

@interface ViewController () <ADBannerViewDelegate>
@property (strong, nonatomic) ADBannerView *bannerView;
@property (strong, nonatomic) IBOutlet UIView *contentView;
@end

@implementation ViewController

- (ADBannerView *)bannerView
{
    if (!_bannerView) {
        _bannerView = [[ADBannerView alloc] init];
    }
    return _bannerView;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.view addSubview:self.bannerView];
    self.bannerView.delegate = self;
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self layoutAnimated:NO];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)bannerViewDidLoadAd:(ADBannerView *)banner
{
    [self layoutAnimated:YES];
}

- (void)bannerViewWillLoadAd:(ADBannerView *)banner
{
}

- (void)bannerView:(ADBannerView *)banner didFailToReceiveAdWithError:(NSError *)error
{
    [self layoutAnimated:YES];
}

- (BOOL)bannerViewActionShouldBegin:(ADBannerView *)banner willLeaveApplication:(BOOL)willLeave
{
    return YES;
}

- (void)bannerViewActionDidFinish:(ADBannerView *)banner
{
    NSLog(@"banner finished.");
}

- (void)layoutAnimated:(BOOL)animated
{
    CGRect contentFrame = self.view.bounds;
    
    CGRect bannerFrame = self.bannerView.frame;
    if (self.bannerView.bannerLoaded) {
        contentFrame.size.height -= self.bannerView.frame.size.height;
        bannerFrame.origin.y = contentFrame.size.height;
    } else {
        bannerFrame.origin.y = contentFrame.size.height;
    }
    
    [UIView animateWithDuration:animated ? 0.25 : 0.0 animations:^{
        self.contentView.frame = contentFrame;
        [self.contentView layoutIfNeeded];
        self.bannerView.frame = bannerFrame;
    }];
}

@end
