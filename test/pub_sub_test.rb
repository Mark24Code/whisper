require "test_helper"
require_relative "../lib/whisper/pub_sub"

include PubSub


describe "Task Test" do
    it "test task.new" do 
        task_name = "task01"
        task_content = task_name+"_content"
        t = Task.new(task_name,task_content)
        
        assert_equal t.name,task_name
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


describe "Subscriber Test" do
    it "test Subscriber.new" do
        test_s_name = "test"
        s = Subscriber.new(test_s_name)

        assert_equal s.name, test_s_name
        assert s.id
        assert s.publisher
        # puts s.publisher
        assert s.manager
        # puts s.manager
    end

    it "test subscriber.subscribe" do
        s = Subscriber.new("test")
        sid = s.subscribe
        assert sid
        pub = s.publisher
        assert pub.subscribers.length >= 1
    end

    it "test subscriber.unsubscribe" do
        s = Subscriber.new("test")
        sid = s.subscribe
        assert sid
        pub = s.publisher
        current_length = pub.subscribers.length
        s.unsubscribe
        assert_equal pub.subscribers.length, current_length-1
    end


    it "test subscriber.run" do
        FAKE_NAME = 'faker'
        s = Subscriber.new(FAKE_NAME)
        s.subscribe()
        def s.run(task)
            self.name = task.name
        end

        t = Task.new("test-task","test-task content")
        p = Root_publisher
        p.add_task(t)

        assert s.name != FAKE_NAME
    end

    it "test helper" do
        assert true
    end
end
