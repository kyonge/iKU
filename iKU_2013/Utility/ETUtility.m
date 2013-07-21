//
//  ETUtility.m
//  Ringle
//
//  Created by 기용 이 on 13. 3. 24..
//  Copyright (c) 2013년 appsolution. All rights reserved.
//

#import "ETUtility.h"

@implementation ETUtility

#pragma mark - UIAlertView

+ (void)ShowAlertViewTitle:(NSString *)title Message:(NSString *)message Cancel:(NSString *)cancel Delegate:(id)target Tag:(int)tag {
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:title message:message delegate:target cancelButtonTitle:cancel otherButtonTitles:nil];
    [alert setTag:tag];
    [alert show];
}


#pragma mark - Image Caching

+ (UIImage *)loadImageFileFromDocumentCache:(NSString *)fileName
{
    NSString *fileNameInLocalStorage = [[fileName componentsSeparatedByString:@"/"] lastObject];
    
    NSString *tempCacheFileString = [ETUtility documentString:fileNameInLocalStorage];
    BOOL hasCacheFile = [[NSFileManager defaultManager] fileExistsAtPath:tempCacheFileString];
    if (hasCacheFile) {
        return [ETUtility loadImage:fileNameInLocalStorage];
    }
    else {
        NSData *tempData = [NSData dataWithContentsOfURL:[NSURL URLWithString:fileName]];
        UIImage *tempImage = [UIImage imageWithData:tempData];
        
        [tempData writeToFile:tempCacheFileString atomically:YES];
        
        return tempImage;
    }
}


#pragma mark - Image Size

+ (UIImage *)resizeImage:(UIImage *)imageSource ToWidth:(float)newWidth {
    float ratio = imageSource.size.height / imageSource.size.width;
    CGSize thumbSize = CGSizeMake(newWidth, newWidth * ratio);
    UIGraphicsBeginImageContext(thumbSize);
    [imageSource drawInRect:CGRectMake(0, 0, thumbSize.width, thumbSize.height)];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return newImage;
}

+ (UIImage *)resizeImage:(UIImage *)imageSource ToSize:(CGSize)newSize {
    UIGraphicsBeginImageContext(newSize);
    [imageSource drawInRect:CGRectMake(0, 0, newSize.width, newSize.height)];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return newImage;
}

+ (UIImage *)imageByCropping:(UIImage *)imageToCrop toRect:(CGRect)rect
{
    CGImageRef imageRef = CGImageCreateWithImageInRect([imageToCrop CGImage], rect);
    
    UIImage *cropped = [UIImage imageWithCGImage:imageRef];
    CGImageRelease(imageRef);
    
    return cropped;
    
}


//#pragma mark - 인디케이터
//
//+ (void)showActivityIndicatorView:(UIView *)superView
//{
//    //    NSLog(@"Show Loading");
//    LoadingAnimationController *loadingAnimationController = [[UserInfo sharedInfo] loadingAnimationController];
//    [loadingAnimationController startLoading:superView];
//}
//
//+ (void)hideActivityIndicatorView
//{
//    //    NSLog(@"Hide Loading");
//    LoadingAnimationController *loadingAnimationController = [[UserInfo sharedInfo] loadingAnimationController];
//    [loadingAnimationController endLoading];
//}


#pragma mark - ETC

+ (BOOL)is4Inch
{
    return ([[UIScreen mainScreen] bounds].size.height >= 568);
}

+ (BOOL)isEmpty:(id)object {
    return object == (id)[NSNull null];
}

+ (void)AnimationView:(UIView *)view toFrame:(CGRect)frame toAlpha:(float)alpha inTime:(float)time toTarget:(id)target WithSelector:(SEL)selector {
    [UIView animateWithDuration:time animations:^{
        [view setFrame:frame];
        [view setAlpha:alpha];
    } completion:^(BOOL finished) {
        if (selector) {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
            [target performSelector:selector];
#pragma clang diagnostic pop
        }
    }];
}

+ (CGFloat)widthOfString:(NSString *)string withFont:(UIFont *)font {
    NSDictionary *attributes = [NSDictionary dictionaryWithObjectsAndKeys:font, NSFontAttributeName, nil];
    return [[[NSAttributedString alloc] initWithString:string attributes:attributes] size].width;
}

+ (UIImage *)imageWithBarcode:(NSString *)barcodeString
{
    UIImage *barcodeImage = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://ringle.kr/upload/barcode-pin.php?pin=%@", barcodeString]]]];
    return barcodeImage;
}

+ (NSString *)documentString:(NSString *)fileName {
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentPath = [[paths objectAtIndex:0] stringByAppendingPathComponent:fileName];
    
    return documentPath;
}

+ (UIImage *)loadImage:(NSString *)imageName {
    NSString *fileName = [imageName stringByDeletingPathExtension];
    NSString *fileExtension = [imageName pathExtension];
    UIImage *tempImage = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:fileName ofType:fileExtension]];
//    NSLog(@"%@ %@ %@", fileName, fileExtension, tempImage);
    if (tempImage) return tempImage;
    
    NSString *documentPath = [ETUtility documentString:imageName];
    UIImage *loadedImage;
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    BOOL exist = [fileManager fileExistsAtPath:documentPath];
//    NSLog(@"%@ exist : %d", documentPath, exist);
    
    if (exist) loadedImage = [UIImage imageWithContentsOfFile:documentPath];
    else
        loadedImage = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:[imageName stringByDeletingPathExtension] ofType:[imageName pathExtension]]];
//    NSLog(@"image : %@", loadedImage);
    return loadedImage;
}

@end
