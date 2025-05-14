class Task < ApplicationRecord
  belongs_to :user

  enum :status, [:pending, :completed]
end
