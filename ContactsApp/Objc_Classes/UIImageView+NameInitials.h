//
//  UIImageView+NameInitials.h
//  ContactsApp
//
//  Created by Gudkesh Kumar on 27/12/18.
//  Copyright © 2018 Exilant. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIImageView (NameInitials)

- (UIImage *)getImageWithString:(NSString *)string color:(nullable UIColor *)color circular:(BOOL)isCircular;

@end

NS_ASSUME_NONNULL_END
