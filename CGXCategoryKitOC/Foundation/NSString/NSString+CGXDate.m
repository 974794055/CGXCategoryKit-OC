//
//  NSString+CGXDate.m
//  CGXCategoryKit-OC
//
//  Created by CGX on 2020/10/01.
//  Copyright © 2020年 CGX. All rights reserved.
//

#import "NSString+CGXDate.h"

@implementation NSString (CGXDate)

+ (NSString *)gx_compareCurrentBeforeTimeStampString:(NSString *)timeStampString
{
    
    return  [self gx_compareCurrentBeforeTimeDateFromString: [self dateWithStringTimeStampString:timeStampString]];
}
+ (NSString *)gx_compareCurrentBeforeTimeDate:(NSDate *)newDate
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSString *dateString = [formatter stringFromDate: newDate];
    return [self gx_compareCurrentBeforeTimeDateFromString:dateString];
}
+ (NSString *)gx_compareCurrentBeforeTimeDateFromString:(NSString *)timeStr
{
    return  [self gx_compareCurrentBeforeTimeDateFromString:timeStr DateFormat:@"yyyy-MM-dd HH:mm:ss"];
}
+ (NSString *)gx_compareCurrentBeforeTimeDateFromString:(NSString *)timeStr DateFormat:(NSString *)dateFormat
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:dateFormat];
    NSDate *timeDate = [dateFormatter dateFromString:timeStr];
    //八小时时区
    NSTimeZone *zone = [NSTimeZone systemTimeZone];
    NSInteger interval = [zone secondsFromGMTForDate: timeDate];
    NSDate *mydate = [timeDate  dateByAddingTimeInterval: interval];
    NSDate *nowDate =[[NSDate date]  dateByAddingTimeInterval: interval];
    //    两个时间间隔
    NSTimeInterval timeInterval= [mydate timeIntervalSinceDate:nowDate];
    timeInterval = -timeInterval;
    long temp = 0;
    NSString *result;
    if (timeInterval < 60) {
        result = [NSString stringWithFormat:@"刚刚"];
    }
    else if((temp = timeInterval/60) <60){
        result = [NSString stringWithFormat:@"%ld分钟前",temp];
    }
    else if((temp = timeInterval/(60*60)) <24){
        result = [NSString stringWithFormat:@"%ld小时前",temp];
    }
    else if((temp = timeInterval/(24 * 60 * 60)) <30){
        result = [NSString stringWithFormat:@"%ld天前",temp];
    } else if((temp = timeInterval/(30 * 24 * 60 * 60)) <12){
        result = [NSString stringWithFormat:@"%ld月前",temp];
    } else{
        temp = timeInterval/(365 * 24 * 60 * 60);
        result = [NSString stringWithFormat:@"%ld年前",temp];
    }
    return  result;
}
+ (NSString *)gx_compareCurrentAfterTimeStampString:(NSString *)timeStampString
{
     return  [self gx_compareCurrentAfterTimeDateFromString: [self dateWithStringTimeStampString:timeStampString]];
}
+ (NSString *)gx_compareCurrentAfterTimeDate:(NSDate *)newDate
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSString *dateString = [formatter stringFromDate: newDate];
    return [self gx_compareCurrentAfterDayDateFromString:dateString];
}
+ (NSString *)gx_compareCurrentAfterTimeDateFromString:(NSString *)timeStr
{
    return  [self gx_compareCurrentAfterTimeDateFromString:timeStr DateFormat:@"yyyy-MM-dd HH:mm:ss"];
}
+ (NSString *)gx_compareCurrentAfterTimeDateFromString:(NSString *)timeStr DateFormat:(NSString *)dateFormat
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:dateFormat];
    NSDate *timeDate = [dateFormatter dateFromString:timeStr];
    //八小时时区
    NSTimeZone *zone = [NSTimeZone systemTimeZone];
    NSInteger interval = [zone secondsFromGMTForDate: timeDate];
    NSDate *mydate = [timeDate  dateByAddingTimeInterval: interval];
    NSDate *nowDate =[[NSDate date]  dateByAddingTimeInterval: interval];
    //    两个时间间隔
    NSTimeInterval timeInterval= [mydate timeIntervalSinceDate:nowDate];
    long temp = 0;
    NSString *result;
    if (timeInterval < 60) {
        result = [NSString stringWithFormat:@"刚刚"];
    }
    else if((temp = timeInterval/60) <60){
        result = [NSString stringWithFormat:@"%ld分钟后",temp];
    }
    else if((temp = timeInterval/(60*60)) <24){
        result = [NSString stringWithFormat:@"%ld小时后",temp];
    }
    else if((temp = timeInterval/(24 * 60 * 60)) <30){
        result = [NSString stringWithFormat:@"%ld天后",temp];
    } else if((temp = timeInterval/(30 * 24 * 60 * 60)) <12){
        result = [NSString stringWithFormat:@"%ld月后",temp];
    } else{
        temp = timeInterval/(365 * 24 * 60 * 60);
        result = [NSString stringWithFormat:@"%ld年后",temp];
    }
    return  result;
}
+ (NSString *)dateWithStringTimeStampString:(NSString *)timeStampString
{
    // iOS 生成的时间戳是10位
    NSTimeInterval interval    =[timeStampString doubleValue] / 1000.0;
    NSDate *date               = [NSDate dateWithTimeIntervalSince1970:interval];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSString *dateString       = [formatter stringFromDate: date];
    return dateString;
}

