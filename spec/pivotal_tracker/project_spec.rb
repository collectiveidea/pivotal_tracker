require 'spec_helper'

describe PivotalTracker::Project do
  before do
    @pivotal = PivotalTracker(:token => 'foo')
    @project = PivotalTracker::Project.new(:id => 1)
    @headers = {'Accept' => 'application/xml', 'X-TrackerToken' => 'foo'}
    ActiveResource::HttpMock.respond_to do |mock|
      mock.get "/services/v3/projects/1.xml", @headers, fixture('project.xml')
      mock.get "/services/v3/projects/1/iterations.xml?group=current",
        @headers, fixture('iterations.xml')
      mock.get "/services/v3/projects/1/iterations.xml?group=backlog",
        @headers, fixture('backlog.xml')
      mock.get "/services/v3/projects/1/iterations.xml?group=done",
        @headers, fixture('done.xml')
      mock.get "/services/v3/projects/1/stories.xml", @headers,
        fixture('stories.xml')
      mock.get "/services/v3/projects/1/stories/1.xml", @headers,
        fixture('story.xml')
      mock.get "/services/v3/projects/1/stories.xml?filter=type%3A+bug",
        @headers, fixture('bugs.xml')
      mock.get "/services/v3/projects/1/stories.xml?filter=type%3A+chore",
        @headers, fixture('chores.xml')
      mock.get "/services/v3/projects/1/stories.xml?filter=type%3A+feature",
        @headers, fixture('features.xml')
    end
  end
  context "project" do
    it "should return a project" do
      project = PivotalTracker::Project.find(1)
      project.should be_kind_of(PivotalTracker::Project)
    end
  end
  context "current" do
    it "should return the current iteration" do
      @project.current.should be_kind_of(PivotalTracker::Iteration)
    end
  end
  context "done" do
    it "should return done iterations" do
      @project.done.should be_kind_of(Array)
    end
  end
  context "backlog" do
    it "should return backlog iterations" do
      @project.backlog.should be_kind_of(Array)
    end
  end
  context "stories" do
    it "should return all stories" do
      @project.stories.should be_kind_of(Array)
      @project.stories.size.should == 3
    end
  end
  context "story" do
    it "should return a story by id" do
      @project.story(1).should be_kind_of(PivotalTracker::Story)
    end
  end
  context "bugs" do
    it "should return all bugs" do
      @project.bugs.should be_kind_of(Array)
      @project.bugs.size.should == 1
    end
  end
  context "chores" do
    it "should return all chores" do
      @project.chores.should be_kind_of(Array)
      @project.chores.size.should == 1
    end
  end
  context "features" do
    it "should return all features" do
      @project.features.should be_kind_of(Array)
      @project.features.size.should == 1
    end
  end
end
