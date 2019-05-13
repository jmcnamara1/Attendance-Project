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

  # index
  get "/student" do

  end

  # New
  get "/student/new" do

  end

  # Show
  get "/student/:id" do

  end

  # Edit
  get "/student/:id/edit" do

  end

  # Create
  post "/student/" do

  end

  # Update
  put "/student/:id" do

  end

  # Delete
  delete "/student/:id" do

  end

end
