require 'spec_helper'

describe PivotalTracker::Client do
  before do
    @token = 'foo'
  end
  
  it "should be able to look up token" do
    FakeWeb.register_uri(:get, "https://foo:bar@www.pivotaltracker.com/services/v3/tokens/active",
      :body => fixture('tokens.xml'))
    
    PivotalTracker(:username => 'foo', :password => 'bar').token.should == "c93f12c71bec27843c1d84b3bdd547f3"
  end
  
  it "should set token header" do
    pivotal = PivotalTracker(:token => 'foo')
    pivotal.token.should == 'foo'
    PivotalTracker::Resource.headers['X-TrackerToken'].should == 'foo'
    PivotalTracker::Project.headers['X-TrackerToken'].should == 'foo'
  end
  
  context "projects" do
    it "should return list of projects" do
      FakeWeb.register_uri(:get, "https://www.pivotaltracker.com/services/v3/projects.xml", 
        :body => fixture('projects.xml'))
      
      projects = PivotalTracker(:token => @token).projects
      projects.should == PivotalTracker::Project
      projects.find(:all).size.should == 2
    end
  end
end
