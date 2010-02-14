module PivotalTracker
  class Project < Resource
    
    def current
      iteration = Iteration.build_subclass
      iteration.project_id = self.id
      iteration.find(:first, :from => :current)
    end
  end
end