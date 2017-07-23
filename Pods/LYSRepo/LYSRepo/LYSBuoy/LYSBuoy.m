//
//  LYSBuoy.m
//  LYSRepo
//
//  Created by 刘永生 on 2017/3/13.
//  Copyright © 2017年 3050700400@qq.com. All rights reserved.
//

#import "LYSBuoy.h"

#import "LYSBuoyM.h"
#import <CommonCrypto/CommonDigest.h>

@interface LYSBuoyBackWindowViewController : UIViewController

@end

@implementation LYSBuoyBackWindowViewController

- (BOOL)prefersStatusBarHidden
{
    return NO;
}

@end


@interface LYSBuoy ()

@property (nonatomic, copy) NSString *md5Key;

@property (nonatomic, copy) LYSBuoyClickBlock buoyColockBlock;

@property (nonatomic, strong) UIImageView *imageView;

@property (nonatomic,assign) CGFloat mEmbed;


@end

@implementation LYSBuoy

+ (LYSBuoy *)sharedManager
{
    static LYSBuoy *sharedInstance = nil;
    static dispatch_once_t predicate;
    dispatch_once(&predicate, ^{
        if (!sharedInstance) {
            sharedInstance = [[LYSBuoy alloc] initWithFrame:CGRectMake([[UIScreen mainScreen] bounds].size.width - 40,
                                                                       [[UIScreen mainScreen] bounds].size.height - 100,
                                                                       40,
                                                                       40)];
            
            sharedInstance.backgroundColor = [UIColor greenColor];
            
        }
    });
    return sharedInstance;
}



- (instancetype)initWithImage:(UIImage *)image {
    
    LYSBuoy * buoy = [self initWithFrame:CGRectZero];
    
    buoy.image(image);
    
    return buoy;
    
}

- (instancetype)initWithFrame:(CGRect)frame {
    if(self = [super initWithFrame:frame])
    {
        self.userInteractionEnabled = YES;
        
        self.mEmbed = 0;
        
        self.md5Key = [self getCurrentMd5Key];
        
        UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc]initWithTarget:self
                                                                             action:@selector(handlePanGesture:)];
        [self addGestureRecognizer:pan];
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                                              action:@selector(handleTapGesture:)];
        [self addGestureRecognizer:tap];
        
        self.clipsToBounds = YES;
        
    }
    return self;
}


/**
 点击的回调方法
 */
- (void)clickBuoy:(LYSBuoyClickBlock)click {
    self.buoyColockBlock = [click copy];
}



/**
 手势点击
 */
- (void)handleTapGesture:(UITapGestureRecognizer *)tap {
    
    if (self.buoyColockBlock) {
        self.buoyColockBlock();
    }
    
}


/**
 手势拖动拖动
 */
- (void)handlePanGesture:(UIPanGestureRecognizer *)pan {
    
    UIWindow *appWindow = [UIApplication sharedApplication].delegate.window;
    CGPoint panPoint = [pan locationInView:appWindow];
    
    if(pan.state == UIGestureRecognizerStateBegan) {
        
    }else if(pan.state == UIGestureRecognizerStateChanged) {
        
        [LYSBuoyM windowForKey:self.md5Key].center = CGPointMake(panPoint.x, panPoint.y);
        
    }else if(pan.state == UIGestureRecognizerStateEnded
             || pan.state == UIGestureRecognizerStateCancelled) {
        
        CGFloat ballWidth = self.frame.size.width;
        CGFloat ballHeight = self.frame.size.height;
        CGFloat screenWidth = [[UIScreen mainScreen] bounds].size.width;
        CGFloat screenHeight = [[UIScreen mainScreen] bounds].size.height;
        
        CGFloat left = fabs(panPoint.x);
        CGFloat right = fabs(screenWidth - left);
        CGFloat top = fabs(panPoint.y);
        CGFloat bottom = fabs(screenHeight - top);
        
        CGFloat minSpace = minSpace = MIN(left, right);
        
        CGPoint newCenter;
        CGFloat targetY = 0;
        
        //Correcting Y
        if (panPoint.y < 15 + ballHeight / 2.0) {
            targetY = 15 + ballHeight / 2.0;
        }else if (panPoint.y > (screenHeight - ballHeight / 2.0 - 15)) {
            targetY = screenHeight - ballHeight / 2.0 - 15;
        }else{
            targetY = panPoint.y;
        }
        
        if (minSpace == left) {
            newCenter = CGPointMake(ballWidth / 2.0 + self.mEmbed, targetY);
        }else if (minSpace == right) {
            newCenter = CGPointMake(screenWidth - ballWidth / 2.0 - self.mEmbed, targetY);
        }else if (minSpace == top) {
            newCenter = CGPointMake(panPoint.x, ballHeight / 2.0);
        }else if (minSpace == bottom) {
            newCenter = CGPointMake(panPoint.x, screenHeight - ballHeight / 2.0);
        }else {
            newCenter = CGPointMake(panPoint.x, screenHeight - ballHeight / 2.0);
        }
        
        [UIView animateWithDuration:.25 animations:^{
            [LYSBuoyM windowForKey:self.md5Key].center = newCenter;
        }];
    }else{
        NSLog(@"pan state : %zd", pan.state);
    }
    
    
}




