module PivotalTracker
  class Iteration < Resource
    include StoryCollection
    self.site = SITE_BASE + 'projects/:project_id'
  end
end
