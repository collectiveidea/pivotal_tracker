module PivotalTracker

  SITE_BASE = "https://www.pivotaltracker.com/services/v3/"

  class Resource < ActiveResource::Base

    Resource.site = SITE_BASE

    class << self
      # If headers are not defined in a given subclass, then obtain headers from the superclass.
      # Taken from the Harvest gem: github.com/aiaio/harvest
      def headers
        if defined?(@headers)
          @headers
        elsif superclass != Object && superclass.headers
          superclass.headers
        else
          @headers ||= {}
        end
      end
      
      def build_subclass
        returning Class.new(self) do |c|
          c.element_name    = self.element_name
          c.collection_name = self.collection_name
          c.primary_key     = self.primary_key
        end
      end
    end
    
    def find_or_create_resource_for(name)
      resource_name = name.to_s.camelize
      if PivotalTracker.const_defined?(resource_name)
        PivotalTracker.const_get(resource_name)
      else
        super
      end
    end
    
  end
end