- (LYSBuoy *(^)()) show {
    
    return ^id(){
        
        if ([LYSBuoyM windowForKey:self.md5Key])
            return self;
        
        UIWindow *currentKeyWindow = [UIApplication sharedApplication].keyWindow;
        
        UIWindow *backWindow = [[UIWindow alloc] initWithFrame:self.frame];
        
        backWindow.rootViewController = [[LYSBuoyBackWindowViewController alloc] init];
        [backWindow makeKeyAndVisible];
        [LYSBuoyM saveWindow:backWindow forKey:self.md5Key];
        
        self.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
        
        [backWindow addSubview:self];
        
        [currentKeyWindow makeKeyWindow];
        
        return self;
    };
    
    
}


/**
 设置图片
 */
- (LYSBuoy *(^)(UIImage * image)) image {
    
    return ^id(UIImage * image){
        
        if (image) {
            
            self.imageView.image = image;
            
        }
        
        return self;
    };
    
}

- (LYSBuoy *(^)(CGFloat left)) left {
    
    return ^id(CGFloat left){
        
        CGRect frame = self.frame;
        frame.origin.x = left;
        self.frame = frame;
        
        return self;
    };
    
}
- (LYSBuoy *(^)(CGFloat top)) top {
    
    return ^id(CGFloat top){
        
        CGRect frame = self.frame;
        frame.origin.y = top;
        self.frame = frame;
        
        return self;
    };
    
}
- (LYSBuoy *(^)(CGFloat width)) width {
    
    return ^id(CGFloat width){
        
        CGRect frame = self.frame;
        frame.size.width = width;
        self.frame = frame;
        
        return self;
    };
    
}

- (LYSBuoy *(^)(CGFloat height)) height {
    
    return ^id(CGFloat height){
        
        CGRect frame = self.frame;
        frame.size.height = height;
        self.frame = frame;
        
        return self;
    };
    
}

- (LYSBuoy *(^)(CGFloat embed)) embed {
    return ^id(CGFloat embed){
        
        self.mEmbed = embed;
        
        return self;
    };
    
}

- (LYSBuoy *(^)(BOOL isHidden)) hiddenView {
    
    return ^id(BOOL isHidden){
        
        [LYSBuoyM windowForKey:self.md5Key].hidden = isHidden;
        
        return self;
    };
    
}


- (LYSBuoy *(^)()) remove {
    
    return ^id(){
        [LYSBuoyM removeWindowForKey:self.md5Key];
        return self;
    };
    
}



#pragma mark -

- (NSString *)getCurrentMd5Key
{
    NSString *str = self.description;
    const char *cStr = [str UTF8String];
    unsigned char result[16];
    CC_MD5( cStr, (int)strlen(cStr), result );
    return [NSString stringWithFormat:
            @"%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X",
            result[0],result[1],result[2],result[3],
            result[4],result[5],result[6],result[7],
            result[8],result[9],result[10],result[11],
            result[12],result[13],result[14],result[15]];
}




- (UIImageView *)imageView {
    
    if(!_imageView){
        _imageView = [[UIImageView alloc]initWithFrame:self.bounds];
        _imageView.contentMode = UIViewContentModeScaleAspectFill;
        
        [self addSubview:_imageView];
        
        _imageView.backgroundColor = [UIColor redColor];
        
        _imageView.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
    }
    return _imageView;
    
}


@end
