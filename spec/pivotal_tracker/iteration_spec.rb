require 'spec_helper'

describe PivotalTracker::Iteration do
  before do
    @pivotal = PivotalTracker(:token => 'foo')
    @project = PivotalTracker::Project.new(:id => 1)
    @iteration = PivotalTracker::Iteration.new(:id => 1)
    @iteration.project = @project
  end

  it "should set the project" do
    @project.id = 2
    @iteration.project = @project
    @iteration.prefix_options[:project_id].should == 2
  end

  it "should get the project" do
    @iteration.project.should be_kind_of(PivotalTracker::Project)
  end

  it "should get the stories" do
    iteration = @project.current
    iteration.stories.should be_kind_of(Array)
    iteration.stories.count.should == 19
  end
end
