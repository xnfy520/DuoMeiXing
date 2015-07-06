/*
专门用来保存单例代码
 最后一行不要加 \ 
*/

// @interface
#define SINGLETON_INTERFACE(className) \
+ (className *)shared##className;


// @implementation
#define SINGLETON_IMPLEMENTATION(className) \
static className *_instance; \
+ (id)allocWithZone:(NSZone *)zone \
{ \
    static dispatch_once_t onceToken; \
    dispatch_once(&onceToken, ^{ \
        _instance = [super allocWithZone:zone]; \
    }); \
    return _instance; \
} \
+ (className *)shared##className \
{ \
    static dispatch_once_t onceToken; \
    dispatch_once(&onceToken, ^{ \
        _instance = [[self alloc] init]; \
    }); \
    return _instance; \
}