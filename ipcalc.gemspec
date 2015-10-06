spec = Gem::Specification.new do |spec|
  spec.name                  = 'ipcalc'
  spec.version               = '1.0.0'
  spec.date                  = '2012-04-30'
  spec.summary               = "IP calculation."
  spec.description           = "This gem provides classes that help IP manipulations."
  spec.authors               = ["denis BEURIVE"]
  spec.email                 = 'denis.beurive@gmail.com'
  spec.files                 = ["lib/ipcalc.rb", "lib/ipcalc/Iptools.rb", "lib/ipcalc/Ip.rb"]
  spec.homepage              = 'https://github.com/denis-beurive/ipcalc'
  spec.required_ruby_version = '>= 1.9.1'

  spec.add_development_dependency 'test-unit'
end
