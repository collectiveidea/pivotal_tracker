module PivotalTracker
  class Story < Resource
    self.site = SITE_BASE + 'projects/:project_id'
  end
end