+ (NSString *)gx_compareCurrentAfterDayDateTimeStampString:(NSString *)timeStampString
{
    NSDateComponents *delta = [self creatrNSDateComponentsDateFromString:[self dateWithStringTimeStampString:timeStampString]];
    return [NSString stringWithFormat:@"%ld",delta.day];
}
+ (NSString *)gx_compareCurrentAfterDayDateFromString:(NSString *)dateFromString
{
    NSDateComponents *delta = [self creatrNSDateComponentsDateFromString:dateFromString];
    return [NSString stringWithFormat:@"%ld",delta.day];
}
+ (NSString *)gx_compareCurrentAfterDayDate:(NSDate *)newDate
{
    NSDateComponents *delta = [self creatrNSDateComponentsDate:newDate];
    return [NSString stringWithFormat:@"%ld",delta.day];
}
+ (NSString *)gx_compareCurrentAfterCountdownTimeStampString:(NSString *)timeStampString
{
    return [self gx_compareCurrentAfterCountdownDateFromString:[self dateWithStringTimeStampString:timeStampString]];
}
+ (NSString *)gx_compareCurrentAfterCountdownDateFromString:(NSString *)dateFromString
{
    //创建两个日期
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSDate *endDate = [dateFormatter dateFromString:dateFromString];
    //利用NSCalendar比较日期的差异
    NSCalendar *calendar = [NSCalendar currentCalendar];
    /**
     * 要比较的时间单位,常用如下,可以同时传：
     *    NSCalendarUnitDay : 天
     *    NSCalendarUnitYear : 年
     *    NSCalendarUnitMonth : 月
     *    NSCalendarUnitHour : 时
     *    NSCalendarUnitMinute : 分
     *    NSCalendarUnitSecond : 秒
     */
    NSCalendarUnit unit = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
    //比较的结果是NSDateComponents类对象
    NSDateComponents *delta = [calendar components:unit fromDate:[NSDate date] toDate:endDate options:0];
    
    NSMutableString *timeStr = [[NSMutableString alloc] initWithString:@""];
    if (delta.year>0) {
        [timeStr appendString:[NSString stringWithFormat:@"%ld年",delta.year]];
    }
    if (delta.month>0) {
        [timeStr appendString:[NSString stringWithFormat:@"%ld月",delta.month]];
    }
    if (delta.day>0) {
        [timeStr appendString:[NSString stringWithFormat:@"%ld天",delta.day]];
    }
    if (delta.hour>0) {
        [timeStr appendString:[NSString stringWithFormat:@"%ld时",delta.hour]];
    }
    if (delta.minute>0) {
        [timeStr appendString:[NSString stringWithFormat:@"%ld分",delta.minute]];
    }
    if (delta.second>0) {
        [timeStr appendString:[NSString stringWithFormat:@"%ld秒",delta.second]];
    }
    return timeStr;
}

