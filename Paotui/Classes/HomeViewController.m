//
//  HomeViewController.m
//  Paotui
//
//  Created by Tim on 14-9-12.
//  Copyright (c) 2014年 Johnson. All rights reserved.
//

#import "HomeViewController.h"
#import "AnimatedAnnotation.h"
#import "AFHTTPRequestOperation.h"
#import "AnimatedAnnotationView.h"
#import "Store.h"
#import "Base.h"





#define kCalloutViewMargin          -8

@interface HomeViewController ()
{
    NSMutableArray          *storeArray;
    
    NSMutableArray          *annotations;
    
    UIView                  *inputView;
    
    UIButton                *longTapSayBtn;
    
    CGRect                  oriInputViewRect;
    UITextField             *inputFied;
    
    NSInteger               showFlag;
    
    SendView                *sendview;
    
    
    AVAudioRecorder         *recorder;
    NSTimer                 *timer;
    NSURL                   *urlPlay;
    
    NSInteger               flag;
}

@end

@implementation HomeViewController

@synthesize mapView = _mapView;
@synthesize search  = _search;

@synthesize avPlay;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
#pragma mark - Initialization

- (void)initMapView
{
    float ori = 44;
    
    if (isIos7 >= 7 && __IPHONE_OS_VERSION_MAX_ALLOWED > __IPHONE_6_1)
    {
        ori = 64;
    }
    ori += 40;
    CGRect rect = self.view.bounds;
    rect.origin.y += ori;
    rect.size.height -= (ori+44);
    self.mapView = [[MAMapView alloc] initWithFrame:rect];
    self.mapView.mapType = MAMapTypeStandard;

    self.mapView.showsScale = NO;
    self.mapView.showsCompass = NO;
    [self.mapView setZoomEnabled:YES];
    
//    MACoordinateSpan span = MACoordinateSpanMake(0.008,0.008);
//    MACoordinateRegion region;
//    region.center = CLLocationCoordinate2DMake(23.134893, 113.145829);
//    region.span = span;
//    [self.mapView setRegion:region animated:YES];
    
    self.mapView.delegate = self;
    
    [self.view addSubview:self.mapView];
    
    self.mapView.visibleMapRect = MAMapRectMake(220880104, 101476980, 272496, 466656);
    
    self.mapView.showsUserLocation = YES;    //YES 为打开定位，NO为关闭定位
    [self.mapView setUserTrackingMode: MAUserTrackingModeFollow animated:NO]; //地图跟着位置移动
    
    
    //segment选择器
    NSArray *segmentedArray = [[NSArray alloc]initWithObjects:@"便利店",@"水果店",nil];
    //初始化UISegmentedControl
    UISegmentedControl *segmentedControl = [[UISegmentedControl alloc]initWithItems:segmentedArray];
    
    segmentedControl.frame = CGRectMake(0.0, ori-40, 320.0, 40);
    
    segmentedControl.selectedSegmentIndex = 0;//设置默认选择项索引
    
    segmentedControl.tintColor = [UIColor redColor];
    
    [segmentedControl addTarget:self action:@selector(segmentAction:) forControlEvents:UIControlEventValueChanged];
    [self.view addSubview:segmentedControl];

    //文本输入／语音输入
    
    inputView = [[UIView alloc]initWithFrame:CGRectMake(0, rect.origin.y+rect.size.height, rect.size.width, 44)];
    inputView.backgroundColor = [UIColor yellowColor];
    [self.view addSubview:inputView];

    UIButton *yuyinBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 44, 44)];
    [yuyinBtn setTitle:@"文字" forState:UIControlStateNormal];
    yuyinBtn.tag = 1;
    yuyinBtn.backgroundColor = [UIColor grayColor];
    [inputView addSubview:yuyinBtn];
    inputView.userInteractionEnabled = YES;
    [yuyinBtn addTarget:self action:@selector(yuyinClick:) forControlEvents:UIControlEventTouchUpInside];
    
    oriInputViewRect = inputView.frame;
    
    inputFied = [[UITextField alloc]initWithFrame:CGRectMake(50, 0, 260, 44)];
    inputFied.placeholder = @"你要外送什么？";
    inputFied.delegate = self;
    [inputView addSubview:inputFied];
    
    longTapSayBtn = [[UIButton alloc]initWithFrame:CGRectMake(50, 0, 260, 44)];
    longTapSayBtn.backgroundColor = [UIColor greenColor];
    [longTapSayBtn setTitle:@"长按说话" forState:UIControlStateNormal];
    
    [inputView addSubview:longTapSayBtn];
    
    [longTapSayBtn addTarget:self action:@selector(longTapSayStar:) forControlEvents:UIControlEventTouchDown];
    [longTapSayBtn addTarget:self action:@selector(longTapSaySuccess:) forControlEvents:UIControlEventTouchUpInside];
    [longTapSayBtn addTarget:self action:@selector(longTapSayCancel:) forControlEvents:UIControlEventTouchUpOutside];
    
    self.navigationController.interactivePopGestureRecognizer.delaysTouchesBegan=NO;
    
    longTapSayBtn.hidden = YES;
    
    
    UIButton *showLocaBtn = [[UIButton alloc]initWithFrame:CGRectMake(270, rect.origin.y+rect.size.height-60, 44, 44)];
    showLocaBtn.backgroundColor = [UIColor greenColor];
    [self.view addSubview:showLocaBtn];
    [showLocaBtn addTarget:self action:@selector(showLocClick:) forControlEvents:UIControlEventTouchUpInside];
    
    
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
    
    // 键盘高度变化通知，ios5.0新增的
