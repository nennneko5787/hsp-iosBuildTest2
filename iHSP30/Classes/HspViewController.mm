/*
    File: HspViewController.m
*/

#import "HspViewController.h"

@implementation HspViewController

- (instancetype)init
{
    self = [super init];
    NSLog(@"Init HspViewController");
    adView = nil;
    return self;
}

- (void)dealloc
{
    [super dealloc];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)setHspView:(HspView *)hspview
{
    [self setView:hspview];
    [hspview setParent:self];
}

- (void)controlBanner:(int)prm
{
    NSLog(@"controlBanner___");
    if (adView == nil) {
        CGRect screenRect = [[UIScreen mainScreen] bounds];
        
        adView = [[GADBannerView alloc] initWithAdSize:kGADAdSizeBanner];
        adView.adUnitID = @"ca-app-pub-xxxxxxxxxxxxxxxx/xxxxxxxxxx";  // AdMob の広告ユニット ID を設定
        adView.rootViewController = self;
        adView.delegate = self;
        adView.frame = CGRectMake(0, screenRect.size.height - adView.frame.size.height, adView.frame.size.width, adView.frame.size.height);
        
        [self.view addSubview:adView];
        [adView loadRequest:[GADRequest request]];
        
        bannerIsVisible = false;
        NSLog(@"controlBanner");
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    NSLog(@"viewDidAppear");
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    NSLog(@"viewDidDisappear");
}

// 広告が正常に読み込まれたときの処理
- (void)bannerViewDidReceiveAd:(GADBannerView *)bannerView
{
    NSLog(@"bannerViewDidReceiveAd");
    if (!bannerIsVisible) {
        [UIView animateWithDuration:1.0 animations:^{
            adView.frame = CGRectOffset(adView.frame, 0, -adView.frame.size.height);
        }];
        bannerIsVisible = true;
    }
}

// 広告の読み込みに失敗したときの処理
- (void)bannerView:(GADBannerView *)bannerView didFailToReceiveAdWithError:(NSError *)error
{
    NSLog(@"bannerView failed to receive ad: %@", error.localizedDescription);
    if (bannerIsVisible) {
        [UIView animateWithDuration:1.0 animations:^{
            adView.frame = CGRectOffset(adView.frame, 0, adView.frame.size.height);
        }];
        bannerIsVisible = false;
    }
}

- (void)actMode:(int)amode
{
    HspView *hspview;
    hspview = (HspView *)self.view;
    [hspview actMode:amode];
}

@end
