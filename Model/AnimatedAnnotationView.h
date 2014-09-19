//
//  AnimatedAnnotationView.h
//  Category_demo2D
//
//  Created by 刘博 on 13-11-8.
//  Copyright (c) 2013年 songjian. All rights reserved.
//

#import <MAMapKit/MAMapKit.h>

@interface AnimatedAnnotationView : MAAnnotationView

@property (nonatomic, strong) UIImageView *imageView;

//@property (nonatomic, copy) NSString *name;

@property (nonatomic, strong) UIView *calloutView;


@end
