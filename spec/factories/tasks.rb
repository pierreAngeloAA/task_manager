FactoryBot.define do
  factory :task do
    title { "Tarea de prueba" }
    description { "Descripción genérica de la tarea" }
    status { "pending" }
    due_date { Date.today + 3.days }
    association :user
  end
end
