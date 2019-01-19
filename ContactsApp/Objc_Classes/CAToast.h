//
//  CAToastView.h
//  ContactsApp
//
//  Created by Gudkesh Kumar on 27/12/18.
//  Copyright © 2018 Exilant. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface CAToast : NSObject
+(void)showToastWithMessage:(NSString*)message;
@end

NS_ASSUME_NONNULL_END
