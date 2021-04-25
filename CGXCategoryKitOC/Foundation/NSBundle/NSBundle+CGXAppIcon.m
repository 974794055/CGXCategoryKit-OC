//
//  NSBundle+CGXAppIcon.m
//  CGXCategoryKit-OC
//
//  Created by CGX on 2020/10/01.
//  Copyright © 2020 CGX. All rights reserved.
//

#import "NSBundle+CGXAppIcon.h"
#import <CommonCrypto/CommonDigest.h>
@implementation NSBundle (CGXAppIcon)
- (NSString *)gx_appIconPath
{
    NSDictionary *infoDict = [[NSBundle mainBundle] infoDictionary];
    //获取app中所有icon名字数组
    NSArray *iconsArr = infoDict[@"CFBundleIcons"][@"CFBundlePrimaryIcon"][@"CFBundleIconFiles"];
    //取最后一个icon的名字
    NSString *iconLastName = [iconsArr lastObject];
    //打印icon名字
//    NSLog(@"iconsArr: %@", iconsArr);
//    NSLog(@"iconLastName: %@", iconLastName);
    /*
     打印日志：
     iconsArr: (
     AppIcon29x29,
     AppIcon40x40,
     AppIcon60x60
     )
     iconLastName: AppIcon60x60
     */
    return iconLastName;
}


- (UIImage*)gx_appIcon
{
    UIImage*appIcon = [UIImage imageNamed:[self gx_appIconPath]];
    return appIcon;
}

+ (NSString *)gx_getApplicationName
{
    NSDictionary *infoDictionary = [[self mainBundle] infoDictionary];
    NSString *app_Name = [infoDictionary objectForKey:@"CFBundleName"];
    return app_Name;
}

+ (NSString *)gx_getApplicationVersion
{
    NSDictionary *infoDictionary = [[self mainBundle] infoDictionary];
    NSString *app_Version = [infoDictionary objectForKey:@"CFBundleShortVersionString"];
    return app_Version;
}

+ (NSString *)gx_getBundleID
{
    return [[self mainBundle] bundleIdentifier];
}

+ (NSString *)gx_getBuildVersion
{
    NSDictionary *infoDictionary = [[self mainBundle] infoDictionary];
    NSString *app_Build = [infoDictionary objectForKey:@"CFBundleVersion"];
    return app_Build;
}

+ (BOOL)gx_currentAppVersionIsUpdateWith:(NSString *)newVersion
{
    NSString *currentVersion = [NSBundle gx_getApplicationVersion];
    BOOL flag = [newVersion compare:currentVersion options:NSNumericSearch] == NSOrderedDescending;
    return flag;
}

+ (NSString *)gx_pathWithFileName:(NSString *)fileName podName:(NSString *)podName ofType:(NSString *)ext{
    
    if (!fileName ) {
        return nil;
    }
    NSBundle * pod_bundle =[self gx_bundleWithPodName:podName];
    if (!pod_bundle) {
        return nil;
    }
    if (!pod_bundle.loaded) {
        [pod_bundle load];
    }
    NSString *filePath =[pod_bundle pathForResource:fileName ofType:ext];
    return filePath;
}


+ (NSBundle *)gx_bundleWithPodName:(NSString *)podName{
    if (!podName) {
        return [NSBundle mainBundle];
    }
    NSBundle * bundle = [NSBundle bundleForClass:NSClassFromString(podName)];
    NSURL * url = [bundle URLForResource:podName withExtension:@"bundle"];
    if (!url) {
        NSArray *frameWorks = [NSBundle allFrameworks];
        BOOL isContain = false;
        for (NSBundle *tempBundle in frameWorks) {
            url = [tempBundle URLForResource:podName withExtension:@"bundle"];
            if (url) {
                bundle =[NSBundle bundleWithURL:url];
                if (!bundle.loaded) {
                    [bundle load];
                }
                return bundle;
            }
        }
        if (!isContain) {
            return [NSBundle mainBundle];
        }
    }else{
        bundle =[NSBundle bundleWithURL:url];
        return bundle;
    }
    return nil;
}

