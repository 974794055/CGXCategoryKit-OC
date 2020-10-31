//
//  NSObject+CGXAddProperty..m
//  CGXCategoryKit-OC
//
//  Created by CGX on 2020/10/01.
//  Copyright © 2020年 CGX. All rights reserved.
//

#import "NSObject+CGXAddProperty.h"
#import <objc/runtime.h>
#import <objc/message.h>
//objc_getAssociatedObject和objc_setAssociatedObject都需要指定一个固定的地址，这个固定的地址值用来表示属性的key，起到一个常量的作用。
static const void *CGXStringProperty = &CGXStringProperty;
static const void *CGXIntegerProperty = &CGXIntegerProperty;
//static char IntegerProperty;
@implementation NSObject (CGXAddProperty)

@dynamic gx_stringProperty;
@dynamic gx_integerProperty;

//set
/**
 *  @brief  catgory runtime实现get set方法增加一个字符串属性
 */
-(void)setGx_stringProperty:(NSString *)gx_stringProperty{
    //use that a static const as the key
    objc_setAssociatedObject(self, CGXStringProperty, gx_stringProperty, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    //use that property's selector as the key:
    //objc_setAssociatedObject(self, @selector(stringProperty), stringProperty, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
//get
-(NSString *)gx_stringProperty{
    return objc_getAssociatedObject(self, CGXStringProperty);
}

//set
/**
 *  @brief  catgory runtime实现get set方法增加一个NSInteger属性
 */
-(void)setGx_integerProperty:(NSInteger)gx_integerProperty{
    NSNumber *number = [[NSNumber alloc]initWithInteger:gx_integerProperty];
    objc_setAssociatedObject(self,CGXIntegerProperty, number, OBJC_ASSOCIATION_ASSIGN);
}
//get
-(NSInteger)gx_integerProperty{
    return [objc_getAssociatedObject(self, CGXIntegerProperty) integerValue];
}



/**
 *  自动生成属性列表
 *
 *  @param dict JSON字典/模型字典
 */
+(void)gx_printPropertyWithDict:(NSDictionary *)dict{
    NSMutableString *proprety = [[NSMutableString alloc] init];
    //遍历数组 生成声明属性的代码，例如 @property (nonatomic, copy) NSString str
    //打印出来后 command+c command+v
    [dict enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
        NSString *str;
        
        NSLog(@"%@",[obj class]);
        //判断的不全，自行添加
        if ([obj isKindOfClass:NSClassFromString(@"__NSCFString")] || [obj isKindOfClass:NSClassFromString(@"NSTaggedPointerString")] || [obj isKindOfClass:NSClassFromString(@"__NSCFConstantString")]) {
            str = [NSString stringWithFormat:@"@property (nonatomic, strong) NSString *%@;",key];
        }
        if ([obj isKindOfClass:NSClassFromString(@"__NSCFNumber")]) {
            str = [NSString stringWithFormat:@"@property (nonatomic, assign) NSInteger %@;",key];
        }
        if ([obj isKindOfClass:NSClassFromString(@"__NSCFArray")] || [obj isKindOfClass:[NSArray class]]) {
            str = [NSString stringWithFormat:@"@property (nonatomic, strong) NSArray *%@;",key];
        }
        
        if ([obj isKindOfClass:NSClassFromString(@"__NSCFDictionary")] || [obj isKindOfClass:[NSDictionary class]]) {
            str = [NSString stringWithFormat:@"@property (nonatomic, strong) NSDictionary *%@;",key];
        }
        if ([obj isKindOfClass:NSClassFromString(@"__NSCFBoolean")]) {
            str = [NSString stringWithFormat:@"@property (nonatomic, assign) BOOL %@;",key];
        }
        
        [proprety appendFormat:@"\n%@\n",str];
        
        
    }];
    NSLog(@"%@",proprety);
}
/**
 *  自动给属性赋值
 *
 *  @param dict JSON字典/模型字典
 */
+ (instancetype)gx_setPropertyValuesWithDict:(NSDictionary *)dict
{
    //原理：利用runtime获取model的属性列表，然后从字典里面取出value给属性赋值
    
    // 创建实例对象
    id obj = [[self alloc] init];
    
    // 获取属性列表
    /**
     * class_copyIvarList(Class cls, unsigned int *outCount)  获取成员变量列表
     * class 获取那个类的属性
     * outCount 获取的属性总个数
     */
    unsigned int count = 0;
    Ivar *ivarList = class_copyIvarList(self, &count);
    
    //遍历属性列表
    for (int i = 0; i < count; i ++) {
        Ivar aivar = ivarList[i];
        
        //获取属性名字（带下划线）
        NSString *_propertyName = [NSString stringWithUTF8String:ivar_getName(aivar)];
        
        //获取属性type
        NSString *propertyType = [NSString stringWithUTF8String:ivar_getTypeEncoding(aivar)];
        
        //属性名字 不带下划线
        NSString *key = [_propertyName substringFromIndex:1];
        
        //通过属性名从字典里面取出value
        id  value = [dict objectForKey:key];
        
        /*二级model*/
        //当value时字典，并且属性是自定义的model，把字典（value）转换成model
        //当propertyType是自定义的model 那么此时 propertyType = @"@\"AddressModel\""，所以我们要截取字符串，把自定义的model名字取出来
        
        NSString *nsdictStr = @"@\"NSDictionary\"";
        if ([value isKindOfClass:[NSDictionary class] ] && ![propertyType isEqualToString:nsdictStr]) {
            NSRange range = [propertyType rangeOfString:@"\""];
            propertyType = [propertyType substringFromIndex:range.location + range.length];
            range = [propertyType rangeOfString:@"\""];
            propertyType = [propertyType substringToIndex:range.location];
            
            Class modelClass = NSClassFromString(propertyType);
            
            if (modelClass) {
                NSLog(@"propertyType == %@",propertyType);
                value = [modelClass gx_setPropertyValuesWithDict:value];
            }
            
        }
        
        if (value) {
            [obj setValue:value forKey:key];
        }
        
        
    }
    
    return obj;
}





static inline NSString *__rh_setter_selector_name_of_property(NSString *property)
{
    NSString *firstCharacter = [[property substringToIndex:1] uppercaseString];
    NSString *remainString = [property substringFromIndex:1];
    return [NSString stringWithFormat:@"set%@%@:", firstCharacter, remainString];
}

+ (void)gx_addObjectProperty:(NSString *)name
{
    [self gx_addObjectProperty:name associationPolicy:OBJC_ASSOCIATION_RETAIN_NONATOMIC];
}

+ (void)gx_addObjectProperty:(NSString *)name associationPolicy:(objc_AssociationPolicy)policy
{
    NSAssert(name.length > 0, @"property must not be empty in +gx_addObjectProperty:associationPolicy:");
    
    //1. 通过class的指针和property的name，创建一个唯一的key
    NSString *key = [NSString stringWithFormat:@"%p_%@",self,name];
    
    //2. 用block实现setter方法
    id setblock = ^(id self,id value){
        objc_setAssociatedObject(self, (__bridge void *)key, value, policy);
    };
    
    //3. 将block的实现转化为IMP
    IMP imp = imp_implementationWithBlock(setblock);
    
    //4. 用name拼接出setter方法
    NSString *selString = __rh_setter_selector_name_of_property(name);
    
    //5. 将setter方法加入到class中
    BOOL result = class_addMethod([self class], NSSelectorFromString(selString), imp, "v@:@");
    assert(result);
    
    //6. getter
    id getBlock = ^id(id self){
        return objc_getAssociatedObject(self, (__bridge void*)key);
    };
    IMP getImp = imp_implementationWithBlock(getBlock);
    result = class_addMethod([self class], NSSelectorFromString(name), getImp, "@@:");
    assert(result);
}

+ (void)gx_addBasicProperty:(NSString *)name encodingType:(char *)type
{
    NSAssert(name.length > 0, @"property must not be empty in +gx_addBasicProperty:encodingType:");
    
    if (strcmp(type, @encode(id)) == 0) {
        [self gx_addObjectProperty:name];
    }
    NSString *key = [NSString stringWithFormat:@"%p_%@",self,name];
    id setblock;
    id getBlock;
#define blockWithCaseType(C_TYPE)                               \
if (strcmp(type, @encode(C_TYPE)) == 0) {                   \
setblock = ^(id self,C_TYPE var){                       \
NSValue *value = [NSValue value:&var withObjCType:type];\
objc_setAssociatedObject(self, (__bridge void *)key, value, OBJC_ASSOCIATION_RETAIN_NONATOMIC);  \
};                                                          \
getBlock = ^C_TYPE (id self){                               \
NSValue *value = objc_getAssociatedObject(self, (__bridge void*)key);   \
C_TYPE var;                                             \
[value getValue:&var];                                  \
return var;                                             \
};                                                          \
}
    blockWithCaseType(char);
    blockWithCaseType(unsigned char);
    blockWithCaseType(short);
    blockWithCaseType(int);
    blockWithCaseType(unsigned int);
    blockWithCaseType(long);
    blockWithCaseType(unsigned long);
    blockWithCaseType(long long);
    blockWithCaseType(float);
    blockWithCaseType(double);
    blockWithCaseType(BOOL);
    
    blockWithCaseType(CGPoint);
    blockWithCaseType(CGSize);
    blockWithCaseType(CGVector);
    blockWithCaseType(CGRect);
    blockWithCaseType(NSRange);
    blockWithCaseType(CFRange);
    blockWithCaseType(CGAffineTransform);
    blockWithCaseType(CATransform3D);
    blockWithCaseType(UIOffset);
    blockWithCaseType(UIEdgeInsets);
#undef blockWithCaseType
    
    NSAssert(setblock && getBlock, @"type is an unknown type in +gx_addBasicProperty:encodingType:");
    
    IMP setImp = imp_implementationWithBlock(setblock);
    NSString *selString = __rh_setter_selector_name_of_property(name);
    NSString *setType = [NSString stringWithFormat:@"v@:%@",@(type)];
    BOOL result = class_addMethod([self class], NSSelectorFromString(selString), setImp, [setType UTF8String]);
    assert(result);
    
    IMP getImp = imp_implementationWithBlock(getBlock);
    NSString *getType = [NSString stringWithFormat:@"%@@:",@(type)];
    result = class_addMethod([self class], NSSelectorFromString(name), getImp, [getType UTF8String]);
    assert(result);
}
@end
