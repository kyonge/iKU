//
//  ETUtility.h
//  Ringle
//
//  Created by 기용 이 on 13. 3. 24..
//  Copyright (c) 2013년 appsolution. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "ETCalendarUtility.h"
//#import "HTTPRequest.h"
//#import "UserInfo.h"
//#import "LoadingAnimationController.h"
//#import "KakaoLinkCenter.h"

@interface ETUtility : NSObject

#pragma mark - UIAlertView
+ (void)ShowAlertViewTitle:(NSString *)title Message:(NSString *)message Cancel:(NSString *)cancel Delegate:(id)target Tag:(int)tag;

#pragma mark - Image Caching
+ (UIImage *)loadImageFileFromDocumentCache:(NSString *)fileName;

#pragma mark - Image Size
+ (UIImage *)resizeImage:(UIImage *)imageSource ToWidth:(float)newWidth;
+ (UIImage *)resizeImage:(UIImage *)imageSource ToSize:(CGSize)newSize;
+ (UIImage *)imageByCropping:(UIImage *)imageToCrop toRect:(CGRect)rect;

//#pragma mark - 인디케이터
//+ (void)showActivityIndicatorView:(UIView *)superView;
//+ (void)hideActivityIndicatorView;

#pragma mark - ETC
+ (BOOL)is4Inch;
+ (BOOL)isEmpty:(id)object;
+ (void)AnimationView:(UIView *)view toFrame:(CGRect)frame toAlpha:(float)alpha inTime:(float)time toTarget:(id)target WithSelector:(SEL)selector;
+ (CGFloat)widthOfString:(NSString *)string withFont:(UIFont *)font;
+ (UIImage *)imageWithBarcode:(NSString *)barcodeString;

@end