+ (NSDateComponents *)creatrNSDateComponentsDateFromString:(NSString *)dateFromString
{
    //创建两个日期
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSDate *endDate = [dateFormatter dateFromString:dateFromString];
    return [self creatrNSDateComponentsDate:endDate];
}
+ (NSDateComponents *)creatrNSDateComponentsDate:(NSDate *)date
{
    //利用NSCalendar比较日期的差异
    NSCalendar *calendar = [NSCalendar currentCalendar];
    /**
     * 要比较的时间单位,常用如下,可以同时传：
     *    NSCalendarUnitDay : 天
     *    NSCalendarUnitYear : 年
     *    NSCalendarUnitMonth : 月
     *    NSCalendarUnitHour : 时
     *    NSCalendarUnitMinute : 分
     *    NSCalendarUnitSecond : 秒
     */
    NSCalendarUnit unit = NSCalendarUnitDay;//只比较天数差异
    //比较的结果是NSDateComponents类对象
    NSDateComponents *delta = [calendar components:unit fromDate:[NSDate date] toDate:date options:0];
    return delta;
}


- (NSString *)showTime:(NSInteger)timeString
{
    NSDate *date11 = [NSDate dateWithTimeIntervalSinceNow:timeString];
    NSDate *date12 = [NSDate dateWithTimeIntervalSinceNow:0];
    NSTimeInterval inter = [date11 timeIntervalSinceDate:date12];
    if (inter >= 0 && inter < 60) {
        return [NSString stringWithFormat:@"00:%d",(int)inter];
    } else if(inter >= 60 &&  inter < 3600) {
        
        int mm = (int)inter / 60;
        int ss = (int)inter % 60;
        if (ss >= 10) {
            return [NSString stringWithFormat:@"%d:%d",mm,ss];
        } else {
            return [NSString stringWithFormat:@"%d:0%d",mm,ss];
        }
    } else if (inter >= 3600 && inter < 24 * 3600) {
        
        int hh = (int)inter / 3600;
        int ttt = (int)inter % 3600;
        int mm = ttt / 60;
        int ss = ttt % 60;
        return [NSString stringWithFormat:@"%d:%d:%d",hh,mm,ss];
        
    } else if (inter >= 24 * 3600) {
        //        NSLog(@"已经超过一天了");
    }
    
    return nil;
}

+ (NSString *)gx_stringWithDataTimeStampString:(NSString *)timeStampString dateFormat:(NSString *)dateFormatString
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    [formatter setDateFormat:dateFormatString];
    NSDate*confromTimesp = [NSDate dateWithTimeIntervalSince1970:(NSTimeInterval)[timeStampString intValue]];
    NSString *confromTimespStr = [formatter stringFromDate:confromTimesp];
    return confromTimespStr;
}


+(NSString *)gx_compareOneDay:(NSDate *)oneDay withAnotherDay:(NSDate *)anotherDay
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSString *oneDayStr = [dateFormatter stringFromDate:oneDay];
    NSString *anotherDayStr = [dateFormatter stringFromDate:anotherDay];
    NSDate *dateA = [dateFormatter dateFromString:oneDayStr];
    NSDate *dateB = [dateFormatter dateFromString:anotherDayStr];
    NSComparisonResult result = [dateA compare:dateB];
    NSString *resultStr = @"0";
    if (result == NSOrderedDescending) {
        //NSLog(@"oneDay比 anotherDay时间晚");
        resultStr = @"1";
    } else if (result == NSOrderedAscending){
        //NSLog(@"oneDay比 anotherDay时间早");
        resultStr = @"-1";
    }
    //NSLog(@"两者时间是同一个时间");
    return resultStr;
    
}

