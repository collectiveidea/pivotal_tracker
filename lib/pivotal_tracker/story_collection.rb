module PivotalTracker
  # Methods common to classes which have a collection of stories (Project,
  # Iteration)
  module StoryCollection
    def stories_by_type(type)
      self.stories(:all, :filter => "type: #{type}")
    end

    def bugs
      self.stories_by_type('bug')
    end

    def chores
      self.stories_by_type('chore')
    end

    def features
      self.stories_by_type('chore')
    end
  end
end
