//
//  Model.h
//  DuoMeiXing
//
//  Created by 天陨 on 15/8/2.
//  Copyright (c) 2015年 wake. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DNADef.h"

@interface Model : NSObject

@end


@interface BaseOptionModel : NSObject

@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *icon;
@property (nonatomic, assign) NSUInteger ctrl;

@end

@interface CollectionOptionModel : BaseOptionModel
@property (nonatomic, copy) NSArray *collection;
+ (NSArray *)resultOption;
@end

@interface PopoverOptionModel : CollectionOptionModel

@end

@interface DiscoverOptionModel : CollectionOptionModel

@end

@interface MineOptionModel : CollectionOptionModel

@end

@interface SettingOptionModel : CollectionOptionModel

@end

@interface AccountOptionModel : CollectionOptionModel

@end

@interface PACHotOptionModel : CollectionOptionModel

@end

@interface PACTeachingOptionModel : CollectionOptionModel

@end

@interface PACMyVideoOptionModel : CollectionOptionModel

@end
