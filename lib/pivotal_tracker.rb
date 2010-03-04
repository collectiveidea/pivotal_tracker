require 'active_resource'

require 'pivotal_tracker/story_collection'
require 'pivotal_tracker/resource'
require 'pivotal_tracker/client'
require 'pivotal_tracker/project'
require 'pivotal_tracker/iteration'
require 'pivotal_tracker/story'

def PivotalTracker(options = {})
  PivotalTracker::Client.new(options)
end
