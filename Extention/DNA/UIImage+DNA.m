//
//  UIImage+UIImage_PK.m
//
//
//  Created by wilsonli on 14-10-6.
//  Copyright (c) 2014年 wilsonli. All rights reserved.
//

#import "UIImage+DNA.h"

@implementation UIImage (UIImage_DNA)
+ (UIImage *)imageWithName:(NSString *)name
{
    UIImage *image = [UIImage imageNamed:name];
    return image;
}

+ (UIImage *)resizedImageWithName:(NSString *)name left:(CGFloat)left top:(CGFloat)top
{
    UIImage *image = [UIImage imageWithName:name];
    return [image stretchableImageWithLeftCapWidth:image.size.width*left topCapHeight:image.size.height*top];
}

+ (UIImage *)resizedImageWithName:(NSString *)name
{
    UIImage *image = [UIImage imageWithName:name];
    return [image stretchableImageWithLeftCapWidth:image.size.width*0.5 topCapHeight:image.size.height*0.5];
}

- (UIImage *)imageToSize:(CGSize) size
{
    
    UIGraphicsBeginImageContext(size);
    
    [self drawInRect:CGRectMake(0, 0, size.width, size.height)];
    
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return newImage;
    
}

@end
