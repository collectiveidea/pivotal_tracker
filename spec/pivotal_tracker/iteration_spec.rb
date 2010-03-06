require 'spec_helper'

describe PivotalTracker::Iteration do
  before do
    @pivotal = PivotalTracker(:token => 'foo')
    @project = PivotalTracker::Project.new(:id => 1)
    @iteration = PivotalTracker::Iteration.new(:id => 1)
  end

  it "should set the project" do
    @iteration.project = @project
    @iteration.prefix_options[:project_id].should == 1
  end

  it "should get the project" do
    @iteration.project = @project
    @iteration.project.should be_kind_of(PivotalTracker::Project)
  end
end
