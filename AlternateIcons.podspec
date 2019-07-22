Pod::Spec.new do |s|
  s.name             = 'AlternateIcons'
  s.version          = '0.0.1'
  s.summary          = 'An iOS utility for picking alternate app icons'

  s.description      = <<-DESC
    A convenience utility for managing alternate icons in iOS apps.
    Provides a helper for finding which alternate icons are available
    and to set them as app icons. Also provides a simple table view controller
    for picking a new icon.
                       DESC

  s.homepage         = 'https://github.com/zigadolar/alternate-icon-utility.git'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Dolar, Ziga' => 'dolar.ziga@gmail.com' }
  s.source           = { :git => 'https://github.com/zigadolar/alternate-icon-utility.git', :tag => s.version.to_s }

  s.ios.deployment_target = '8.0'

  s.source_files = 'AlternateIcons/Classes/**/*'
  
  # s.resource_bundles = {
  #   'AlternateIcons' => ['AlternateIcons/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  # s.dependency 'AFNetworking', '~> 2.3'
end
