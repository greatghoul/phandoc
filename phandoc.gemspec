Gem::Specification.new do |s|
  s.name        = 'phandoc'
  s.version     = '0.0.1'
  s.date        = '2014-10-31'
  s.summary     = "Javascript + DOM in your ruby, based on PhantomJS."
  s.description = "Javascript + DOM in your ruby, based on PhantomJS."
  s.authors     = ["greatghoul"]
  s.email       = 'greatghoul@gmail.com'
  s.files       = ["lib/phandoc.rb"]
  s.homepage    = 'https://github.com/greatghoul/phandoc'
  s.license     = 'MIT'

  s.add_development_dependency 'phantomjs'
end