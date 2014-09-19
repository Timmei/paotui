//
//  SendViewSec.h
//  Paotui
//
//  Created by Tim on 14-9-18.
//  Copyright (c) 2014年 Johnson. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol sendViewSecDelegate <NSObject>

- (void)sendSecConfirClick;

@end

@interface SendViewSec : UIView

@property(strong,nonatomic)id<sendViewSecDelegate>delegate;

@end
