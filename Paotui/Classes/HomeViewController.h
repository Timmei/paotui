//
//  HomeViewController.h
//  Paotui
//
//  Created by Tim on 14-9-12.
//  Copyright (c) 2014年 Johnson. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MyNavViewController.h"
#import <MAMapKit/MAMapKit.h>
#import <AMapSearchKit/AMapSearchAPI.h>
#import "CusAnnotationView.h"
#import "ShopViewController.h"
#import "SendView.h"

#import <AudioToolbox/AudioToolbox.h>
#import <AVFoundation/AVFoundation.h>

@interface HomeViewController : MyNavViewController<NavleftBtnDelegate,MAMapViewDelegate, AMapSearchDelegate,UITextFieldDelegate,shopclickDelegate,sendViewDelegate,AVAudioRecorderDelegate>

@property (nonatomic, strong) MAMapView *mapView;

@property (nonatomic, strong) AMapSearchAPI *search;

@property (retain, nonatomic) AVAudioPlayer *avPlay;

@end
