module PivotalTracker
  class Task < Resource

    include PivotalTracker::BelongsToProject

    self.site = SITE_BASE + 'projects/:project_id/stories/:story_id'

    def story
      self.project.story(self.prefix_options[:story_id])
    end

    def story=(story)
      self.prefix_options[:story_id] = story.id
      self.prefix_options[:project_id] = story.prefix_options[:project_id]
    end
  end
end
