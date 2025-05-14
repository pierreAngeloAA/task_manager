Pasos para ejecutar el proyecto:

$ rails db:create
$ rails db:migrate
$ rails db:seed
$ bundle install
$ rails s

Correr pruebas:
$ bundle exec rspec


- Arquitectura General.

El proyecto está construido bajo el framework Ruby on Rails, siguiendo la convención MVC (Modelo-Vista-Controlador).La aplicación está diseñada como una API RESTful que permite la gestión de usuarios y sus tareas, utilizando PostgreSQL como sistema de base de datos relacional.

- Componentes principales.

1. Modelos
User: Usuarios del sistema. Contiene campos como email, full_name.
Task: Tareas asociadas a cada usuario. Contiene campos como title, description, status, due_date y la referencia a user_id.

Se definió una relación de uno a muchos (User has_many :tasks y Task belongs_to :user), utilizando las convenciones estándar de ActiveRecord. Las migraciones establecen claves foráneas y restricciones adecuadas para asegurar integridad referencial.

2. Controladores.
Los controladores están ubicados bajo el namespace Api:: para separar claramente la lógica de la API. Los endpoints implementados siguen una estructura RESTful clara.

Api::UsersController: permite listar todos los usuarios (index) y consultar el usuario autenticado (me).

Api::TasksController: permite al usuario autenticado realizar operaciones CRUD sobre sus propias tareas.

- Autenticación.

La autenticación se implementa mediante un token enviado en el encabezado Authorization, utilizando el patrón Bearer <token>. Para esto se incluyó el módulo Authenticable, el cual valida al usuario en cada request y expone el objeto @current_user para su uso dentro de los controladores.
Esto garantiza que cada usuario únicamente pueda acceder a sus propias tareas, reforzando el principio de seguridad por diseño.

- Pruebas Automatizadas.

Se utilizó RSpec como framework principal de pruebas, incluyendo:

1. Tests de modelos: para verificar validaciones.

2. Tests de endpoints (request specs): para garantizar el comportamiento correcto de la API bajo distintos escenarios.

3. Se utilizó FactoryBot para generar datos de prueba consistentes.