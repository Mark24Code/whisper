require "pstore"
require_relative "./core/base"
require_relative "./settings"
module Whisper

  DB = PStore.new(Whisper::Config[:local_db_name])

  # config table
  DB.transaction do 
    DB[:target_host] = nil
    DB[:target_port] = nil
  end

  # db init table
  DB.transaction do 
    DB[:timelines] ||= Array.new
  end

  DB.transaction do 
    DB[:test_content] = "Hello World"
  end
 
  class Store < Model
    attr_reader :app, :db

    def initialize(app)
      @app = app
      @db = DB
    end

    def set(key,val)
      @db.transaction do
        @db[key] = val
      end

      @app.render
      return val
    end

    def get(key) 
      val = nil
      @db.transaction do 
        val = @db[key]
      end
      return val
    end
  end
end