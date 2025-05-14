user = User.create!(
  email: "juan@example.com",
  full_name: "Juan Pérez",
  password: "password"
)

5.times do |i|
  Task.create!(
    title: "Tarea #{i + 1}",
    description: "Descripción de la tarea #{i + 1}",
    status: 0,
    due_date: Date.today + i.days,
    user: user
  )
end
