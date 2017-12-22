Pod::Spec.new do |s|
  s.name         = 'TABSwiftLayout'
  s.version      = '2.1.0'
  s.platforms     = { :ios => "8.0", :osx => "10.10" }
  s.license      = 'MIT'
  s.author       = { "The App Business" => "https://www.theappbusiness.com" }
  s.homepage     = 'https://www.theappbusiness.com'
  s.requires_arc = true
  s.summary      = 'Provides a flexible, yet minimal API for dealing with Auto Layout programatically'
  s.source       = { :git => 'https://github.com/theappbusiness/TABSwiftLayout.git', :tag => s.version.to_s }
  s.source_files = 'Sources/**/*.swift'
end
