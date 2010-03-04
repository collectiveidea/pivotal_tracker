module PivotalTracker
  class Project < Resource

    self.site = SITE_BASE
    self.element_name = 'projects'

    include PivotalTracker::StoryCollection

    def iterations(scope = :all, opt_params = {})
      params = {:project_id => self.id}
      params.merge!(opt_params)
      Iteration.find(scope, :params => params)
    end

    def current
      self.iterations(:first, :group => "current")
    end

    def done
      self.iterations(:all, :group => "done")
    end

    def backlog
      self.iterations(:all, :group => "backlog")
    end

    def stories(scope = :all, opt_params = {})
      params = {:project_id => self.id}
      params.merge!(opt_params)
      Story.find(scope, :params => params)
    end
  end
end
