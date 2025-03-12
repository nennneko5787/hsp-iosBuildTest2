/*
    File: HspViewController.h
*/

#import <UIKit/UIKit.h>
#import <GoogleMobileAds/GoogleMobileAds.h>
#import "HspView.h"

@interface HspViewController : UIViewController <GADBannerViewDelegate>
{
    GADBannerView *adView;
    bool bannerIsVisible;
}
- (void)setHspView:(HspView *)hspview;
- (void)controlBanner:(int)prm;
- (void)actMode:(int)amode;
@end
