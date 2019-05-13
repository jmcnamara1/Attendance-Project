require "sinatra"
require "sinatra/reloader"
require "sinatra/cookies"
require "pg"

# controllers
require_relative "controllers/static_controller.rb"
require_relative "controllers/students_controller.rb"
require_relative "controllers/courses_controller.rb"

# models
require_relative "models/course.rb"
require_relative "models/student.rb"

use Rack::MethodOverride

use StoresController
use StaticController
run PizzasController
