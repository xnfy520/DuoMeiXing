//
//  DisplayUtil.h
//  DuoMeiXing
//
//  Created by 天陨 on 15/6/18.
//  Copyright (c) 2015年 wake. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "DNADef.h"

@interface DisplayUtil : NSObject

+ (CGSize)getSize:(CGFloat)fontSize withString:(NSString *)fontText;

+ (CGSize)getSize:(CGFloat)fontSize withString:(NSString *)fontText withWidth:(CGFloat)width;

+ (NSString *)convertWithBytes:(CGFloat)bytes;

+ (UIColor *)colorWithHex:(NSString *)string;

+ (UIColor *) hexStringToColor: (NSString *) stringToConvert;

+ (NSDictionary *)dictionaryWithJsonString:(NSString *)jsonString;

+ (UIImage *)getImageFromURL:(NSString *)fileURL;

+ (NSString *)getDateStringWithDate:(NSNumber*)time withDateFormat:(NSString *)formatString;

+ (NSString *)getDateStringWithDate:(NSDate *)date DateFormat:(NSString *)formatString;

+ (NSString *)stringWithOptionCtrlType:(NSUInteger)type;

+ (NSString *)stringWithPhotographAlbumCategory:(NSUInteger)type;

@end
