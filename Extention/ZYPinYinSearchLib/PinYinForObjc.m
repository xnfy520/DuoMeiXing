//
//  PinYinForObjc.m
//  Search
//
//  Created by LYZ on 14-1-24.
//  Copyright (c) 2014年 LYZ. All rights reserved.
//

#import "PinYinForObjc.h"
#import "ChineseInclude.h"
#import "NSString+PinYin4Cocoa.h"

@implementation PinYinForObjc

+ (NSString*)chineseConvertToPinYin:(NSString*)chinese {
    NSString *sourceText = chinese;
    HanyuPinyinOutputFormat *outputFormat = [[HanyuPinyinOutputFormat alloc] init];
    [outputFormat setToneType:ToneTypeWithoutTone];
    [outputFormat setVCharType:VCharTypeWithV];
    [outputFormat setCaseType:CaseTypeLowercase];
    NSString *outputPinyin = [PinyinHelper toHanyuPinyinStringWithNSString:sourceText withHanyuPinyinOutputFormat:outputFormat withNSString:@""];
    
    return outputPinyin;
    
    
}

+ (NSString*)chineseConvertToPinYinHead:(NSString *)chinese {
    HanyuPinyinOutputFormat *outputFormat = [[HanyuPinyinOutputFormat alloc] init];
    [outputFormat setToneType:ToneTypeWithoutTone];
    [outputFormat setVCharType:VCharTypeWithV];
    [outputFormat setCaseType:CaseTypeLowercase];
    NSMutableString *outputPinyin = [[NSMutableString alloc] init];
    for (int i=0;i <chinese.length;i++) {
        NSString *mainPinyinStrOfChar = [PinyinHelper getFirstHanyuPinyinStringWithChar:[chinese characterAtIndex:i] withHanyuPinyinOutputFormat:outputFormat];
        if (nil!=mainPinyinStrOfChar) {
            [outputPinyin appendString:[mainPinyinStrOfChar substringToIndex:1]];
        } else {
            break;
        }
    }
    return outputPinyin;
}

+ (NSString*)chineseConvertToPinYinHeadFirst:(NSString *)chinese {
    
    NSRange range=NSMakeRange(0,1);
    NSString *subString=[chinese substringWithRange:range];
    
    if ([ChineseInclude isIncludeChineseInString:subString]) {
        NSLog(@"is chinese");
        
        
        HanyuPinyinOutputFormat *outputFormat = [[HanyuPinyinOutputFormat alloc] init];
        [outputFormat setToneType:ToneTypeWithoutTone];
        [outputFormat setVCharType:VCharTypeWithV];
        [outputFormat setCaseType:CaseTypeUppercase];
        NSMutableString *outputPinyin = [[NSMutableString alloc] init];
        
        NSString *mainPinyinStrOfChar = [PinyinHelper getFirstHanyuPinyinStringWithChar:[chinese characterAtIndex:0] withHanyuPinyinOutputFormat:outputFormat];
        
        if (nil!=mainPinyinStrOfChar) {
            [outputPinyin appendString:[mainPinyinStrOfChar substringToIndex:1]];
        } else {
            return @"#";
        }
        
        return outputPinyin;
        
    }else if([subString matchesPatternRegexPattern:@"^[A-Za-z]+$"]){
    //NSString *regex = @"[A-Za-z]+";
        NSLog(@"is abc");
        
        return [subString uppercaseString];
        
    }else{
        
        NSLog(@"is other");
        return @"#";
    }

}

@end
