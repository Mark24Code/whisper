require "test_helper"
require_relative "../lib/whisper/coordinator"


describe "Task Test" do
    it "test task.new" do 
        task_name = "task01"
        task_content = task_name+"_content"
        t = Task.new(task_name,task_content)
        
        assert_equal t.type_name,task_name
        assert_equal t.content, task_content
	end
end


describe "Publisher Test" do
    it "test publisher.new" do
        p = Publisher.new

        assert_equal p.tasks, []
        assert_equal p.subscribers, {}
    end
end


describe "SubscriberManagement Test" do
    it "test SubscriberManagement.new" do
        sm = SubscriberManagement.new

        assert_equal sm.name_list, {}
    end
end
