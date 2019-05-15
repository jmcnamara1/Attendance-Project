class Student

  attr_accessor :student_id, :first_name, :last_name, :course_id, :student_attendance, :attendance_date, :attendance_status_id, :description

  # Establishes connection to the "stores" database within PostGres
    def self.open_connection
      PG.connect(dbname: "attendance_app")
    end

    # Requests all students data
    def self.all
      conn = self.open_connection

      sql = "SELECT * FROM students ORDER BY student_id"

      response = conn.exec(sql)

      students = response.map do |data_item|
        self.hydrate data_item
      end

      return students
    end

    def self.course_attendees(id)
      conn = self.open_connection

      sql = "SELECT * FROM students WHERE course_id=#{id}"

      response = conn.exec(sql)

      students = response.map do |data_item|
        self.hydrate(data_item)
      end

      return students
    end

    def self.course_attendees_status(id)
      conn = self.open_connection

      sql = "SELECT * FROM students s
            INNER JOIN student_attendance sa ON sa.student_id = s.student_id
            WHERE course_id=#{id}"

      response = conn.exec(sql)

      students = response.map do |data_item|
        self.hydrate_a(data_item)
      end

      return students
    end

    # delete data from database
    def self.destroy id
      conn = self.open_connection

      sql = "DELETE FROM students WHERE student_id = #{id}"

      conn.exec(sql)
    end

    # Convert the response from a PG::Result
    def self.hydrate data
      student = Student.new

      student.student_id = data['student_id']
      student.first_name = data['first_name']
      student.last_name = data['last_name']
      student.course_id = data['course_id']

      return student
    end


    def self.hydrate_a data
      student = Student.new

      student.student_id = data['student_id']
      student.first_name = data['first_name']
      student.last_name = data['last_name']
      student.course_id = data['course_id']
      student.student_attendance = data['student_attendance']
      student.attendance_date = data['attendance_date']
      student.attendance_status_id = data['attendance_status_id']
      student.description = data['description']

      return student
    end

end