#ifdef __IPHONE_5_0
    float version = [[[UIDevice currentDevice] systemVersion] floatValue];
    if (version >= 5.0) {
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillChangeFrameNotification object:nil];
    }
#endif
}

#pragma mark star Say

- (void)longTapSayStar:(UIButton *)btn
{
    //创建录音文件，准备录音
    if ([recorder prepareToRecord]) {
        //开始
        [recorder record];
    }
    
    //设置定时检测
    timer = [NSTimer scheduledTimerWithTimeInterval:0 target:self selector:@selector(detectionVoice) userInfo:nil repeats:YES];
    
//    [self performSelector:@selector(longTapSaySuccess:) withObject:nil afterDelay:30];
    
}

- (void)longTapSaySuccess:(UIButton *)btn
{
    double cTime = recorder.currentTime;
    if (cTime > 1) {//如果录制时间<2 不发送
        NSLog(@"发出去");
        sendview.hidden = NO;
        sendview.frame = CGRectMake(0, self.view.frame.size.height-240, 320, 240);
    }else {
        //删除记录的文件
        [recorder deleteRecording];
        //删除存储的
        UIAlertView *aler = [[UIAlertView alloc]initWithTitle:@"提示" message:@"按住才能录音" delegate:nil cancelButtonTitle:@"了解" otherButtonTitles:nil, nil];
        [aler show];
    }
    [recorder stop];
    [timer invalidate];
    
    
    
    
}

- (void)longTapSayCancel:(UIButton *)btn
{
    //删除录制文件
    [recorder deleteRecording];
    [recorder stop];
    [timer invalidate];
    
    NSLog(@"取消发送");
}

- (void)playRecordSound
{
    if (self.avPlay.playing) {
        [self.avPlay stop];
        return;
    }
    
    AVAudioPlayer *player = [[AVAudioPlayer alloc]initWithContentsOfURL:urlPlay error:nil];
    player.volume = 0.8;
    self.avPlay = player;
    [self.avPlay play];
}

- (void)detectionVoice
{
    [recorder updateMeters];//刷新音量数据
    //获取音量的平均值  [recorder averagePowerForChannel:0];
    //音量的最大值  [recorder peakPowerForChannel:0];
    
    double lowPassResults = pow(10, (0.05 * [recorder peakPowerForChannel:0]));
    NSLog(@"%lf",lowPassResults);
    //最大50  0
    //图片 小-》大
//    if (0<lowPassResults<=0.06) {
//        [self.imageView setImage:[UIImage imageNamed:@"record_animate_01.png"]];
//    }else if (0.06<lowPassResults<=0.13) {
//        [self.imageView setImage:[UIImage imageNamed:@"record_animate_02.png"]];
//    }else if (0.13<lowPassResults<=0.20) {
//        [self.imageView setImage:[UIImage imageNamed:@"record_animate_03.png"]];
//    }else if (0.20<lowPassResults<=0.27) {
//        [self.imageView setImage:[UIImage imageNamed:@"record_animate_04.png"]];
//    }else if (0.27<lowPassResults<=0.34) {
//        [self.imageView setImage:[UIImage imageNamed:@"record_animate_05.png"]];
//    }else if (0.34<lowPassResults<=0.41) {
//        [self.imageView setImage:[UIImage imageNamed:@"record_animate_06.png"]];
//    }else if (0.41<lowPassResults<=0.48) {
//        [self.imageView setImage:[UIImage imageNamed:@"record_animate_07.png"]];
//    }else if (0.48<lowPassResults<=0.55) {
//        [self.imageView setImage:[UIImage imageNamed:@"record_animate_08.png"]];
//    }else if (0.55<lowPassResults<=0.62) {
//        [self.imageView setImage:[UIImage imageNamed:@"record_animate_09.png"]];
//    }else if (0.62<lowPassResults<=0.69) {
//        [self.imageView setImage:[UIImage imageNamed:@"record_animate_10.png"]];
//    }else if (0.69<lowPassResults<=0.76) {
//        [self.imageView setImage:[UIImage imageNamed:@"record_animate_11.png"]];
//    }else if (0.76<lowPassResults<=0.83) {
//        [self.imageView setImage:[UIImage imageNamed:@"record_animate_12.png"]];
//    }else if (0.83<lowPassResults<=0.9) {
//        [self.imageView setImage:[UIImage imageNamed:@"record_animate_13.png"]];
//    }else {
//        [self.imageView setImage:[UIImage imageNamed:@"record_animate_14.png"]];
//    }
}


