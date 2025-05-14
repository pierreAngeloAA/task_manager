user = User.create!(
  email: "juan@example.com",
  full_name: "Juan Pérez",
  role: "admin"
)

5.times do |i|
  Task.create!(
    title: "Tarea #{i + 1}",
    description: "Descripción de la tarea #{i + 1}",
    status: "pendiente",
    due_date: Date.today + i.days,
    user: user
  )
end
