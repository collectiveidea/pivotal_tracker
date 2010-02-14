$LOAD_PATH.unshift(File.dirname(__FILE__))
$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))
require 'pivotal_tracker'
require 'spec'
require 'spec/autorun'
require 'fakeweb'

FakeWeb.allow_net_connect = false

Spec::Runner.configure do |config|
  
end

def fixture(path)
  File.read(File.join(File.dirname(__FILE__), 'fixtures', path))
end