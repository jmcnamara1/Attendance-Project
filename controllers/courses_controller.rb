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
  get '/course' do
    # Changed to Course instead of Courses
    @courses = Course.all
    # Changed to course intead of courses
    erb: 'course/index'
  end

  # New
  get '/course/new' do


  end

  # Show
  get '/course/:id' do


  end


  # Edit
  get '/course/:id/edit' do


  end


  # Create
  post '/course/' do


  end


  # Update
  put '/course/:id' do


  end


  # Delete
  delete '/course/:id' do


  end

end