+(NSString *)gx_stringWithTimeSwitchTimestamp:(NSString *)formatTime andFormatter:(NSString *)format
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    [formatter setDateFormat:format]; //(@"YYYY-MM-dd hh:mm:ss") ----------设置你想要的格式,hh与HH的区别:分别表示12小时制,24小时
    
    NSTimeZone* timeZone = [NSTimeZone timeZoneWithName:@"Asia/Beijing"];
    [formatter setTimeZone:timeZone];
    NSDate* date = [formatter dateFromString:formatTime]; //------------将字符串按formatter转成nsdate
    //时间转时间戳的方法:
    NSInteger timeSp = [[NSNumber numberWithDouble:[date timeIntervalSince1970]] integerValue];
    return [NSString stringWithFormat:@"%ld" ,(long)timeSp];
    
}




/** 时间戳--->年月日-时间 */
+ (NSString *)gx_convertToDateTime:(NSString *)timestamp {
    
    NSTimeInterval time = [timestamp doubleValue];
    NSDate *detaildate=[NSDate dateWithTimeIntervalSince1970:time];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm"];
    NSString *currentDateStr = [dateFormatter stringFromDate: detaildate];
    
    return currentDateStr;
}

/** 时间戳--->年月日 小时-分-秒 */
+ (NSString *)gx_convertToDateTimer:(NSString *)timestamp {
    
    NSTimeInterval time = [timestamp doubleValue];
    NSDate *detaildate=[NSDate dateWithTimeIntervalSince1970:time];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSString *currentDateStr = [dateFormatter stringFromDate: detaildate];
    
    return currentDateStr;
}

/** 时间戳--->日期 */
+ (NSString *)gx_convertToDate:(NSString *)timestamp {
    
    NSTimeInterval time = [timestamp doubleValue];//如果不使用本地时区,因为时差问题要加8小时 == 28800 sec
    NSDate *detaildate = [NSDate dateWithTimeIntervalSince1970:time];
    //实例化一个NSDateFormatter对象
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    //设定时间格式,这里可以设置成自己需要的格式
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    
    NSString *currentDateStr = [dateFormatter stringFromDate: detaildate];
    
    return currentDateStr;
}

//** 时间戳--->时间 */
+ (NSString *)gx_convertToTime:(NSString *)timestamp {
    
    NSTimeInterval time = [timestamp doubleValue];
    NSDate *detaildate=[NSDate dateWithTimeIntervalSince1970:time];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"HH:mm"];
    NSString *currentDateStr = [dateFormatter stringFromDate: detaildate];
    
    return currentDateStr;
}

/** 时间---->时间戳 */
+ (NSString *)gx_convertTotimeSp:(NSString *)timeStr {
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm"];
    NSDate *date = [dateFormatter dateFromString:timeStr];
    NSString *timestamp = [NSString stringWithFormat:@"%ld", (long)[date timeIntervalSince1970]];//时间戳
    
    return timestamp;
}

/**
 *  获得与当前时间的差距
 */
+ (NSString *)gx_timeDifferenceWithNowTimer:(NSString *)timerSp {
    
    // 获取当前时时间戳 1466386762.345715 十位整数 6位小数
    NSTimeInterval currentTime = [[NSDate date] timeIntervalSince1970];
    // 后台时间戳(后台返回的时间 一般是13位数字)
    NSTimeInterval createTime =[timerSp floatValue];
    // 时间差
    NSTimeInterval time = currentTime - createTime;
    
    //刚刚
    NSInteger small = time / 60;
    if (small <= 0) {
        return [NSString stringWithFormat:@"刚刚"];
    }
    
    //秒转分钟
    if (small < 60) {
        return [NSString stringWithFormat:@"%ld分钟前",(long)small];
    }
    
    // 秒转小时
    NSInteger hours = time/3600;
    if (hours<24) {
        return [NSString stringWithFormat:@"%ld小时前",(long)hours];
    }
    //秒转天数
    NSInteger days = time/3600/24;
    if (days < 30) {
        return [NSString stringWithFormat:@"%ld天前",(long)days];
    }
    //秒转月
    NSInteger months = time/3600/24/30;
    if (months < 12) {
        return [NSString stringWithFormat:@"%ld月前",(long)months];
    }
    //秒转年
    NSInteger years = time/3600/24/30/12;
    return [NSString stringWithFormat:@"%ld年前",(long)years];
    
    return [self gx_convertToDate:timerSp];
}

