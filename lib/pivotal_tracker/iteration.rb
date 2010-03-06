module PivotalTracker
  class Iteration < Resource
    include StoryCollection
    include BelongsToProject
    self.site = SITE_BASE + 'projects/:project_id'
  end
end
