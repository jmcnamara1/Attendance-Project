class StudentsController < Sinatra::Base

  configure :development do
		register Sinatra::Reloader
	end

	# enable cookies
	helpers Sinatra::Cookies

  enable :sessions

	# sets root as the parent-directory of the current file
	set :root, File.join(File.dirname(__FILE__), '..')

	# sets the view directory correctly
	set :views, Proc.new { File.join(root, "views") }

  # New
  get "/students/new" do

    @courses = Course.all
    @student = Student.new

    erb :'students/new'
  end

  # Show
  get "/students/:id" do
    id = params[:id].to_i

    @attendance_record = Student.attendance_history(id)

    @ot = 0.0
    @sl = 0.0
    @vl = 0.0
    @a = 0.0
    @aa = 0.0

    @attendance_record.each do |daily_record|
      case daily_record.status
        when 'On Time'
          @ot+=1
        when 'less than 5 mins late'
          @sl+=1
        when 'more than 5 mins late'
          @vl+=1
        when 'Absent'
          @a+=1
        when 'Authorised Absence'
          @aa+=1
      end
    end

    @student = Student.find(id)
    @course = Course.find(@student.course_id)

    erb :'students/show'
  end

  # Edit
  get "/students/:id/edit" do

  end

  # Create
  post "/students/" do
    new_student = Student.new

    new_student.first_name = params[:first_name]
    new_student.last_name = params[:last_name]
    new_student.course_id = params[:course_id].to_i

    new_student.save

    redirect "/courses/#{new_student.course_id}"

  end

  # Update
  put "/students/:id" do
    id = params[:id].to_i

    student = Student.find id

    student.first_name = params[:first_name]
    student.last_name = params[:last_name]
    student.course_id = params[:course_id].to_i

    student.save

    redirect "/courses/#{course_id}"

  end

  # Delete
  delete "/students/:id" do

  end

end
