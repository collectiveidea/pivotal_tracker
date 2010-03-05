require 'spec_helper'

describe PivotalTracker::Client do
  before do
    @token = 'foo'
    @auth_headers = {'Authorization' => 'Basic Zm9vOmJhcg==', 'Accept' => 'application/xml'}
    @headers = {'Accept' => 'application/xml', 'X-TrackerToken' => @token}
    ActiveResource::HttpMock.respond_to do |mock|
      mock.get "/services/v3/tokens/active", @auth_headers, fixture('tokens.xml')
      mock.get "/services/v3/projects.xml", @headers, fixture('projects.xml')
    end
  end
  
  it "should be able to look up token" do
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
      projects = PivotalTracker(:token => @token).projects
      projects.should == PivotalTracker::Project
      projects.find(:all).size.should == 2
    end
  end
end