/** 时间戳转星座
 
 摩羯座 12月22日------1月19日
 水瓶座 1月20日-------2月18日
 双鱼座 2月19日-------3月20日
 白羊座 3月21日-------4月19日
 金牛座 4月20日-------5月20日
 双子座 5月21日-------6月21日
 巨蟹座 6月22日-------7月22日
 狮子座 7月23日-------8月22日
 处女座 8月23日-------9月22日
 天秤座 9月23日------10月23日
 天蝎座 10月24日-----11月21日
 射手座 11月22日-----12月21日
 
 */
+ (NSString *)gx_timestampToConstellation:(NSString *)timerSp {
    
    //计算月份
    NSString *date = [self gx_convertToDate:timerSp];
    NSString *retStr=@"";
    NSString *birthStr = [date substringFromIndex:5];
    int month=0;
    NSString *theMonth = [birthStr substringToIndex:2];
    if([[theMonth substringToIndex:0] isEqualToString:@"0"]){
        month = [[theMonth substringFromIndex:1] intValue];
    }else{
        month = [theMonth intValue];
    }
    //计算天数
    int day=0;
    NSString *theDay = [birthStr substringFromIndex:3];
    if([[theDay substringToIndex:0] isEqualToString:@"0"]){
        day = [[theDay substringFromIndex:1] intValue];
    }else {
        day = [theDay intValue];
    }
    
    if (month<1 || month>12 || day<1 || day>31){
        return @"错误日期格式!";
    }
    if(month==2 && day>29) {
        return @"错误日期格式!!";
    }else if(month==4 || month==6 || month==9 || month==11) {
        if (day>30) {
            return @"错误日期格式!!!";
        }
    }
    NSString *astroString = @"魔羯水瓶双鱼白羊金牛双子巨蟹狮子处女天秤天蝎射手魔羯";
    NSString *astroFormat = @"102123444543";
    retStr=[NSString stringWithFormat:@"%@",[astroString substringWithRange:NSMakeRange(month*2-(day < [[astroFormat substringWithRange:NSMakeRange((month-1), 1)] intValue] - (-19))*2,2)]];
    return [NSString stringWithFormat:@"%@座",retStr];
}

/** 根据时间戳算年龄 */
+ (NSString *)gx_timestampToAge:(NSString *)timerSp {
    
    NSString *dateString = [self gx_convertToDate:timerSp];
    NSString *year = [dateString substringWithRange:NSMakeRange(0, 4)];
    NSString *month = [dateString substringWithRange:NSMakeRange(5, 2)];
    NSString *day = [dateString substringWithRange:NSMakeRange(dateString.length-2, 2)];
    NSDate *nowDate = [NSDate date];
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierISO8601];
    NSDateComponents *compomemts = [calendar components:NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitWeekday | NSCalendarUnitDay fromDate:nowDate];
    NSInteger nowYear = compomemts.year;
    NSInteger nowMonth = compomemts.month;
    NSInteger nowDay = compomemts.day;
    
    // 计算年龄
    NSInteger userAge = nowYear - year.intValue - 1;
    if ((nowMonth > month.intValue) || (nowMonth == month.intValue && nowDay >= day.intValue)) {
        userAge++;
    }
    return [NSString stringWithFormat:@"%ld",(long)userAge];
}
+(NSString *)gx_dateToAge:(NSString *)bornString {
    
    NSDateFormatter *format = [[NSDateFormatter alloc] init];
    format.dateFormat = @"yyyy-MM-dd";
    NSDate *bornData = [format dateFromString:bornString];
    
    //获得当前系统时间
    NSDate *currentDate = [NSDate date];
    //获得当前系统时间与出生日期之间的时间间隔
    NSTimeInterval time = [currentDate timeIntervalSinceDate:bornData];
    //时间间隔以秒作为单位,求年的话除以60*60*24*356
    int age = ((int)time)/(3600*24*365);
    return [NSString stringWithFormat:@"%d",age];
}
/** 获取手机时间戳 */
+ (NSString *)gx_getCurrentTimeSp {
    
    NSDate *date = [NSDate date];
    NSString *timeSp = [NSString stringWithFormat:@"%ld", (long)[date timeIntervalSince1970]];
    
    return timeSp;
}

