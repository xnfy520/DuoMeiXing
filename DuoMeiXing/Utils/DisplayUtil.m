//
//  DisplayUtil.m
//  DuoMeiXing
//
//  Created by 天陨 on 15/6/18.
//  Copyright (c) 2015年 wake. All rights reserved.
//

#import "DisplayUtil.h"
#import "UIView+FrameMethods.h"


@implementation DisplayUtil

+ (CGSize)getSize:(CGFloat)fontSize withString:(NSString *)fontText
{
    NSDictionary *attributes = @{NSFontAttributeName: [UIFont systemFontOfSize:fontSize]};
    CGSize textSize = [fontText sizeWithAttributes:attributes];
    return textSize;
}

+ (UIColor *) hexStringToColor: (NSString *) stringToConvert
{
    NSString *cString = [[stringToConvert stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];
    // String should be 6 or 8 charactersif ([cString length] < 6) return [UIColor blackColor];
    // strip 0X if it appearsif ([cString hasPrefix:@"0X"]) cString = [cString substringFromIndex:2];
    if ([cString hasPrefix:@"#"]) cString = [cString substringFromIndex:1];
    if ([cString length] != 6) return [UIColor blackColor];
    
    // Separate into r, g, b substrings
    NSRange range;
    range.location = 0;
    range.length = 2;
    NSString *rString = [cString substringWithRange:range];
    range.location = 2;
    NSString *gString = [cString substringWithRange:range];
    range.location = 4;
    NSString *bString = [cString substringWithRange:range];
    // Scan values
    unsigned int r, g, b;
    
    [[NSScanner scannerWithString:rString] scanHexInt:&r];
    [[NSScanner scannerWithString:gString] scanHexInt:&g];
    [[NSScanner scannerWithString:bString] scanHexInt:&b];
    
    return [UIColor colorWithRed:((float) r / 255.0f)
                           green:((float) g / 255.0f)
                            blue:((float) b / 255.0f)
                           alpha:1.0f];
}

+ (NSDictionary *)dictionaryWithJsonString:(NSString *)jsonString {
    if (jsonString == nil) {
        return nil;
    }
    
    NSData *jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    NSError *err;
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData
                                                        options:NSJSONReadingMutableContainers
                                                          error:&err];
    if(err) {
        NSLog(@"json解析失败：%@",err);
        return nil;
    }
    return dic;
}

+ (UIImage *)getImageFromURL:(NSString *)fileURL {
    
    UIImage * result;
    
    if (fileURL != nil && ![fileURL isEqualToString:@""]) {
        NSData * data = [NSData dataWithContentsOfURL:[NSURL URLWithString:fileURL]];
        if (data) {
            result = [UIImage imageWithData:data];
        }else{
            result = [UIImage imageNamed:@"avatar"];
        }
    }else{
        result = [UIImage imageNamed:@"avatar"];
    }
    
    return result;
    
}

+ (NSString *)getDateStringWithDate:(NSDate *)date DateFormat:(NSString *)formatString
{
    
    ////yyyy-MM-dd HH:mm:ss
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:formatString];
    NSString *dateString = [dateFormat stringFromDate:date];
    return dateString;
}

@end
