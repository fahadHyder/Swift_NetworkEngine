Pod::Spec.new do |s|
  s.name             = 'NetworkMediator'
  s.version          = '0.1.1'
  s.summary          = 'NetworkMediator will help you to make Api calls with out writing tons of boilerplate code.'
 
  s.description      = <<-DESC
NetworkMediator will help you to make Api calls with out writing tons of boilerplate code!.The current release has a dependency with Alamofire which will be removed in future so that you could add normal NSURLSession or any other dependency in the lowest abstarction.
                       DESC
 
  s.homepage         = 'https://github.com/fahadHyder/Swift_NetworkEngine'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Fahad C H' => 'fahadhyder.c@gmail.com' }
  s.source           = { :git => 'https://github.com/fahadHyder/Swift_NetworkEngine.git', :tag => s.version.to_s }
 
  s.ios.deployment_target = '10.0'
  s.source_files = 'NetworkEngine/*'
  s.dependency 'SwiftyJSON'
  s.dependency 'Alamofire'
 
end