/** 获取网络时间戳*/
+ (NSString *)gx_getNetworkTimeSp {
    
    NSString *urlString = @"http://m.baidu.com";
    urlString = [urlString stringByAddingPercentEscapesUsingEncoding: NSUTF8StringEncoding];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setURL:[NSURL URLWithString: urlString]];
    [request setCachePolicy:NSURLRequestReloadIgnoringCacheData];
    [request setTimeoutInterval: 2];
    [request setHTTPShouldHandleCookies:FALSE];
    [request setHTTPMethod:@"GET"];
    NSHTTPURLResponse *response;
    [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:nil];
    
    NSString *date = [[response allHeaderFields] objectForKey:@"Date"];
    date = [date substringFromIndex:5];
    date = [date substringToIndex:[date length]-4];
    NSDateFormatter *dMatter = [[NSDateFormatter alloc] init];
    dMatter.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US"];
    [dMatter setDateFormat:@"dd MMM yyyy HH:mm:ss"];
    NSDate *netDate = [[dMatter dateFromString:date] dateByAddingTimeInterval:60*60*8];
    
    return [NSString stringWithFormat:@"%ld", (long)[netDate timeIntervalSince1970]];
}




#pragma mark - 这一年的这个月有多少天
+ (NSInteger)gx_isAllDayWithYear:(NSInteger)year month:(NSInteger)month {
    int day=0;
    switch(month){
        case 1:
            day += 31;
        case 2:{
            if(((year%4==0)&&(year%100!=0))||(year%400==0)){
                day+=29;
            }
            else{
                day+=28;
            }
        }
        case 3:
            day += 31;
        case 4:
            day += 30;
        case 5:
            day += 31;
        case 6:
            day += 30;
        case 7:
            day += 31;
        case 8:
            day += 31;
        case 9:
            day += 30;
        case 10:
            day += 31;
        case 11:
            day += 30;
        case 12:
            day += 31;
            break;
        default:
            break;
    }
    return day;
}
#pragma mark -- 获取当前后几天日期 周日
+ (NSMutableArray *)gx_currentDateLaterDate:(int)dayCount {
    NSMutableArray *dayMArr = [[NSMutableArray alloc] init];
    for (int i = 0; i < dayCount; i++) {
        //从现在开始的24小时
        NSTimeInterval secondsPerDay = i * 24 * 60 * 60;
        NSDate *curDate = [NSDate dateWithTimeIntervalSinceNow:secondsPerDay];
        
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"MM-dd"];
        
        NSDateFormatter *weekFormatter = [[NSDateFormatter alloc] init];
        [weekFormatter setDateFormat:@"EEEE"];//星期几 @"HH:mm 'on' EEEE MMMM d"];
        NSString *theWeek = [weekFormatter stringFromDate:curDate];
        
        //转换英文为中文
        NSString *chinaStr;
        if(theWeek){
            if ([theWeek isEqualToString:@"Monday"]||[theWeek isEqualToString:@"星期一"]) {
                chinaStr = @"周一";
            } else if ([theWeek isEqualToString:@"Tuesday"]||[theWeek isEqualToString:@"星期二"]){
                chinaStr = @"周二";
            } else if ([theWeek isEqualToString:@"Wednesday"]||[theWeek isEqualToString:@"星期三"]){
                chinaStr = @"周三";
            } else if ([theWeek isEqualToString:@"Thursday"]||[theWeek isEqualToString:@"星期四"]){
                chinaStr = @"周四";
            } else if ([theWeek isEqualToString:@"Friday"]||[theWeek isEqualToString:@"星期五"]){
                chinaStr = @"周五";
            } else if ([theWeek isEqualToString:@"Saturday"]||[theWeek isEqualToString:@"星期六"]){
                chinaStr = @"周六";
            } else if ([theWeek isEqualToString:@"Sunday"]||[theWeek isEqualToString:@"星期日"]){
                chinaStr = @"周日";
            }
        }
        
        //组合时间
        NSString *strTime = [NSString stringWithFormat:@"%@", chinaStr];
        [dayMArr addObject:strTime];
    }
    return dayMArr.copy;
}

