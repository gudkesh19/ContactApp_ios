//
//  CAToastView.m
//  ContactsApp
//
//  Created by Gudkesh Kumar on 27/12/18.
//  Copyright © 2018 Exilant. All rights reserved.
//

#import "CAToast.h"

@implementation CAToast


+(void)showToastWithMessage:(NSString*)message {
    CGFloat screenWidth = [UIScreen mainScreen].bounds.size.width;
    CGFloat screenheight = [UIScreen mainScreen].bounds.size.height;
    UILabel *toast = [[UILabel alloc] initWithFrame:CGRectMake(60, screenheight-150, screenWidth - 120, 44)];
    toast.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.7];
    toast.textColor = UIColor.whiteColor;
    toast.textAlignment = NSTextAlignmentCenter;
    [[UIApplication sharedApplication].keyWindow addSubview:toast];
    toast.text = message;
    toast.alpha = 1.0;
    toast.layer.cornerRadius = 8;
    toast.layer.masksToBounds = true;
    [UIView animateWithDuration:4.0 delay:2.0 options:UIViewAnimationOptionCurveEaseOut animations:^{
        toast.alpha = 0.0;
    } completion:^(BOOL finished) {
       [toast removeFromSuperview];
    }];
}



@end
