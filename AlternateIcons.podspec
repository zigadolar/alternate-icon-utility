Pod::Spec.new do |s|
  s.name             = 'AlternateIcons'
  s.version          = '0.0.3'
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

  s.platform     = :ios, '10.3'
  s.ios.deployment_target = '10.3'
  s.swift_version = '5.0'

  s.ios.source_files = 'AlternateIcons/Classes/**/*'
  s.ios.resource_bundles = {
    'AlternateIcons' => ['AlternateIcons/Assets/*.xcassets',
    'AlternateIcons/Assets/*.storyboard']
  }

  s.ios.frameworks = 'UIKit'
end
