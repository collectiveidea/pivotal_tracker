module PivotalTracker
  module BelongsToProject
    def project
      Project.find(self.prefix_options[:project_id])
    end

    def project=(project)
      self.prefix_options[:project_id] = project.id
    end
  end
end
