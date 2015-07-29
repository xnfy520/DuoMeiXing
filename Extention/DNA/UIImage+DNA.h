//
//  UIImage+UIImage_PK.h
//
//
//  Created by wilsonli on 14-10-6.
//  Copyright (c) 2014年 wilsonli. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (UIImage_DNA)
+ (UIImage *)imageWithName:(NSString *)name;
+ (UIImage *)resizedImageWithName:(NSString *)name;
+ (UIImage *)resizedImageWithName:(NSString *)name left:(CGFloat)left top:(CGFloat)top;
- (UIImage *)imageToSize:(CGSize) size;
@end