#pragma mark end Say

#pragma mark键盘高度变化通知
- (void)keyboardWillShow:(NSNotification *)notification {
    /*
     Reduce the size of the text view so that it's not obscured by the keyboard.
     Animate the resize so that it's in sync with the appearance of the keyboard.
     */
    NSDictionary *userInfo = [notification userInfo];
    // Get the origin of the keyboard when it's displayed.
    NSValue* aValue = [userInfo objectForKey:UIKeyboardFrameEndUserInfoKey];
    // Get the top of the keyboard as the y coordinate of its origin in self's view's coordinate system. The bottom of the text view's frame should align with the top of the keyboard's final position.
    CGRect keyboardRect = [aValue CGRectValue];
    // Get the duration of the animation.
    NSValue *animationDurationValue = [userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey];
    NSTimeInterval animationDuration;
    [animationDurationValue getValue:&animationDuration];
    // Animate the resize of the text view's frame in sync with the keyboard's appearance.
    [self moveInputBarWithKeyboardHeight:keyboardRect.size.height withDuration:animationDuration];
}

- (void)moveInputBarWithKeyboardHeight:(float)heght withDuration:(float)duration
{
    CGRect rect = oriInputViewRect;
    if (heght == 0)
    {
        rect = oriInputViewRect;
    }
    else
    {
        rect.origin.y -= heght;
    }
    
    
//    [UIView beginAnimations:@"animation" context:nil];
//    //动画持续时间
//    [UIView setAnimationDuration:duration];
//    //设置动画的回调函数，设置后可以使用回调方法
////    [UIView setAnimationDelegate:self];
//    //设置动画曲线，控制动画速度
//    [UIView  setAnimationCurve: UIViewAnimationCurveEaseInOut];
//    //设置动画方式，并指出动画发生的位置
//    inputView.frame = rect;
//    [UIView setAnimationTransition:UIViewAnimationTransitionNone forView:inputView  cache:YES];
//    //提交UIView动画
//    [UIView commitAnimations];
    
    
    [UIView animateWithDuration:duration animations:^{
        inputView.frame = rect;
       
    }];
}
#pragma mark 语音输入
- (void)yuyinClick:(UIButton*)btn
{
    if (btn.tag == 1)//切换到语音
    {
        btn.backgroundColor = [UIColor redColor];
    
        inputFied.hidden = YES;
        longTapSayBtn.hidden = NO;
        [btn setTitle:@"语音" forState:UIControlStateNormal];
        [inputFied resignFirstResponder];
        
        btn.tag = 2;
    }
    else//切换到文字
    {
        inputFied.hidden = NO;
        longTapSayBtn.hidden = YES;
        
        [inputFied becomeFirstResponder];
        [btn setTitle:@"文字" forState:UIControlStateNormal];
        btn.backgroundColor = [UIColor grayColor];
        btn.tag = 1;
    }
    
}
#pragma mark end
- (void)keyboardWillHide:(NSNotification *)notification {
    NSDictionary* userInfo = [notification userInfo];
    /*
     Restore the size of the text view (fill self's view).
     Animate the resize so that it's in sync with the disappearance of the keyboard.
     */
    NSValue *animationDurationValue = [userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey];
    NSTimeInterval animationDuration;
    [animationDurationValue getValue:&animationDuration];
    [self moveInputBarWithKeyboardHeight:0 withDuration:animationDuration];
}
#pragma mark-end
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    
    sendview.hidden = textField.text.length == 0;
    sendview.frame = CGRectMake(0, self.view.frame.size.height-240, 320, 240);
    
    return YES;
}


- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField        // return NO to disallow editing.
{
    return YES;
}
//- (void)textFieldDidBeginEditing:(UITextField *)textField;           // became first responder
//- (BOOL)textFieldShouldEndEditing:(UITextField *)textField;          // return YES to allow editing to stop and to resign first responder status. NO to disallow the editing session to end
//- (void)textFieldDidEndEditing:(UITextField *)textField;             // may be called if forced even if shouldEndEditing returns NO (e.g. view removed from window) or endEditing:YES called

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string   // return NO to not change text
{
    return YES;
}

- (void)segmentAction:(id)sender
{
         
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    flag = 0;
    
    annotations = [NSMutableArray array];
    
    storeArray = [[NSMutableArray alloc]initWithCapacity:10];
    
    self.delegate = self;
    
    [self initMapView];
    
    sendview = [[SendView alloc]initWithFrame:CGRectMake(0, self.view.frame.size.height-240, 320, 240)];
    sendview.backgroundColor = [UIColor redColor];
    [self.view addSubview:sendview];
    sendview.delegate = self;
    sendview.hidden = YES;
    
    
    [self audio];
    
//    UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(100, 100, 100, 100)];
//    btn.backgroundColor = [UIColor redColor];
//    [btn addTarget:self action:@selector(playRecordSound:) forControlEvents:UIControlEventTouchUpInside];
//    [self.view addSubview:btn];
    
}

#pragma mark 声音
- (void)audio
{
    //录音设置
    NSMutableDictionary *recordSetting = [[NSMutableDictionary alloc]init];
    //设置录音格式  AVFormatIDKey==kAudioFormatLinearPCM
    [recordSetting setValue:[NSNumber numberWithInt:kAudioFormatMPEG4AAC] forKey:AVFormatIDKey];
    //设置录音采样率(Hz) 如：AVSampleRateKey==8000/44100/96000（影响音频的质量）
    [recordSetting setValue:[NSNumber numberWithFloat:44100] forKey:AVSampleRateKey];
    //录音通道数  1 或 2
    [recordSetting setValue:[NSNumber numberWithInt:1] forKey:AVNumberOfChannelsKey];
    //线性采样位数  8、16、24、32
    [recordSetting setValue:[NSNumber numberWithInt:16] forKey:AVLinearPCMBitDepthKey];
    //录音的质量
    [recordSetting setValue:[NSNumber numberWithInt:AVAudioQualityHigh] forKey:AVEncoderAudioQualityKey];
    
    NSString *strUrl = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    NSURL *url = [NSURL fileURLWithPath:[NSString stringWithFormat:@"%@/lll.aac", strUrl]];
    urlPlay = url;
    
    NSError *error;
    //初始化
    recorder = [[AVAudioRecorder alloc]initWithURL:url settings:recordSetting error:&error];
    //开启音量检测
    recorder.meteringEnabled = YES;
    recorder.delegate = self;
    
    NSError *error1;
    AVAudioSession *session = [AVAudioSession sharedInstance];
    [session setCategory:AVAudioSessionCategoryPlayAndRecord error:&error1];
    [session setActive:YES error:&error1];
    
}

#pragma mark end

#pragma mark sendDelegate
- (void)yuyinPlay
{
    [self playRecordSound];
}

- (void)sendConfirClick
{
    CGRect rect = sendview.frame;
    rect.origin.y += 100;
    
    [UIView animateWithDuration:0.5 animations:^{
        sendview.frame = rect;
        
        
        
    }];
    
    UIAlertView *aler = [[UIAlertView alloc]initWithTitle:@"提示" message:@"已通知11个附近便利店，请等待" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    [aler show];
    
}

- (void)dismissAler
{
    
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 1) {
        [alertView dismissWithClickedButtonIndex:1 animated:YES];
        CGRect rect = sendview.frame;
        rect.origin.y -= 100;
        sendview.hidden = YES;
        return;
    }
    
    CGRect rect = sendview.frame;
    rect.origin.y -= 100;
    
    [UIView animateWithDuration:0.5 animations:^{
        sendview.frame = rect;
        
        
        
    }];
}

#pragma mark end

