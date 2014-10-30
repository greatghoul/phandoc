require 'bundler/setup'
Bundler.setup

require 'phandoc' # and any other gems you need

RSpec.configure do |config|
  config.color = true
  config.formatter = :documentation
end