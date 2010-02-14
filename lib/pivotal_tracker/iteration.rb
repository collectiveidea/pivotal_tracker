module PivotalTracker
  class Iteration < Resource
    self.element_name = 'iteration'
    
    class << self
      def project_id=(id)
        @project_id = id
        self.prefix = prefix + "projects/#{@project_id}/"
      end
    end
  end
end