+ (NSBundle *)gx_bundleWithBundleName:(NSString *)bundleName{
    if (!bundleName) {
        return [NSBundle mainBundle];
    }
    
    NSString *bundlePath = [NSBundle mainBundle].bundlePath;
    bundlePath = [NSString stringWithFormat:@"%@/%@.bundle",bundlePath,bundleName];
    NSURL *url;
    if (@available(iOS 9.0,*)) {
        NSString *charactersToEscape = @"?!@#$^&%*+,:;='\"`<>()[]{}/\\| ";
        NSCharacterSet *allowedCharacters = [[NSCharacterSet characterSetWithCharactersInString:charactersToEscape] invertedSet];
        url = [NSURL URLWithString:[[NSString stringWithFormat:@"file://%@",bundlePath] stringByAddingPercentEncodingWithAllowedCharacters:allowedCharacters]];
    }else
    {
        url = [NSURL URLWithString:[[NSString stringWithFormat:@"file://%@",bundlePath] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    }
    NSBundle *bundle =[NSBundle bundleWithURL:url];
    return bundle;
}

+ (NSString *)gx_filePathWithBundleName:(NSString *)bundleName fileName:(NSString *)fileName podName:(NSString *)podName{
    if (!podName) {
        NSBundle *bundle = [self gx_bundleWithBundleName:bundleName];
        NSString *filePath = [bundle pathForResource:fileName ofType:nil];
        return filePath;
    }
    
    NSBundle *pod_bundle = [self gx_bundleWithPodName:podName];
    if (!bundleName) {
        NSString *filePath = [pod_bundle pathForResource:fileName ofType:nil];
        return filePath;
    }
    
    NSString *bundlePath = pod_bundle.bundlePath;
    bundlePath = [NSString stringWithFormat:@"%@/%@.bundle",bundlePath,podName];
    NSURL *url;
    if (@available(iOS 9.0,*)) {
        NSString *charactersToEscape = @"?!@#$^&%*+,:;='\"`<>()[]{}/\\| ";
        NSCharacterSet *allowedCharacters = [[NSCharacterSet characterSetWithCharactersInString:charactersToEscape] invertedSet];
        
        url = [NSURL URLWithString:[[NSString stringWithFormat:@"file://%@/%@.bundle",bundlePath,bundleName] stringByAddingPercentEncodingWithAllowedCharacters:allowedCharacters]];
    }else
    {
        url = [NSURL URLWithString:[[NSString stringWithFormat:@"file://%@/%@.bundle",bundlePath,bundleName] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    }
    NSBundle *bundle =[NSBundle bundleWithURL:url];
    if (bundle) {
        NSString *filePath = [bundle pathForResource:fileName ofType:nil];
        return filePath;
    }
    return nil;
}

+ (NSURL *)gx_fileURLWithBundleName:(NSString *)bundleName fileName:(NSString *)fileName podName:(NSString *)podName{
    NSString *filePath = [self gx_filePathWithBundleName:bundleName fileName:fileName podName:podName];
    NSString *fileURLStr = [NSString stringWithFormat:@"file://%@",filePath];
    NSURL *fileURL = [NSURL URLWithString:fileURLStr];
    if (!fileURL) {
        fileURLStr = [fileURLStr stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
        fileURL = [NSURL URLWithString:fileURLStr];
    }
    return fileURL;
}

+ (id)gx_loadNibName:(NSString *)nibName podName:(NSString *)podName{
    NSBundle *bundle =[self gx_bundleWithPodName:podName];
    if (!bundle) {
        return nil;
    }
    id object = [[bundle loadNibNamed:nibName owner:nil options:nil] lastObject];
    return object;
}

+ (UIStoryboard *)gx_storyboardWithName:(NSString *)name podName:(NSString *)podName{
    NSBundle *bundle =[self gx_bundleWithPodName:podName];
    if (!bundle) {
        return nil;
    }
    UIStoryboard *storyBoard = [UIStoryboard storyboardWithName:name bundle:bundle];
    return storyBoard;
}

+ (UIImage *)gx_imageWithName:(NSString *)imageName podName:(NSString *)podName {
    NSBundle * pod_bundle =[self gx_bundleWithPodName:podName];
    if (!pod_bundle) {
        return nil;
    }
    if (!pod_bundle.loaded) {
        [pod_bundle load];
    }
    UIImage *image = [UIImage imageNamed:imageName inBundle:pod_bundle compatibleWithTraitCollection:nil];
    return image;
}

+ (NSString*)gx_fileMD5HashStringWithPath:(NSString*)filePath{
    return [self gx_fileMD5HashStringWithPath:filePath WithSize:1024 *8];
}

+ (NSString*)gx_fileMD5HashStringWithPath:(NSString*)filePath WithSize:(size_t)chunkSizeForReadingData{
    
    NSMutableString *result=nil;
    CFReadStreamRef readStream = NULL;
    
    // Get the file URL
    CFURLRef fileURL =
    CFURLCreateWithFileSystemPath(kCFAllocatorDefault,
                                  (CFStringRef)filePath,
                                  kCFURLPOSIXPathStyle,
                                  (Boolean)false);
    
    CC_MD5_CTX hashObject;
    bool hasMoreData = true;
    bool didSucceed;
    
    if (!fileURL) goto done;
    
    // Create and open the read stream
    readStream = CFReadStreamCreateWithFile(kCFAllocatorDefault,
                                            (CFURLRef)fileURL);
    if (!readStream) goto done;
    didSucceed = (bool)CFReadStreamOpen(readStream);
    if (!didSucceed) goto done;
    
    // Initialize the hash object
    CC_MD5_Init(&hashObject);
    
    // Make sure chunkSizeForReadingData is valid
    if (!chunkSizeForReadingData) {
        chunkSizeForReadingData = 1024*8;
    }
    
    // Feed the data to the hash object
    while (hasMoreData) {
        uint8_t buffer[chunkSizeForReadingData];
        CFIndex readBytesCount = CFReadStreamRead(readStream,
                                                  (UInt8 *)buffer,
                                                  (CFIndex)sizeof(buffer));
        if (readBytesCount == -1)break;
        if (readBytesCount == 0) {
            hasMoreData =false;
            continue;
        }
        CC_MD5_Update(&hashObject,(const void *)buffer,(CC_LONG)readBytesCount);
    }
    
    // Check if the read operation succeeded
    didSucceed = !hasMoreData;
    
    // Compute the hash digest
    unsigned char digest[CC_MD5_DIGEST_LENGTH];
    CC_MD5_Final(digest, &hashObject);
    
    // Abort if the read operation failed
    if (!didSucceed) goto done;
    result = [NSMutableString string];
    for(int i=0;i<CC_MD5_DIGEST_LENGTH;i++){
        [result appendFormat:@"%02x",digest[i]];
    }
    
done:
    
    if (readStream) {
        CFReadStreamClose(readStream);
        CFRelease(readStream);
    }
    if (fileURL) {
        CFRelease(fileURL);
    }
    return result;
}

+ (NSString *)gx_localizedStringForKey:(NSString *)key language:(NSString *)language{
    return [self gx_localizedStringForKey:key language:language podName:nil];
}

+ (NSString *)gx_localizedStringForKey:(NSString *)key language:(NSString *)language podName:(nullable NSString *)podName
{
    NSBundle *bundle = [NSBundle bundleWithPath:[[NSBundle gx_bundleWithPodName:podName] pathForResource:language ofType:@"lproj"]];
    NSString *value = [bundle localizedStringForKey:key value:nil table:nil];
    return [[NSBundle mainBundle] localizedStringForKey:key value:value table:nil];
}

+ (NSArray *)gx_getTotalBundle
{
    NSArray *arr = [[NSBundle mainBundle] URLsForResourcesWithExtension:@".bundle" subdirectory:nil];
    return arr;
}

+ (NSString *)gx_getPodResourcePathWith:(Class)cla fileName:(NSString *)fileName
{
    NSBundle *bundle = [NSBundle bundleForClass:cla];
    NSDictionary *bundleDic = bundle.infoDictionary;
    NSString *bundleName = [bundleDic objectForKey:@"CFBundleExecutable"];
    NSString *path = [bundle pathForResource:fileName ofType:nil inDirectory:[NSString stringWithFormat:@"%@.bundle",bundleName]];
    return path;
}



@end
