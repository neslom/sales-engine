if ENV['COVERAGE']
  require 'simplecov'
  SimpleCov.start do
    add_filter 'test'
    command_name 'Mintest'
  end
end
 
require 'minitest/autorun'
require 'simplecov'
SimpleCov.start

# Previous content of test helper now starts here