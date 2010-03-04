require 'spec_helper'

describe PivotalTracker::Project do
  before do
    @pivotal = PivotalTracker(:token => 'foo')
    @project = PivotalTracker::Project.new(:id => 1)
    @base = "https://www.pivotaltracker.com/services/v3/"
  end
  context "project" do
    it "should return a project" do
      FakeWeb.register_uri(:get, 
        @base + "projects/1.xml", 
        :body => fixture('project.xml'))
      
      project = PivotalTracker::Project.find(1)
      project.should be_kind_of(PivotalTracker::Project)
    end
  end
  context "current" do
    it "should return the current iteration" do
      FakeWeb.register_uri(:get, 
        @base + "projects/1/iterations.xml?group=current", 
        :body => fixture('iterations.xml'))
      
      @project.current.should be_kind_of(PivotalTracker::Iteration)
    end
  end
  context "stories" do
    it "should return all stories" do
      FakeWeb.register_uri(:get, @base + "projects/1/stories.xml", 
        :body => fixture('stories.xml'))
      
      @project.stories.should be_kind_of(Array)
      @project.stories.size.should == 3
    end
  end
  context "bugs" do
    it "should return all bugs" do
      FakeWeb.register_uri(:get,
        @base + "projects/1/stories.xml?filter=type%3A+bug", 
        :body => fixture('bugs.xml'))

      @project.bugs.should be_kind_of(Array)
      @project.bugs.size.should == 1
    end
  end
  context "chores" do
    it "should return all chores" do
      FakeWeb.register_uri(:get,
        @base + "projects/1/stories.xml?filter=type%3A+chore", 
        :body => fixture('chores.xml'))

      @project.chores.should be_kind_of(Array)
      @project.chores.size.should == 1
    end
  end
  context "features" do
    it "should return all features" do
      FakeWeb.register_uri(:get,
        @base + "projects/1/stories.xml?filter=type%3A+feature", 
        :body => fixture('features.xml'))

      @project.features.should be_kind_of(Array)
      @project.features.size.should == 1
    end
  end
end
