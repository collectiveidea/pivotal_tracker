module PivotalTracker
  class Story < Resource

    include PivotalTracker::BelongsToProject

    self.site = SITE_BASE + 'projects/:project_id'

    def tasks(scope = :all, opt_params = {})
      params = {:project_id => self.prefix_options[:project_id],
                :story_id => self.id}
      params.merge!(opt_params)
      Task.find(:all, :params => params)
    end

    def task(id)
      tasks(id)
    end
  end
end
