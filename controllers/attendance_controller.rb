class AttendanceController < Sinatra::Base

  configure :development do
    register Sinatra::Reloader
  end

  # enable cookies
  helpers Sinatra::Cookies

  # sets root as the parent-directory of the current file
  set :root, File.join(File.dirname(__FILE__), '..')

  # sets the view directory correctly
  set :views, Proc.new { File.join(root, "views") }

  # Edit
  get "/students/:id/edit" do
    id = params[:id].to_i
    date = params[:date]

    dateArray = date.split('-')
    year = dateArray[0].to_i
    month = dateArray[1].to_i
    day = dateArray[2].to_i

    @student = Student.find(id)
    @attendance = Attendance.find_individual_day(id, day, month, year)

    erb :'attendance/edit'
  end

  # runs when students attendance is updated
  post '/courses/:id' do
    foundFlag = false
    entryNumber = 0
    attendance_entries = Attendance.all
    attendance_entries.each do |entry|

      if entry.student_id == params[:student_id] && entry.attendance_date == params[:attendance_date]
        foundFlag = true
      end

      if foundFlag == false
        puts "Not Found"
        course_id = params[:id].to_i
        new_attendance = Attendance.new()

        new_attendance.attendance_date = params[:attendance_date]

        status = params[:status]
        case status
        when 'On Time'
          new_attendance.attendance_status_id = 1
        when 'Slightly late(5 minutes)'
          new_attendance.attendance_status_id = 2
        when 'Very late(over 30 minutes)'
          new_attendance.attendance_status_id = 3
        when 'Absent'
          new_attendance.attendance_status_id = 4
        when 'Authorized Absence'
          new_attendance.attendance_status_id = 5
        end

        new_attendance.student_id = params[:student_id]
        new_attendance.description = params[:description]

        new_attendance.save()


      elsif foundFlag == true
        editAttendance = Attendance.find entryNumber

        editAttendance.attendance_date = params[:attendance_date]

        status = params[:status]
        case status
        when 'On Time'
          editAttendance.attendance_status_id = 1
        when 'Slightly late(5 minutes)'
          editAttendance.attendance_status_id = 2
        when 'Very late(over 30 minutes)'
          editAttendance.attendance_status_id = 3
        when 'Absent'
          editAttendance.attendance_status_id = 4
        when 'Authorized Absence'
          editAttendance.attendance_status_id = 5
        end

        editAttendance.student_id = params[:student_id]
        editAttendance.description = params[:description]

        editAttendance.save
      end
    end
      course_id = params[:id].to_i

      redirect "/courses/#{course_id}"
  end

  # update student attendance
  put '/students/:id' do
    id = params[:id].to_i
    date = params[:date]

    dateArray = date.split('-')
    year = dateArray[0].to_i
    month = dateArray[1].to_i
    day = dateArray[2].to_i

    attendance = Attendance.find_individual_day(id, day, month, year)

    status = params[:status]
    case status
    when 'On Time'
      attendance.attendance_status_id = 1
    when 'Slightly late(5 minutes)'
      attendance.attendance_status_id = 2
    when 'Very late(over 30 minutes)'
      attendance.attendance_status_id = 3
    when 'Absent'
      attendance.attendance_status_id = 4
    when 'Authorized Absence'
      attendance.attendance_status_id = 5
    end

    attendance.description = params[:comments]

    attendance.update(id, day, month, year)

    redirect "students/#{id}"
  end

end
