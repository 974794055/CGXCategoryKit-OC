Pod::Spec.new do |s|
    s.name         = "CGXCategoryKitOC"    #存储库名称
    s.version      = "0.0.1"      #版本号，与tag值一致
    s.summary      = "APP的Foundation、UIKit的延展库"  #简介
    s.description  = "APP的Foundation、UIKit控件延展库)"  #描述
    s.homepage     = "https://github.com/974794055/CGXCategoryKit-OC"      #项目主页，不是git地址
    s.license      = { :type => "MIT", :file => "LICENSE" }   #开源协议
    s.author             = { "974794055" => "974794055@qq.com" }  #作者
    s.platform     = :ios, "8.0"                  #支持的平台和版本号
    s.source       = { :git => "https://github.com/974794055/CGXCategoryKit-OC.git", :tag => s.version }         #存储库的git地址，以及tag值
    s.requires_arc = true #是否支持ARC
    s.frameworks = 'UIKit'
    
    #需要托管的源代码路径
    s.source_files = 'CGXCategoryKitOC/CGXCategoryKitOC.h'
    
    #开源库头文件
    s.public_header_files = 'CGXCategoryKitOC/CGXCategoryKitOC.h'
    
    s.subspec 'Foundation' do |ss|
        ss.subspec 'NSTimer' do |sss|
            sss.source_files = 'CGXCategoryKitOC/Foundation/NSTimer/**/*.{h,m}'
        end
    end
    
    s.subspec 'UIKit' do |ss|
        ss.subspec 'UIWindow' do |sss|
            sss.source_files = 'CGXCategoryKitOC/UIKit/UIWindow/**/*.{h,m}'
        end
    end
    
    s.subspec 'UIControl' do |ss|
        ss.source_files = 'CGXCategoryKitOC/UIControl/**/*.{h,m}'
    end
    
end




