Pod::Spec.new do |s|
          #1.
          s.name               = "LoggerFramework"
          #2.
          s.version            = "1.0.0"
          #3.  
          s.summary         = "Sort description of ‘LoggerFramework’ framework"
          #4.
          s.homepage        = "http://www.yudiz.com"
          #5.
          s.license              = "MIT"
          #6.
          s.author               = "sujay"
          #7.
          s.platform            = :ios, "10.0"
          #8.
          s.source              = { :git => "https://github.com/huilgolsujay/LoggerFramework.git", :tag => "1.0.0" }
          #9.
          s.source_files     = "LoggerFramework", "LoggerFramework/**/*.{h,m,swift}"
         s.resources = "LoggerFramework/**/*.{png,jpeg,jpg,xcassets,storyboard,xib}"
       #  s.subspec ‘iOSApiConnection’ 
      #  s.dependency 'iOSApiConnection'
s.default_subspec = 'iOSApiConnection'

  s.subspec 'iOSApiConnection' do | iOSApiConnection |


 # end

end