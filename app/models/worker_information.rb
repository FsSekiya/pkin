class WorkerInformation < ApplicationRecord
  belongs_to :worker
  enum status: %i[preparing published archived]
end
