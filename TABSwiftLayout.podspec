Pod::Spec.new do |s|
  s.name         = 'TABSwiftLayout'
  s.version      = '0.0.1'
  s.platform	 = :ios, '8.0'
  s.license      = 'LICENSE'
  s.author       = { "The App Business" => "https://www.theappbusiness.com" }
  s.homepage     = 'https://www.theappbusiness.com'
  s.requires_arc = true
  s.summary      = 'Simple auto-layout in Swift'
  s.source       = { :git => 'ssh://git@bitbucket.org:theappbusiness/swiftlayout.git', :tag => s.version.to_s }
  s.source_files = 'TABSwiftLayout/**/*.swift'
end
