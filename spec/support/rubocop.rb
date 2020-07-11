# frozen_string_literal: true

require 'rubocop'
require 'rubocop/rspec/support'
Dir["#{__dir__}/../../lib/**/*.rb"].sort.each { |f| require f }

RSpec.configure do |config|
  config.include(RuboCop::RSpec::ExpectOffense)
end
