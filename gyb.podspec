Pod::Spec.new do |s|
  
  s.name         = "gyb"
  s.version      = "0.1.0"
  s.summary      = "Apple's 'gyb' Tool"
  s.description  = <<-DESC
                   A repackaging of Apple's 'gyb' tool from the Swift library.
                   DESC
  
  s.homepage       = "https://github.com/SomeRandomiOSDev/gyb"
  s.license        = "MIT"
  s.author         = { "Joe Newton" => "somerandomiosdev@gmail.com" }
  s.source         = { :git => "https://github.com/SomeRandomiOSDev/gyb.git", :tag => s.version.to_s }
  s.preserve_paths = '*'

  s.ios.deployment_target     = '9.0'
  s.macos.deployment_target   = '10.10'
  s.tvos.deployment_target    = '9.0'
  s.watchos.deployment_target = '2.0'
  
end
