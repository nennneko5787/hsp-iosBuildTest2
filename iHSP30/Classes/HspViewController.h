/*
    File: HspViewController.h
*/

#import <UIKit/UIKit.h>
#import "HspView.h"

@interface HspViewController : UIViewController
{
    bool bannerIsVisible;
}
- (void)setHspView:(HspView *)hspview;
- (void)actMode:(int)amode;
@end
