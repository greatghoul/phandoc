Gem::Specification.new do |s|
  s.name        = 'phandoc'
  s.version     = '0.0.2'
  s.date        = '2014-12-27'
  s.summary     = "Javascript + DOM in your ruby, based on PhantomJS."
  s.description = "Javascript + DOM in your ruby, based on PhantomJS."
  s.authors     = ["greatghoul"]
  s.email       = 'greatghoul@gmail.com'
  s.files       = ["lib/phandoc.rb"]
  s.homepage    = 'https://github.com/greatghoul/phandoc'
  s.license     = 'MIT'

  s.add_runtime_dependency 'phantomjs', '~> 1.9.7.0'
end