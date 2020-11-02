Pod::Spec.new do |s|
    s.name         = "CGXCategoryKitOC"    #存储库名称
    s.version      = "0.1.0"      #版本号，与tag值一致
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
        ss.public_header_files = 'CGXCategoryKitOC/Tools/*.h'
    end
    
    s.subspec 'Foundation' do |ss|
        ss.subspec 'NSTimer' do |sss|
            sss.source_files = 'CGXCategoryKitOC/Foundation/NSTimer/**/*.{h,m}'
            sss.public_header_files = 'CGXCategoryKitOC/NSTimer/NSObject/*.h'
        end
        ss.subspec 'NSBundle' do |sss|
            sss.source_files = 'CGXCategoryKitOC/Foundation/NSBundle/**/*.{h,m}'
            sss.public_header_files = 'CGXCategoryKitOC/Foundation/NSBundle/*.h'
        end
        ss.subspec 'UIColor' do |sss|
            sss.source_files = 'CGXCategoryKitOC/Foundation/UIColor/**/*.{h,m}'
            sss.public_header_files = 'CGXCategoryKitOC/Foundation/UIColor/*.h'
        end
        ss.subspec 'UIDevice' do |sss|
            sss.source_files = 'CGXCategoryKitOC/Foundation/UIDevice/**/*.{h,m}'
            sss.public_header_files = 'CGXCategoryKitOC/Foundation/UIDevice/*.h'
        end
        ss.subspec 'NSNull' do |sss|
            sss.source_files = 'CGXCategoryKitOC/Foundation/NSNull/**/*.{h,m}'
            sss.public_header_files = 'CGXCategoryKitOC/Foundation/NSNull/*.h'
        end
        ss.subspec 'NSDictionary' do |sss|
            sss.source_files = 'CGXCategoryKitOC/Foundation/NSDictionary/**/*.{h,m}'
            sss.public_header_files = 'CGXCategoryKitOC/Foundation/NSDictionary/*.h'
        end
        
        ss.subspec 'NSNotificationCenter' do |sss|
            sss.source_files = 'CGXCategoryKitOC/Foundation/NSNotificationCenter/**/*.{h,m}'
            sss.public_header_files = 'CGXCategoryKitOC/Foundation/NSNotificationCenter/*.h'
        end
        ss.subspec 'NSFileManager' do |sss|
            sss.source_files = 'CGXCategoryKitOC/Foundation/NSFileManager/**/*.{h,m}'
            sss.public_header_files = 'CGXCategoryKitOC/Foundation/NSFileManager/*.h'
        end
        ss.subspec 'UIFont' do |sss|
            sss.source_files = 'CGXCategoryKitOC/Foundation/UIFont/**/*.{h,m}'
            sss.public_header_files = 'CGXCategoryKitOC/Foundation/UIFont/*.h'
        end
        ss.subspec 'NSIndexPath' do |sss|
            sss.source_files = 'CGXCategoryKitOC/Foundation/NSIndexPath/**/*.{h,m}'
            sss.public_header_files = 'CGXCategoryKitOC/Foundation/NSIndexPath/*.h'
        end
        ss.subspec 'NSRunLoop' do |sss|
            sss.source_files = 'CGXCategoryKitOC/Foundation/NSRunLoop/**/*.{h,m}'
            sss.public_header_files = 'CGXCategoryKitOC/Foundation/NSRunLoop/*.h'
        end
        ss.subspec 'NSMutableAttributedString' do |sss|
            sss.source_files = 'CGXCategoryKitOC/Foundation/NSMutableAttributedString/**/*.{h,m}'
            sss.public_header_files = 'CGXCategoryKitOC/Foundation/NSMutableAttributedString/*.h'
        end
        ss.subspec 'UIImage' do |sss|
            sss.source_files = 'CGXCategoryKitOC/Foundation/UIImage/**/*.{h,m}'
            sss.public_header_files = 'CGXCategoryKitOC/Foundation/UIImage/*.h'
        end
        ss.subspec 'NSHTTPCookieStorage' do |sss|
            sss.source_files = 'CGXCategoryKitOC/Foundation/NSHTTPCookieStorage/**/*.{h,m}'
            sss.public_header_files = 'CGXCategoryKitOC/Foundation/NSHTTPCookieStorage/*.h'
        end
        ss.subspec 'NSFileHandle' do |sss|
            sss.source_files = 'CGXCategoryKitOC/Foundation/NSFileHandle/**/*.{h,m}'
            sss.public_header_files = 'CGXCategoryKitOC/Foundation/NSFileHandle/*.h'
        end
        ss.subspec 'NSException' do |sss|
            sss.source_files = 'CGXCategoryKitOC/Foundation/NSException/**/*.{h,m}'
            sss.public_header_files = 'CGXCategoryKitOC/Foundation/NSException/*.h'
        end
        ss.subspec 'NSArray' do |sss|
            sss.source_files = 'CGXCategoryKitOC/Foundation/NSArray/**/*.{h,m}'
            sss.public_header_files = 'CGXCategoryKitOC/Foundation/NSArray/*.h'
        end
        ss.subspec 'NSData' do |sss|
            sss.source_files = 'CGXCategoryKitOC/Foundation/NSData/**/*.{h,m}'
            sss.public_header_files = 'CGXCategoryKitOC/Foundation/NSData/*.h'
        end
        ss.subspec 'NSNumber' do |sss|
            sss.source_files = 'CGXCategoryKitOC/Foundation/NSNumber/**/*.{h,m}'
            sss.public_header_files = 'CGXCategoryKitOC/Foundation/NSNumber/*.h'
        end
        ss.subspec 'NSURL' do |sss|
            sss.source_files = 'CGXCategoryKitOC/Foundation/NSURL/**/*.{h,m}'
            sss.public_header_files = 'CGXCategoryKitOC/Foundation/NSURL/*.h'
        end
        ss.subspec 'NSString' do |sss|
            sss.source_files = 'CGXCategoryKitOC/Foundation/NSString/**/*.{h,m}'
            sss.public_header_files = 'CGXCategoryKitOC/Foundation/NSString/*.h'
        end
        ss.subspec 'NSObject' do |sss|
            sss.source_files = 'CGXCategoryKitOC/Foundation/NSObject/**/*.{h,m}'
            sss.public_header_files = 'CGXCategoryKitOC/Foundation/NSObject/*.h'
        end
        ss.subspec 'NSUserDefaults' do |sss|
            sss.source_files = 'CGXCategoryKitOC/Foundation/NSUserDefaults/**/*.{h,m}'
            sss.public_header_files = 'CGXCategoryKitOC/Foundation/NSUserDefaults/*.h'
            sss.dependency 'CGXCategoryKitOC/Foundation/NSObject'
        end
        ss.subspec 'NSCalendar' do |sss|
            sss.source_files = 'CGXCategoryKitOC/Foundation/NSCalendar/**/*.{h,m}'
            sss.public_header_files = 'CGXCategoryKitOC/Foundation/NSCalendar/*.h'
        end
        ss.subspec 'NSDate' do |sss|
            sss.source_files = 'CGXCategoryKitOC/Foundation/NSDate/**/*.{h,m}'
            sss.public_header_files = 'CGXCategoryKitOC/Foundation/NSDate/*.h'
            sss.dependency 'CGXCategoryKitOC/Foundation/NSCalendar'
            sss.dependency 'CGXCategoryKitOC/Tools'
        end
        
    end
    
    s.subspec 'UIKit' do |ss|
        ss.subspec 'UIWindow' do |sss|
            sss.source_files = 'CGXCategoryKitOC/UIKit/UIWindow/**/*.{h,m}'
            sss.public_header_files = 'CGXCategoryKitOC/UIKit/UIWindow/*.h'
        end
        ss.subspec 'WKWebView' do |sss|
            sss.source_files = 'CGXCategoryKitOC/UIKit/WKWebView/**/*.{h,m}'
            sss.public_header_files = 'CGXCategoryKitOC/UIKit/WKWebView/*.h'
        end
        ss.subspec 'UISegmentedControl' do |sss|
            sss.source_files = 'CGXCategoryKitOC/UIKit/UISegmentedControl/**/*.{h,m}'
            sss.public_header_files = 'CGXCategoryKitOC/UIKit/UISegmentedControl/*.h'
        end
        ss.subspec 'UITableView' do |sss|
            sss.source_files = 'CGXCategoryKitOC/UIKit/UITableView/**/*.{h,m}'
            sss.public_header_files = 'CGXCategoryKitOC/UIKit/UITableView/*.h'
        end
        ss.subspec 'UITableViewCell' do |sss|
            sss.source_files = 'CGXCategoryKitOC/UIKit/UITableViewCell/**/*.{h,m}'
            sss.public_header_files = 'CGXCategoryKitOC/UIKit/UITableViewCell/*.h'
        end
        ss.subspec 'UINavigationItem' do |sss|
            sss.source_files = 'CGXCategoryKitOC/UIKit/UINavigationItem/**/*.{h,m}'
            sss.public_header_files = 'CGXCategoryKitOC/UIKit/UINavigationItem/*.h'
        end
        ss.subspec 'UINavigationBar' do |sss|
            sss.source_files = 'CGXCategoryKitOC/UIKit/UINavigationBar/**/*.{h,m}'
            sss.public_header_files = 'CGXCategoryKitOC/UIKit/UINavigationBar/*.h'
        end
        ss.subspec 'UIBarButtonItem' do |sss|
            sss.source_files = 'CGXCategoryKitOC/UIKit/UIBarButtonItem/**/*.{h,m}'
            sss.public_header_files = 'CGXCategoryKitOC/UIKit/UIBarButtonItem/*.h'
        end
        ss.subspec 'UINavigationController' do |sss|
            sss.source_files = 'CGXCategoryKitOC/UIKit/UINavigationController/**/*.{h,m}'
            sss.public_header_files = 'CGXCategoryKitOC/UIKit/UINavigationController/*.h'
        end
        ss.subspec 'UIScreen' do |sss|
            sss.source_files = 'CGXCategoryKitOC/UIKit/UIScreen/**/*.{h,m}'
            sss.public_header_files = 'CGXCategoryKitOC/UIKit/UIScreen/*.h'
        end
        ss.subspec 'UIApplication' do |sss|
            sss.source_files = 'CGXCategoryKitOC/UIKit/UIApplication/**/*.{h,m}'
            sss.public_header_files = 'CGXCategoryKitOC/UIKit/UIApplication/*.h'
        end
        ss.subspec 'UIResponder' do |sss|
            sss.source_files = 'CGXCategoryKitOC/UIKit/UIResponder/**/*.{h,m}'
            sss.public_header_files = 'CGXCategoryKitOC/UIKit/UIResponder/*.h'
        end
        ss.subspec 'UIButton' do |sss|
            sss.source_files = 'CGXCategoryKitOC/UIKit/UIButton/**/*.{h,m}'
            sss.public_header_files = 'CGXCategoryKitOC/UIKit/UIButton/*.h'
        end
        ss.subspec 'UIImageView' do |sss|
            sss.source_files = 'CGXCategoryKitOC/UIKit/UIImageView/**/*.{h,m}'
            sss.public_header_files = 'CGXCategoryKitOC/UIKit/UIImageView/*.h'
        end
        ss.subspec 'UISplitViewController' do |sss|
            sss.source_files = 'CGXCategoryKitOC/UIKit/UISplitViewController/**/*.{h,m}'
            sss.public_header_files = 'CGXCategoryKitOC/UIKit/UISplitViewController/*.h'
        end
        ss.subspec 'UIView' do |sss|
            sss.source_files = 'CGXCategoryKitOC/UIKit/UIView/**/*.{h,m}'
            sss.public_header_files = 'CGXCategoryKitOC/UIKit/UIView/*.h'
        end
        ss.subspec 'UILabel' do |sss|
            sss.source_files = 'CGXCategoryKitOC/UIKit/UILabel/**/*.{h,m}'
            sss.public_header_files = 'CGXCategoryKitOC/UIKit/UILabel/*.h'
        end
        ss.subspec 'UIImageView' do |sss|
            sss.source_files = 'CGXCategoryKitOC/UIKit/UIImageView/**/*.{h,m}'
            sss.public_header_files = 'CGXCategoryKitOC/UIKit/UIImageView/*.h'
        end
        ss.subspec 'UIScrollView' do |sss|
            sss.source_files = 'CGXCategoryKitOC/UIKit/UIScrollView/**/*.{h,m}'
            sss.public_header_files = 'CGXCategoryKitOC/UIKit/UIScrollView/*.h'
        end
        ss.subspec 'UITextField' do |sss|
            sss.source_files = 'CGXCategoryKitOC/UIKit/UITextField/**/*.{h,m}'
            sss.public_header_files = 'CGXCategoryKitOC/UIKit/UITextField/*.h'
        end
        ss.subspec 'UITextView' do |sss|
            sss.source_files = 'CGXCategoryKitOC/UIKit/UITextView/**/*.{h,m}'
            sss.public_header_files = 'CGXCategoryKitOC/UIKit/UITextView/*.h'
        end
        ss.subspec 'UIViewController' do |sss|
            sss.source_files = 'CGXCategoryKitOC/UIKit/UIViewController/**/*.{h,m}'
            sss.public_header_files = 'CGXCategoryKitOC/UIKit/UIViewController/*.h'
        end

    end
    
    s.subspec 'UIControl' do |ss|
        ss.source_files = 'CGXCategoryKitOC/UIControl/**/*.{h,m}'
        ss.public_header_files = 'CGXCategoryKitOC/UIControl/*.h'
    end
    
    s.subspec 'QuartzCore' do |ss|
        ss.subspec 'CALayer' do |sss|
            sss.source_files = 'CGXCategoryKitOC/QuartzCore/CALayer/**/*.{h,m}'
            sss.public_header_files = 'CGXCategoryKitOC/QuartzCore/CALayer/*.h'
        end
        ss.subspec 'CATransaction' do |sss|
            sss.source_files = 'CGXCategoryKitOC/QuartzCore/CATransaction/**/*.{h,m}'
            sss.public_header_files = 'CGXCategoryKitOC/QuartzCore/CATransaction/*.h'
        end
        ss.subspec 'CAShapeLayer' do |sss|
            sss.source_files = 'CGXCategoryKitOC/QuartzCore/CAShapeLayer/**/*.{h,m}'
            sss.public_header_files = 'CGXCategoryKitOC/QuartzCore/CAShapeLayer/*.h'
        end
        ss.subspec 'CAMediaTimingFunction' do |sss|
            sss.source_files = 'CGXCategoryKitOC/QuartzCore/CAMediaTimingFunction/**/*.{h,m}'
            sss.public_header_files = 'CGXCategoryKitOC/QuartzCore/CAMediaTimingFunction/*.h'
        end
        
    end
    
    s.subspec 'CoreLocation' do |ss|
        ss.subspec 'CLLocation' do |sss|
            sss.source_files = 'CGXCategoryKitOC/CoreLocation/CLLocation/**/*.{h,m}'
            sss.public_header_files = 'CGXCategoryKitOC/CoreLocation/CLLocation/*.h'
        end
    end
    
end




