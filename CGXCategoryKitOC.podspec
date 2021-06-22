Pod::Spec.new do |s|
    s.name         = "CGXCategoryKitOC"    #存储库名称
    s.version      = "0.1.4"      #版本号，与tag值一致
    s.summary      = "APP的Foundation、UIKit的延展库"  #简介
    s.description  = "APP的Foundation、UIKit控件延展库)"  #描述
    s.homepage     = "https://github.com/974794055/CGXCategoryKit-OC"      #项目主页，不是git地址
    s.license      = { :type => "MIT", :file => "LICENSE" }   #开源协议
    s.author             = { "974794055" => "974794055@qq.com" }  #作者
    s.platform     = :ios, "8.0"                  #支持的平台和版本号
    s.ios.deployment_target = '8.0'
    s.source       = { :git => "https://github.com/974794055/CGXCategoryKit-OC.git", :tag => s.version }         #存储库的git地址，以及tag值
    s.requires_arc = true #是否支持ARC
    s.frameworks = 'UIKit', 'CoreFoundation', 'CoreText', 'CoreGraphics', 'CoreImage', 'QuartzCore', 'ImageIO','Accelerate','CoreServices','SystemConfiguration','AdSupport','CoreLocation','Accelerate','UserNotifications'
    
    #需要托管的源代码路径
    s.source_files = 'CGXCategoryKitOC/CGXCategoryKitOC.h'
    #开源库头文件
    s.public_header_files = 'CGXCategoryKitOC/CGXCategoryKitOC.h'
    
    s.subspec 'Tools' do |ss|
        ss.source_files = 'CGXCategoryKitOC/Tools/**/*.{h,m}'
    end
    
    s.subspec 'Foundation' do |ss|
        ss.subspec 'NSTimer' do |sss|
            sss.source_files = 'CGXCategoryKitOC/Foundation/NSTimer/**/*.{h,m}'
        end
        ss.subspec 'NSBundle' do |sss|
            sss.source_files = 'CGXCategoryKitOC/Foundation/NSBundle/**/*.{h,m}'
        end
        ss.subspec 'UIColor' do |sss|
            sss.source_files = 'CGXCategoryKitOC/Foundation/UIColor/**/*.{h,m}'
        end
        ss.subspec 'UIDevice' do |sss|
            sss.source_files = 'CGXCategoryKitOC/Foundation/UIDevice/**/*.{h,m}'
        end
        ss.subspec 'NSNull' do |sss|
            sss.source_files = 'CGXCategoryKitOC/Foundation/NSNull/**/*.{h,m}'
        end
        ss.subspec 'NSDictionary' do |sss|
            sss.source_files = 'CGXCategoryKitOC/Foundation/NSDictionary/**/*.{h,m}'
        end
        
        ss.subspec 'NSNotificationCenter' do |sss|
            sss.source_files = 'CGXCategoryKitOC/Foundation/NSNotificationCenter/**/*.{h,m}'
        end
        ss.subspec 'NSFileManager' do |sss|
            sss.source_files = 'CGXCategoryKitOC/Foundation/NSFileManager/**/*.{h,m}'
        end
        ss.subspec 'UIFont' do |sss|
            sss.source_files = 'CGXCategoryKitOC/Foundation/UIFont/**/*.{h,m}'
        end
        ss.subspec 'NSIndexPath' do |sss|
            sss.source_files = 'CGXCategoryKitOC/Foundation/NSIndexPath/**/*.{h,m}'
        end
        ss.subspec 'NSRunLoop' do |sss|
            sss.source_files = 'CGXCategoryKitOC/Foundation/NSRunLoop/**/*.{h,m}'
        end
        ss.subspec 'NSMutableAttributedString' do |sss|
            sss.source_files = 'CGXCategoryKitOC/Foundation/NSMutableAttributedString/**/*.{h,m}'
        end
        ss.subspec 'UIImage' do |sss|
            sss.source_files = 'CGXCategoryKitOC/Foundation/UIImage/**/*.{h,m}'
        end
        ss.subspec 'NSHTTPCookieStorage' do |sss|
            sss.source_files = 'CGXCategoryKitOC/Foundation/NSHTTPCookieStorage/**/*.{h,m}'
        end
        ss.subspec 'NSFileHandle' do |sss|
            sss.source_files = 'CGXCategoryKitOC/Foundation/NSFileHandle/**/*.{h,m}'
        end
        ss.subspec 'NSException' do |sss|
            sss.source_files = 'CGXCategoryKitOC/Foundation/NSException/**/*.{h,m}'
        end
        ss.subspec 'NSArray' do |sss|
            sss.source_files = 'CGXCategoryKitOC/Foundation/NSArray/**/*.{h,m}'
            sss.dependency 'CGXCategoryKitOC/Foundation/NSObject'
        end
        
        ss.subspec 'NSData' do |sss|
            sss.source_files = 'CGXCategoryKitOC/Foundation/NSData/**/*.{h,m}'
        end
        ss.subspec 'NSNumber' do |sss|
            sss.source_files = 'CGXCategoryKitOC/Foundation/NSNumber/**/*.{h,m}'
        end
        ss.subspec 'NSURL' do |sss|
            sss.source_files = 'CGXCategoryKitOC/Foundation/NSURL/**/*.{h,m}'
        end
        ss.subspec 'NSString' do |sss|
            sss.source_files = 'CGXCategoryKitOC/Foundation/NSString/**/*.{h,m}'
        end
        ss.subspec 'NSObject' do |sss|
            sss.source_files = 'CGXCategoryKitOC/Foundation/NSObject/**/*.{h,m}'
        end
        ss.subspec 'NSUserDefaults' do |sss|
            sss.source_files = 'CGXCategoryKitOC/Foundation/NSUserDefaults/**/*.{h,m}'
            sss.dependency 'CGXCategoryKitOC/Foundation/NSObject'
        end
        ss.subspec 'NSCalendar' do |sss|
            sss.source_files = 'CGXCategoryKitOC/Foundation/NSCalendar/**/*.{h,m}'
        end
        ss.subspec 'NSDate' do |sss|
            sss.source_files = 'CGXCategoryKitOC/Foundation/NSDate/**/*.{h,m}'
            sss.dependency 'CGXCategoryKitOC/Foundation/NSCalendar'
            sss.dependency 'CGXCategoryKitOC/Tools'
        end
        ss.subspec 'NSSet' do |sss|
            sss.source_files = 'CGXCategoryKitOC/Foundation/NSSet/**/*.{h,m}'
        end
        
        
    end
    
    s.subspec 'UIKit' do |ss|
        ss.subspec 'UIWindow' do |sss|
            sss.source_files = 'CGXCategoryKitOC/UIKit/UIWindow/**/*.{h,m}'
        end
        ss.subspec 'WKWebView' do |sss|
            sss.source_files = 'CGXCategoryKitOC/UIKit/WKWebView/**/*.{h,m}'
        end
        ss.subspec 'UISegmentedControl' do |sss|
            sss.source_files = 'CGXCategoryKitOC/UIKit/UISegmentedControl/**/*.{h,m}'
        end
        ss.subspec 'UITableView' do |sss|
            sss.source_files = 'CGXCategoryKitOC/UIKit/UITableView/**/*.{h,m}'
        end
        ss.subspec 'UITableViewCell' do |sss|
            sss.source_files = 'CGXCategoryKitOC/UIKit/UITableViewCell/**/*.{h,m}'
        end
        ss.subspec 'UINavigationItem' do |sss|
            sss.source_files = 'CGXCategoryKitOC/UIKit/UINavigationItem/**/*.{h,m}'
        end
        ss.subspec 'UINavigationBar' do |sss|
            sss.source_files = 'CGXCategoryKitOC/UIKit/UINavigationBar/**/*.{h,m}'
        end
        ss.subspec 'UIBarButtonItem' do |sss|
            sss.source_files = 'CGXCategoryKitOC/UIKit/UIBarButtonItem/**/*.{h,m}'
        end
        ss.subspec 'UINavigationController' do |sss|
            sss.source_files = 'CGXCategoryKitOC/UIKit/UINavigationController/**/*.{h,m}'
        end
        ss.subspec 'UIScreen' do |sss|
            sss.source_files = 'CGXCategoryKitOC/UIKit/UIScreen/**/*.{h,m}'
        end
        ss.subspec 'UIApplication' do |sss|
            sss.source_files = 'CGXCategoryKitOC/UIKit/UIApplication/**/*.{h,m}'
        end
        ss.subspec 'UIResponder' do |sss|
            sss.source_files = 'CGXCategoryKitOC/UIKit/UIResponder/**/*.{h,m}'
        end
        ss.subspec 'UIButton' do |sss|
            sss.source_files = 'CGXCategoryKitOC/UIKit/UIButton/**/*.{h,m}'
        end
        ss.subspec 'UIImageView' do |sss|
            sss.source_files = 'CGXCategoryKitOC/UIKit/UIImageView/**/*.{h,m}'
        end
        ss.subspec 'UISplitViewController' do |sss|
            sss.source_files = 'CGXCategoryKitOC/UIKit/UISplitViewController/**/*.{h,m}'
        end
        ss.subspec 'UIView' do |sss|
            sss.source_files = 'CGXCategoryKitOC/UIKit/UIView/**/*.{h,m}'
        end
        ss.subspec 'UILabel' do |sss|
            sss.source_files = 'CGXCategoryKitOC/UIKit/UILabel/**/*.{h,m}'
        end
        ss.subspec 'UIImageView' do |sss|
            sss.source_files = 'CGXCategoryKitOC/UIKit/UIImageView/**/*.{h,m}'
        end
        ss.subspec 'UIScrollView' do |sss|
            sss.source_files = 'CGXCategoryKitOC/UIKit/UIScrollView/**/*.{h,m}'
        end
        ss.subspec 'UITextField' do |sss|
            sss.source_files = 'CGXCategoryKitOC/UIKit/UITextField/**/*.{h,m}'
        end
        ss.subspec 'UITextView' do |sss|
            sss.source_files = 'CGXCategoryKitOC/UIKit/UITextView/**/*.{h,m}'
        end
        ss.subspec 'UIViewController' do |sss|
            sss.source_files = 'CGXCategoryKitOC/UIKit/UIViewController/**/*.{h,m}'
        end
        ss.subspec 'UITabBarController' do |sss|
            sss.source_files = 'CGXCategoryKitOC/UIKit/UITabBarController/**/*.{h,m}'
            sss.dependency 'CGXCategoryKitOC/Foundation/UIImage'
        end
        
        
    end
    
    s.subspec 'UIControl' do |ss|
        ss.source_files = 'CGXCategoryKitOC/UIControl/**/*.{h,m}'
    end
    
    s.subspec 'QuartzCore' do |ss|
        ss.subspec 'CALayer' do |sss|
            sss.source_files = 'CGXCategoryKitOC/QuartzCore/CALayer/**/*.{h,m}'
        end
        ss.subspec 'CATransaction' do |sss|
            sss.source_files = 'CGXCategoryKitOC/QuartzCore/CATransaction/**/*.{h,m}'
        end
        ss.subspec 'CAShapeLayer' do |sss|
            sss.source_files = 'CGXCategoryKitOC/QuartzCore/CAShapeLayer/**/*.{h,m}'
        end
        ss.subspec 'CAMediaTimingFunction' do |sss|
            sss.source_files = 'CGXCategoryKitOC/QuartzCore/CAMediaTimingFunction/**/*.{h,m}'
        end
        
    end
    s.subspec 'CoreLocation' do |ss|
        ss.subspec 'CLLocation' do |sss|
            sss.source_files = 'CGXCategoryKitOC/CoreLocation/CLLocation/**/*.{h,m}'
        end
    end
    
end




