class Student

  attr_accessor :student_id, :first_name, :last_name, :course_id

  # Establishes connection to the "stores" database within PostGres
    def self.open_connection
      PG.connect(dbname: "attendance_app")
    end

    # Requests all students data
    def self.all
      conn = self.open_connection

      sql = "SELECT * FROM students ORDER BY id"

      response = conn.exec(sql)

      students = response.map do |data_item|
        self.hydrate data_item
      end

      return students
    end

    def self.course_attendees(id)
      conn = self.open_connection

      sql = "Select * FROM students where course_id=#{id}"

      response = conn.exec(sql)

      students = response.map do |data_item|
        self.hydrate(data_item)
      end

      return students
    end

    # delete data from database
    def self.destroy(id)
      conn = self.open_connection

      sql = "DELETE FROM students WHERE id = #{id}"

      conn.exec(sql)
    end

    # returns attendance history of individual student
    def self.attendance_history(id)
      conn = self.open_connection

      sql = "SELECT s.first_name + ' ' + s.last_name AS 'Name', sa.attendance_date AS 'Date',
              ast.status AS 'Attendance Status', sa.description FROM students s
              INNER JOIN student_attendance sa on s.student_id = sa.student_id
              INNER JOIN attendance_status ast on sa.attendance_status_id = ast.attendance_status_id
              where student_id='#{id}'"

      response = conn.exec(sql)

      attendance_history = response.map do |data_item|
        self.hydrate_attendance(data_item)
      end

      return attendance_history
    end

    # Convert the response from a PG::Result
    def self.hydrate(data)
      student = Student.new

      student.student_id = data['id']
      student.first_name = data['first_name']
      student.last_name = data['last_name']
      student.course_id = data['course_id']

      return student
    end

    def self.hydrate_attendance(data)
      student_records = Student.new

      student_records.name = data['Name']
      student_records.attendance_date = data['Date']
      student_records.status = data['Attendance Status']
      student_records.description = data['description']

      return student_records
    end

end
