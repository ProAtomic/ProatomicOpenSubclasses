
Pod::Spec.new do |s|
  s.name             = 'ProatomicOpenSubclasses'
  s.version          = '0.0.4'
  s.summary          = 'A short description of ProatomicOpenSubclasses.'
  s.description      = 'A very long description of ProatomicOpenSubclasses.'

  s.homepage         = 'https://proatomicdev.com'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { '942v' => 'gsaenz@proatomicdev.com' }
  s.source           = { :git => 'https://github.com/ProAtomic/ProatomicOpenSubclasses.git', :tag => s.version.to_s }

  s.ios.deployment_target = '8.0'

  s.dependency 'pop'
  s.dependency 'ReactiveObjC'
  s.frameworks = 'UIKit'
  s.source_files = 'ProatomicOpenSubclasses/Classes/**/*'
end