- (void)setStoreLocal
{
    
    //定义一个标注，放到annotations数组
    for (int i = 0; i< storeArray.count; i++) {
        Store *astore = [storeArray objectAtIndex:i];
        double lat = [astore.shoplatitude doubleValue];
        double lon = [astore.shopLongitude doubleValue];
        
        MAPointAnnotation *red = [[MAPointAnnotation alloc] init];
        red.coordinate = CLLocationCoordinate2DMake(lat, lon);
        red.title = astore.shopName;
        [annotations insertObject:red atIndex:i+1];
        
//        CLLocationCoordinate2D coor2d;
//        coor2d.latitude = lat;
//        coor2d.longitude = lon;
//        [self addCarAnnotationWithCoordinate:coor2d];
    }
    
    [self.mapView addAnnotations:annotations];
}

#pragma mark - Action Handle


- (CGSize)offsetToContainRect:(CGRect)innerRect inRect:(CGRect)outerRect
{
    CGFloat nudgeRight = fmaxf(0, CGRectGetMinX(outerRect) - (CGRectGetMinX(innerRect)));
    CGFloat nudgeLeft = fminf(0, CGRectGetMaxX(outerRect) - (CGRectGetMaxX(innerRect)));
    CGFloat nudgeTop = fmaxf(0, CGRectGetMinY(outerRect) - (CGRectGetMinY(innerRect)));
    CGFloat nudgeBottom = fminf(0, CGRectGetMaxY(outerRect) - (CGRectGetMaxY(innerRect)));
    return CGSizeMake(nudgeLeft ?: nudgeRight, nudgeTop ?: nudgeBottom);
}

- (void)shopClickDown
{
    if (showFlag == 0) {
        return;
    }
    
    UIStoryboard *story = [UIStoryboard storyboardWithName:@"Shop" bundle:nil];
    ShopViewController *shopView = [story instantiateViewControllerWithIdentifier:@"shop"];
    
    Store *store = [storeArray objectAtIndex:showFlag-1];
    shopView.myStore = store;
//    editView.addressDelegate = self;
    [[QHSliderViewController sharedSliderController].navigationController pushViewController:shopView animated:YES];
}

//定位更新时的回调函数

- (void)showLocClick:(UIButton*)btn
{
    flag = 0;
    [self.mapView removeAnnotations:annotations];
    [annotations removeAllObjects];
    [storeArray removeAllObjects];
//    annotations = [NSMutableArray new];
    self.mapView.showsUserLocation = YES;
}

-(void)mapView:(MAMapView*)mapView didUpdateUserLocation:(MAUserLocation*)userLocation
updatingLocation:(BOOL)updatingLocation
{
//    [annotations removeAllObjects];
    
    CLLocation *myLocal = userLocation.location;
    
    MAPointAnnotation *red = [[MAPointAnnotation alloc] init];
    red.coordinate = CLLocationCoordinate2DMake(myLocal.coordinate.latitude, myLocal.coordinate.longitude);
    red.title = @"Me";
    [annotations insertObject:red atIndex:0];
    
    NSString *URLTmp = [NSString stringWithFormat:@"http://121.199.55.20:8080/yunspeedserver/webapp/api/Store/getShop.api?longitude=%f&latitude=%f&type=0",myLocal.coordinate.longitude,myLocal.coordinate.latitude];
    NSString *URLTmp1 = [URLTmp stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];  //转码成UTF-8  否则可能会出现错误
    URLTmp = URLTmp1;
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString: URLTmp]];
    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"Success: %@", operation.responseString);
        
        NSString *requestTmp = [NSString stringWithString:operation.responseString];
        NSData *resData = [[NSData alloc] initWithData:[requestTmp dataUsingEncoding:NSUTF8StringEncoding]];
        //系统自带JSON解析
        NSDictionary *resultDic = [NSJSONSerialization JSONObjectWithData:resData options:NSJSONReadingMutableLeaves error:nil];
        
        
        
        
        //        NSArray *ts= [dic objectForKey:@"types"] ;
        for (NSDictionary *t in resultDic) {
            Store *asotre = [[Store alloc]init];
            [Base parseDictionary:t withObject:asotre withBaseClass:nil];
            [storeArray addObject:asotre];
            
            
        }
        [self setStoreLocal];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Failure: %@", error);
        //        [SVProgressHUD dismissWithError:@"提交失败，请重试"];
    }];
    [operation start];
    
    self.mapView.showsUserLocation = NO;
}

//定位获取失败时的回调函数
-(void)mapView:(MAMapView*)mapView didFailToLocateUserWithError:(NSError*)error
{
    
}
#pragma mark - Utility

