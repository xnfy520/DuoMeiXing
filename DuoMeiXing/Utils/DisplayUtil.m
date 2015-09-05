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

+ (CGSize)getSize:(CGFloat)fontSize withString:(NSString *)fontText withWidth:(CGFloat)width
{
    CGSize textSize = [fontText boundingRectWithSize:CGSizeMake(width, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName: [UIFont systemFontOfSize:fontSize]} context:nil].size;
    return textSize;
}

+ (NSString *)convertWithBytes:(CGFloat)bytes
{
     NSString *filesize;
    if(bytes >= 1073741824) {
        filesize = [NSString stringWithFormat:@"%.2fGB", round(bytes / 1073741824 * 100) / 100];
    }else if(bytes >= 1048576){
        filesize = [NSString stringWithFormat:@"%.2fMB", round(bytes / 1048576 * 100) / 100];
    }else if(bytes >= 1024){
        filesize = [NSString stringWithFormat:@"%.2fKB", round(bytes / 1024 * 100) / 100];
    }else{
        filesize = [NSString stringWithFormat:@"%.2fB", bytes];
    }
    return filesize;
}

+ (UIColor *)colorWithHex:(NSString *)string
{
    NSString *cleanString = [string stringByReplacingOccurrencesOfString:@"#" withString:@""];
    if([cleanString length] == 3) {
        cleanString = [NSString stringWithFormat:@"%@%@%@%@%@%@",
                       [cleanString substringWithRange:NSMakeRange(0, 1)],[cleanString substringWithRange:NSMakeRange(0, 1)],
                       [cleanString substringWithRange:NSMakeRange(1, 1)],[cleanString substringWithRange:NSMakeRange(1, 1)],
                       [cleanString substringWithRange:NSMakeRange(2, 1)],[cleanString substringWithRange:NSMakeRange(2, 1)]];
    }
    if([cleanString length] == 6) {
        cleanString = [cleanString stringByAppendingString:@"ff"];
    }
    
    unsigned int baseValue;
    [[NSScanner scannerWithString:cleanString] scanHexInt:&baseValue];
    
    float red = ((baseValue >> 24) & 0xFF)/255.0f;
    float green = ((baseValue >> 16) & 0xFF)/255.0f;
    float blue = ((baseValue >> 8) & 0xFF)/255.0f;
    
    return [UIColor colorWithRed:red green:green blue:blue alpha:1.0];
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

+ (NSString *)getDateStringWithDate:(NSNumber*)time withDateFormat:(NSString *)formatString
{
    NSDate * date = [NSDate dateWithTimeIntervalSince1970:([time doubleValue]/1000)];
    
    return [DisplayUtil getDateStringWithDate:date DateFormat:formatString];
}

+ (NSString *)getDateStringWithDate:(NSDate *)date DateFormat:(NSString *)formatString
{
    
    ////yyyy-MM-dd HH:mm:ss
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:formatString];
    NSString *dateString = [dateFormat stringFromDate:date];
    return dateString;
}

+ (NSString *)stringWithOptionCtrlType:(NSUInteger)type
{
    NSString *typeString;
    switch (type) {
            
        case kOptionCtrlTypeGame:
            typeString = @"比赛";
            break;
        case kOptionCtrlTypeNewest:
            typeString = @"最新";
            break;
        case kOptionCtrlTypeTopPaly:
            typeString = @"最热播放";
            break;
        case kOptionCtrlTypeTopComment:
            typeString = @"最热评论";
            break;
        case kOptionCtrlTypeTeachingTgita:
            typeString = @"吉他教材";
            break;
        case kOptionCtrlTypeTeachingPiano:
            typeString = @"钢琴教材";
            break;
        case kOptionCtrlTypeTeachingEgita:
            typeString = @"电吉他教材";
            break;
        case kOptionCtrlTypeTeachingViolin:
            typeString = @"小提琴教材";
            break;
        case kOptionCtrlTypeMyPublished:
            typeString = @"发布成功";
            break;
        case kOptionCtrlTypeMyChecking:
            typeString = @"等待审核";
            break;
        case kOptionCtrlTypeMyUploading:
            typeString = @"正在上传";
            break;
        default:
            typeString = @"";
            break;
    }
    return typeString;
}

+ (NSString *)stringWithPhotographAlbumCategory:(NSUInteger)type
{
    NSString *typeString;
    switch (type) {
        case kPhotographAlbumCategoryHot:
            typeString = @"最热";
            break;
        case kPhotographAlbumCategoryTeaching:
            typeString = @"教材";
            break;
        case kPhotographAlbumCategoryMyVideo:
            typeString = @"我的视频";
            break;
        default:
            typeString = @"";
            break;
    }
    return typeString;
}

+ (BOOL)checkChinese:(NSString *)nString
{
    if(nString){
        for (int i=0; i<nString.length; i++) {
            NSRange range=NSMakeRange(i,1);
            NSString *subString=[nString substringWithRange:range];
            const char *cString=[subString UTF8String];
            if (strlen(cString)==3)
            {
                return YES;
            }else if(strlen(cString)==1)
            {
                return NO;
            }
        }
    }
    return NO;
}

- (BOOL)isPureInt:(NSString*)string{
    NSScanner* scan = [NSScanner scannerWithString:string];
    int val;
    return[scan scanInt:&val] && [scan isAtEnd];
}

@end
