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

  # runs when students attendance is updated
  post '/attendance' do
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
  end

  new_attendance.save()
end
