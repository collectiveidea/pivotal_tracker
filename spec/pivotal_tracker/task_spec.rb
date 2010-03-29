require 'spec_helper'

describe PivotalTracker::Task do
  before do
    @pivotal = PivotalTracker(:token => 'foo')
    @project = PivotalTracker::Project.new(:id => 1)
    @story = PivotalTracker::Story.new(:id => 1)
    @story.project = @project
    @task = PivotalTracker::Task.new(:id => 1)
    @task.story = @story
    @headers = {'Accept' => 'application/xml', 'X-TrackerToken' => 'foo'}
    ActiveResource::HttpMock.respond_to do |mock|
      mock.get "/services/v3/projects/1.xml", @headers,
        fixture('project.xml')
      mock.get "/services/v3/projects/1/stories/1.xml", @headers,
        fixture('story.xml')
    end
  end

  it "should get the project" do
    @task.project.should be_kind_of(PivotalTracker::Project)
    @task.project.id.to_i.should == @project.id
  end

  it "should get the story" do
    @task.story.should be_kind_of(PivotalTracker::Story)
  end

  it "should set the story" do
    @story.id = 2
    @task.story = @story
    @task.prefix_options[:story_id].should == 2
  end
end
