class StudentsController < Sinatra::Base

  configure :development do
		register Sinatra::Reloader
	end

	# enable cookies
	helpers Sinatra::Cookies

	# sets root as the parent-directory of the current file
	set :root, File.join(File.dirname(__FILE__), '..')

	# sets the view directory correctly
	set :views, Proc.new { File.join(root, "views") }

  # New
  get "/students/new" do

  end

  # Show
  get "/students/:id" do
    id = params[:id].to_i

    @attendance_record = Student.attendance_history(id)

    erb :'students/show'
  end

  # Edit
  get "/students/:id/edit" do

  end

  # Create
  post "/students/" do

  end

  # Update
  put "/students/:id" do

  end

  # Delete
  delete "/students/:id" do

  end

end
