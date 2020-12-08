require_relative "./models"
require_relative "./actions"

module Whisper
  StoreInstance = Whisper::Store.new.data
  ActionInstance = Controller.new(StoreInstance)
end

