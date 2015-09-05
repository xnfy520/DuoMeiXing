//
//  Model.m
//  DuoMeiXing
//
//  Created by 天陨 on 15/8/2.
//  Copyright (c) 2015年 wake. All rights reserved.
//

#import "Model.h"


@implementation Model

@end


@implementation BaseOptionModel

@end


@implementation CollectionOptionModel

+ (NSDictionary *)objectClassInArray
{
    return @{
             @"collection" : @"BaseOptionModel"
             };
}

+ (NSArray *)resultOption
{
    return nil;
}

@end

@implementation PopoverOptionModel

+ (NSArray *)resultOption
{
    NSArray *array = @[
                        @{
                            @"title":@"上传视频",
                            @"icon":@"plus_video",
                            @"ctrl":@(kOptionCtrlTypePopoverVideo)
                        },
                        @{
                            @"title":@"扫一扫",
                            @"icon":@"plus_scan",
                            @"ctrl":@(kOptionCtrlTypePopoverScan)
                        },
                        @{
                            @"title":@"添加朋友",
                            @"icon":@"plus_friend",
                            @"ctrl":@(kOptionCtrlTypePopoverFriend)
                        }
                       ];
    return [self objectArrayWithKeyValuesArray:array];
    
}

@end

@implementation DiscoverOptionModel

+ (NSArray *)resultOption
{
    NSArray *array = @[
                       @[
                           @{
                               @"title":@"比赛",
                               @"icon":@"home_disc_game",
                               @"ctrl":@(kOptionCtrlTypeGame)
                               }
                           ],
                       @[
                           @{
                               @"title":@"最新",
                               @"icon":@"home_disc_last",
                               @"ctrl":@(kOptionCtrlTypeNewest)
                               },
                           @{
                               @"title":@"最热",
                               @"icon":@"home_disc_hot",
                               @"ctrl":@(kOptionCtrlTypeHot)
                               }
                           ],
                       @[
                           @{
                               @"title":@"大师",
                               @"icon":@"home_disc_mentor",
                               @"ctrl":@(kOptionCtrlTypeMentorAll)
                            },
                           @{
                               @"title":@"专业老师",
                               @"icon":@"home_disc_teacher",
                               @"ctrl":@(kOptionCtrlTypeTeacherAll)
                               
                               }
                           ],
                       @[
                           @{
                               @"title":@"乐器",
                               @"icon":@"home_disc_instrument",
                               @"ctrl":@(kOptionCtrlTypeInstrument)
                               }
                           ],
                       @[
                           @{
                               @"title":@"教材",
                               @"icon":@"home_disc_teaching",
                               @"ctrl":@(kOptionCtrlTypeTeaching)
                               }
                           ]
                       ];
    return [self objectArrayWithKeyValuesArray:array];
    
}

@end

@implementation MineOptionModel

+ (NSArray *)resultOption
{
    NSArray *array = @[
                       @[
                           @{
                               @"title":@"帐户",
                               @"ctrl":@(kOptionCtrlTypeAccount),
                               @"icon":@""
                               }
                           ],
                       @[
                           @{
                               @"title":@"影集",
                               @"ctrl":@(kOptionCtrlTypePhotographAlbum),
                               @"icon":@"home_me_video"
                               }
                           ],
                       @[
                           @{
                               @"title":@"设置",
                               @"ctrl":@(kOptionCtrlTypeSettings),
                               @"icon":@"home_me_settings"
                               }
                           ],
                       @[
                           @{
                               @"title":@"订单",
                               @"ctrl":@(kOptionCtrlTypeOrder),
                               @"icon":@"home_me_order"
                               }
                           ]
                       ];;
    return [self objectArrayWithKeyValuesArray:array];
    
}

@end

@implementation SettingOptionModel

+ (NSArray *)resultOption
{
    NSArray *array = @[
                       @[
                           @{
                               @"title":@"关于哆每星",
                               @"ctrl":@(kOptionCtrlTypeAbout)
                               },
                           @{
                               @"title":@"检查更新",
                               @"ctrl":@(kOptionCtrlTypeUpdate)
                               }
                           ],
                       @[
                           @{
                               @"title":@"退出登录",
                               @"ctrl":@(kOptionCtrlTypeExit)
                               }
                           ]
                       ];
    return [self objectArrayWithKeyValuesArray:array];
    
}

@end


@implementation AccountOptionModel

+ (NSArray *)resultOption
{
    NSArray *array = @[
                       @[
                           @{
                               @"title":@"头像",
                               @"ctrl":@(kOptionCtrlTypeAvatar)
                               }
                           ],
                       @[
                           @{
                               @"title":@"昵称",
                               @"ctrl":@(kOptionCtrlTypeNickname)
                               }
                           ]
                       ];
    return [self objectArrayWithKeyValuesArray:array];
    
}

@end

@implementation PACHotOptionModel

+ (NSArray *)resultOption
{
    NSArray *array = @[
                       @{
                           @"title":@"最热播放",
                           @"icon":@"video_top_play",
                           @"ctrl":@(kOptionCtrlTypeTopPaly)
                           },
                       @{
                           @"title":@"最热评论",
                           @"icon":@"video_top_comment",
                           @"ctrl":@(kOptionCtrlTypeTopComment)
                           }
                       ];
    return [self objectArrayWithKeyValuesArray:array];
    
}

@end

@implementation PACTeachingOptionModel

+ (NSArray *)resultOption
{
    NSArray *array = @[
                       @{
                           @"title":@"民谣吉他教材",
                           @"icon":@"home_disc_teaching_tgita",
                           @"ctrl":@(kOptionCtrlTypeTeachingTgita)
                           },
                       @{
                           @"title":@"钢琴教材",
                           @"icon":@"home_disc_teaching_piano",
                           @"ctrl":@(kOptionCtrlTypeTeachingPiano)
                           },
                       @{
                           @"title":@"电吉他教材",
                           @"icon":@"home_disc_teaching_egita",
                           @"ctrl":@(kOptionCtrlTypeTeachingEgita)
                           },
                       @{
                           @"title":@"小提琴教材",
                           @"icon":@"home_disc_teaching_violin",
                           @"ctrl":@(kOptionCtrlTypeTeachingViolin)
                           }
                       ];
    return [self objectArrayWithKeyValuesArray:array];
    
}

@end

@implementation PACMyVideoOptionModel

+ (NSArray *)resultOption
{
    NSArray *array = @[
                       @{
                           @"title":@"发布成功",
                           @"icon":@"video_my_published",
                           @"ctrl":@(kOptionCtrlTypeMyPublished)
                           },
                       @{
                           @"title":@"等待审核",
                           @"icon":@"video_my_checking",
                           @"ctrl":@(kOptionCtrlTypeMyChecking)
                           },
                       @{
                           @"title":@"正在上传",
                           @"icon":@"video_my_uploading",
                           @"ctrl":@(kOptionCtrlTypeMyUploading)
                           }
                       ];
    return [self objectArrayWithKeyValuesArray:array];
    
}

@end

