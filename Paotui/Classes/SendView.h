//
//  SendView.h
//  Paotui
//
//  Created by Tim on 14-9-18.
//  Copyright (c) 2014年 Johnson. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol sendViewDelegate <NSObject>

- (void)yuyinPlay;
- (void)sendConfirClick;

- (void)tips:(NSString*)tipstr;

- (void)yuyueTime:(NSString*)yuyueTime;

@end

@interface SendView : UIView<UIPickerViewDelegate,UIPickerViewDataSource>

@property(strong,nonatomic)id<sendViewDelegate>delegate;

@end
