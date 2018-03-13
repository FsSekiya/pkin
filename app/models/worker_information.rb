class WorkerInformation < ApplicationRecord
  enum status: %i[preparing published archived]
end