#pragma mark -- 获取当前日期时间 2018-09-18 16:13:55
+ (NSString *)gx_currentDateTime {
    NSDateFormatter *formatter = [NSDateFormatter new];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    return [formatter stringFromDate:[NSDate date]];
}
#pragma  mark 根据格式获取当前时间,年月日/星期/
+ (NSString*)gx_currentDateTimesWithFormat:(NSString *)format {
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:format];
    NSDate *datenow = [NSDate date];
    NSString *currentTime = [formatter stringFromDate:datenow];
    return currentTime;
}
#pragma  mark 获取未来几天日期
+ (NSMutableArray *)gx_getDateDurationWithLaterDate:(int)dayCount {
    NSArray *_array;
    NSInteger _day = 0;
    NSInteger _month = 0;
    NSInteger _year = 0;

    NSString *currentDate = [NSString gx_currentDateTimesWithFormat:@"yyyy-MM-dd"];
    
    //年月日
    _array = [currentDate componentsSeparatedByString:@"-"];
    _day = [[_array lastObject] integerValue];
    _month = [_array[1] integerValue];
    _year = [[_array firstObject] integerValue];
    
    NSMutableArray *dateMarr = [[NSMutableArray alloc] init];
    for (int i = 0; i < dayCount; i ++) {
        //取出当月的天数
        NSInteger day = [NSString gx_isAllDayWithYear:_year month:_month] - [NSString gx_isAllDayWithYear:_year month:_month+1];
        if (_day > day) {
            _day = 1;
            _month ++;
            _year = (_month > 12) ? (_year+1) : _year;
            _month = _month > 12 ? 1 : _month;
        }
        NSString * string;
        string = [NSString stringWithFormat:@"%02ld-%02ld", _month, _day++];
        [dateMarr addObject:string];
    }
    return dateMarr.copy;
}

#pragma  mark 获取未来几天 年月日
+ (NSMutableArray *)gx_getDateDurationYearMD:(int)dayCount {
    NSArray *_array;
    NSInteger _day = 0;
    NSInteger _month = 0;
    NSInteger _year = 0;
    
    NSString *currentDate = [NSString gx_currentDateTimesWithFormat:@"yyyy-MM-dd"];
    
    //年月日
    _array = [currentDate componentsSeparatedByString:@"-"];
    _day = [[_array lastObject] integerValue];
    _month = [_array[1] integerValue];
    _year = [[_array firstObject] integerValue];
    
    NSMutableArray *dateMarr = [[NSMutableArray alloc] init];
    for (int i = 0; i < 7; i ++) {
        //取出当月的天数
        NSInteger day = [NSString gx_isAllDayWithYear:_year month:_month] - [NSString gx_isAllDayWithYear:_year month:_month+1];
        if (_day > day) {
            _day = 1;
            _month ++;
            _year = (_month > 12) ? (_year + 1) : _year;
            _month = _month > 12 ? 1 : _month;
            
        }
        NSString * string;
        
        string = [NSString stringWithFormat:@"%ld-%02ld-%02ld", _year, _month, _day++];
        
        [dateMarr addObject:string];
    }
    return dateMarr.copy;
}




+ (NSString*)gx_weekdayStringFromDate:(NSString *)inputDateString {
    
    NSDateFormatter *inputFormatter = [[NSDateFormatter alloc] init];
    [inputFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSDate *inputDate = [inputFormatter dateFromString:inputDateString];
    
    
    NSArray *weekdays = [NSArray arrayWithObjects: @"周日", @"周一", @"周二", @"周三", @"周四", @"周五", @"周六", nil];
    
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    
    NSTimeZone *timeZone = [[NSTimeZone alloc] initWithName:@"Asia/Shanghai"];
    
    [calendar setTimeZone: timeZone];
    
    NSCalendarUnit calendarUnit = NSCalendarUnitWeekday;
    
    NSDateComponents *theComponents = [calendar components:calendarUnit fromDate:inputDate];
    
    return [weekdays objectAtIndex:theComponents.weekday - 1];
}

@end
