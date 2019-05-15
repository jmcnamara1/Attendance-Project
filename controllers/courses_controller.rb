class CoursesController < Sinatra::Base

  configure :development do
		register Sinatra::Reloader
	end

	helpers Sinatra::Cookies

	enable :sessions

	# sets root as the parent-directory of the current file
	set :root, File.join(File.dirname(__FILE__), '..')

	# sets the view directory correctly
	set :views, Proc.new { File.join(root, "views") }


  # Index
  get '/courses' do
    @courses = Course.all

    erb  :'courses/index'
  end

  # New
  get '/courses/new' do

    @course = Course.new

    erb :'courses/new'
  end

  # Show
  get '/courses/:id' do
    id = params[:id].to_i

    @course = Course.find(id)
    @attendance_list = Student.course_attendees_status(id)

    erb :'/courses/show'

  end


  # Edit
  get '/courses/:id/edit' do

  end

  # Create
  post '/courses/' do
    new_course = Course.new

    new_course.name = params[:name]
    new_course.course_type = params[:course_type]
    new_course.start_date = params[:start_date].to_s
    new_course.end_date = params[:end_date].to_s

    new_course.save

    redirect "/courses"

  end


  # Update
  put '/courses/:id' do
    id = params[:id].to_i

    course = Course.find id

    course.name = params[:name]
    course.course_type = params[:course_type]
    course.start_date = params[:start_date]
    course.end_date = params[:end_date]

    course.save

    redirect "/courses/#{course_id}"
  end


  # Delete
  delete '/courses/:id' do
    id = params[:id].to_i

    Course.update_course id
    Course.destroy id

    redirect "/courses"

  end

end
