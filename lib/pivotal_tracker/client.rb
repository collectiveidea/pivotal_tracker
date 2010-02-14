module PivotalTracker
  class Client
    def initialize(options)
      @token    = options[:token]
      @username = options[:username]
      @password = options[:password]
      Resource.headers['X-TrackerToken'] = self.token
    end
    
    def token
      @token ||= begin
        resource = Resource.clone
        resource.user = @username
        resource.password = @password
        resource.connection.get(resource.prefix + 'tokens/active')['guid']
      end
    end
    
    def projects
      Project
    end
    
  end
end