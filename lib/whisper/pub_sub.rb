require 'securerandom'

module PubSub
    class Task
        attr_accessor :name, :content
        def initialize(name, content)
            @name = name
            @content = content
        end
    end

    class Publisher

        attr_accessor :tasks, :subscribers
        def initialize
            @tasks = []
            @subscribers = {}
        end

        def add_task(task)
            @tasks.push(task)
            self.boardcast(task)
        end

        def boardcast(task)
            @subscribers.each do |subscriber_id, subscriber|
                if subscriber.respond_to? :run
                    subscriber.run(task)
                end
            end
            # TODO  为了debug
            # 这里内存会泄漏，需要清理内存
            # @tasks.pop
        end

        # TODO 对 taskname进行区分订阅
        def add_subscriber(subscriber)
            @subscribers[subscriber.id.to_s] = subscriber
            return subscriber.id
        end

        def remove_subscriber(subscriber)
            @subscribers.delete(subscriber.id.to_s)
            return subscriber.id
        end
    end

    Root_publisher = Publisher.new

    class SubscriberManagement 

        attr_accessor :name_list
        
        def initialize
            @name_list = {}
        end

        def register(subscriber)
            subscriber_id = "suber:"+SecureRandom.uuid
            while @name_list.has_key? subscriber_id
                subscriber_id = "suber:"+SecureRandom.uuid
            end

            subscriber.id = subscriber_id
            @name_list[subscriber_id.to_s] = subscriber

            return subscriber_id
        end

        def logout(subscriber)
            @name_list.delete(subscriber.id.to_s)
            return subscriber.id
        end
    end

    Root_subscriber_management = SubscriberManagement.new

    class Subscriber
        attr_accessor :name, :publisher, :id, :manager
        def initialize(name)
            @id = nil
            @name = name
            @publisher = Root_publisher
            @manager = Root_subscriber_management

            self.auto_register
        end

        def auto_register
            @manager.register(self)
        end

        def subscribe
            @publisher.add_subscriber(self)
        end

        def unsubscribe
            @publisher.remove_subscriber(self)
        end
    end
end