require 'spec_helper'

describe PivotalTracker::Project do
  before do
    @pivotal = PivotalTracker(:token => 'foo')
    @project = PivotalTracker::Project.new(:id => 1)
    @story = PivotalTracker::Story.new(:id => 1)
    @headers = {'Accept' => 'application/xml', 'X-TrackerToken' => 'foo'}
    ActiveResource::HttpMock.respond_to do |mock|
      mock.get "/services/v3/projects/1.xml", @headers,
        fixture('project.xml')
      mock.get "/services/v3/projects/1/story/1.xml", @headers,
        fixture('story.xml')
    end
  end

  it "should set the project" do
    @story.project = @project
    @story.prefix_options[:project_id].should == 1
  end

  it "should get the project" do
    @story.project = @project
    project = @story.project
    @story.project.should be_kind_of(PivotalTracker::Project)
  end
end