//-(void)addCarAnnotationWithCoordinate:(CLLocationCoordinate2D)coordinate
//{
//    NSMutableArray *carImages = [[NSMutableArray alloc] init];
//    [carImages addObject:[UIImage imageNamed:@"animatedCar_1.png"]];
//    [carImages addObject:[UIImage imageNamed:@"animatedCar_2.png"]];
//    [carImages addObject:[UIImage imageNamed:@"animatedCar_3.png"]];
//    [carImages addObject:[UIImage imageNamed:@"animatedCar_4.png"]];
//    [carImages addObject:[UIImage imageNamed:@"animatedCar_3.png"]];
//    [carImages addObject:[UIImage imageNamed:@"animatedCar_4.png"]];
//    
//    AnimatedAnnotation *animatedCarAnnotation = [[AnimatedAnnotation alloc] initWithCoordinate:coordinate];
//    animatedCarAnnotation.animatedImages   = carImages;
//    animatedCarAnnotation.title            = @"AutoNavi";
//    animatedCarAnnotation.subtitle         = [NSString stringWithFormat:@"Car: %d images",1];
//    
//    
//    
//    [self.mapView addAnnotation:animatedCarAnnotation];
//}


-(MAAnnotationView*)mapView:(MAMapView *)mapView viewForAnnotation:(id)annotation
{

    
    
    if ([annotation isKindOfClass:[MAPointAnnotation class]])
    {
        static NSString *customReuseIndetifier = @"customReuseIndetifier";
        
        CusAnnotationView *annotationView = (CusAnnotationView*)[mapView dequeueReusableAnnotationViewWithIdentifier:customReuseIndetifier];
        
        if (annotationView == nil)
        {
            annotationView = [[CusAnnotationView alloc] initWithAnnotation:annotation
                                                           reuseIdentifier:customReuseIndetifier];
            annotationView.delegate = self;
        }
        
        // must set to NO, so we can show the custom callout view.
        annotationView.canShowCallout   = NO;
        annotationView.draggable        = YES;
        annotationView.calloutOffset    = CGPointMake(0, -5);
        
        annotationView.portrait         = [UIImage imageNamed:@"animatedCar_4.png"];
//        annotationView.name             = @"河马";
        
        annotationView.tag = flag;
        
        MAPointAnnotation *meAddress = annotation;
        
        if ([meAddress.title isEqualToString:@"Me"]) {
            annotationView.backgroundColor = [UIColor redColor];
        }
        
        flag++;
        
        return annotationView;
    }
    
    return nil;

}

- (void)mapView:(MAMapView *)mapView didSelectAnnotationView:(MAAnnotationView *)view
{
    /* Adjust the map center in order to show the callout view completely. */
    if ([view isKindOfClass:[CusAnnotationView class]]) {
        CusAnnotationView *cusView = (CusAnnotationView *)view;
        
        NSInteger flass = cusView.tag;
        
        showFlag = flass;
        
        CGRect frame = [cusView convertRect:cusView.calloutView.frame toView:self.mapView];
        
        frame = UIEdgeInsetsInsetRect(frame, UIEdgeInsetsMake(kCalloutViewMargin, kCalloutViewMargin, kCalloutViewMargin, kCalloutViewMargin));
        
        if (!CGRectContainsRect(self.mapView.frame, frame))
        {
            /* Calculate the offset to make the callout view show up. */
            CGSize offset = [self offsetToContainRect:frame inRect:self.mapView.frame];
            
            CGPoint theCenter = self.mapView.center;
            theCenter = CGPointMake(theCenter.x - offset.width, theCenter.y - offset.height);
            
            CLLocationCoordinate2D coordinate = [self.mapView convertPoint:theCenter toCoordinateFromView:self.mapView];
            
            [self.mapView setCenterCoordinate:coordinate animated:YES];
        }
        
//        [annotations objectAtIndex:flass];
        if (flass == 0)
        {
            cusView.storeLabel.text = @"我的位置";
        }
        else
        {
            Store *store = [storeArray objectAtIndex:flass-1];
            cusView.storeLabel.text = store.shopName;
        }
        
        //        cusView.name = @"尼玛";
        
    }
}
- (void)leftBtnClick
{
    if (sendview.hidden == NO) {
        sendview.hidden = YES;
        
    }
    else
    {
        [inputFied resignFirstResponder];
        [[QHSliderViewController sharedSliderController] showLeftViewController];
    }
    
    
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
