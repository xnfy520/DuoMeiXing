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

+ (UIColor *)colorWithHex:(NSString *)string;

+ (UIColor *) hexStringToColor: (NSString *) stringToConvert;

+ (NSDictionary *)dictionaryWithJsonString:(NSString *)jsonString;

+ (UIImage *)getImageFromURL:(NSString *)fileURL;

+ (NSString *)getDateStringWithDate:(NSDate *)date DateFormat:(NSString *)formatString;



@end
