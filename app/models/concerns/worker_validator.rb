module WorkerValidator
  extend ActiveSupport::Concern

  # もう少しちゃんと考える
  included do
    validates :name, presence: true
    validates :branch_id, presence: true
  end
end
