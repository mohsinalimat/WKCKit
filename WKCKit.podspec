Pod::Spec.new do |s|
s.name         = "WKCKit"
s.version      = "0.1.2"
s.summary      = "The development process can help you to quickly carry out some basic Kit settings."
s.homepage     = "https://github.com/WeiKunChao/WKCKit.git"
s.license      = { :type => "MIT", :file => "LICENSE" }
s.author             = { "WeiKunChao" => "17736289336@163.com" }
s.platform     = :ios, "8.0"
s.source       = { :git => "https://github.com/WeiKunChao/WKCKit.git", :tag => "0.1.2" }
s.source_files  = "WKCKit/**/*.{h,m}"
s.public_header_files = "WKCKit/**/*.h"
s.frameworks = "Foundation", "UIKit"
s.requires_arc = true
end
