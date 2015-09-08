//
//  RegisterData.h
//  DuoMeiXing
//
//  Created by 天陨 on 15/9/8.
//  Copyright (c) 2015年 wake. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RequstData.h"
#import "Singleton.h"

@interface RegisterData : NSObject

SINGLETON_INTERFACE(RegisterData);

@property(strong, nonatomic)RequestRegister* reqRegister;

@end
