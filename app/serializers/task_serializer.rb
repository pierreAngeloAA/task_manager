class TaskSerializer < ActiveModel::Serializer
  attributes :id, :title, :description, :status, :due_date

  def status
    object.status
  end
end
