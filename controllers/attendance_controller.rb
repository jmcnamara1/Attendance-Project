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
  post '/courses/:id' do
    foundFlag = false
    entryNumber = 0
    attendance_entries = Attendance.all

    attendance_entries.each do |entry|
      if entry.student_id == params[:student_id] && entry.attendance_date == params[:attendance_date]
        foundFlag = true
        entryNumber = entry.attendance_id
      end
    end

    if foundFlag == false

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

      new_attendance.save

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

    course_id = params[:id].to_i

    redirect "/courses/#{course_id}"
  end

end
