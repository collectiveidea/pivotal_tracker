require 'spec_helper'

describe PivotalTracker::Project do
  before do
    @pivotal = PivotalTracker(:token => 'foo')
    @project = PivotalTracker::Project.new(:id => 1)
  end
  context "current" do
    it "should return the current iteration" do
      FakeWeb.register_uri(:get, "https://www.pivotaltracker.com/services/v3/projects/1/iterations/current.xml", 
        :body => fixture('iterations.xml'))
      
      @project.current.should be_kind_of(PivotalTracker::Iteration)
      # projects.should == PivotalTracker::Project
      # projects.find(:all).size.should == 2
    end
  end
end
