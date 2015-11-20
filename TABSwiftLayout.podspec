Pod::Spec.new do |s|
  s.name         = 'TABSwiftLayout'
  s.version      = '1.0'
  s.platform	 = :ios, '8.0'
  s.license      = 'MIT'
  s.author       = { "The App Business" => "https://www.theappbusiness.com" }
  s.homepage     = 'https://www.theappbusiness.com'
  s.requires_arc = true
  s.summary      = 'Provides a flexible, yet minimal API for dealing with Auto Layout programatically'
  s.source       = { :git => 'ssh://git@github.com:theappbusiness/TABSwiftLayout.git', :tag => s.version.to_s }
  s.source_files = 'TABSwiftLayout/**/*.swift'
end
