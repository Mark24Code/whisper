require "pstore"
require_relative "./core/base"

module Whisper

  DB = PStore.new("localstorage.db")

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