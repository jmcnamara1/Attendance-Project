class Student

  attr_accessor: :student_id, :first_name, :last_name, :course_id

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
    def self.destroy id
      conn = self.open_connection

      sql = "DELETE FROM students WHERE id = #{id}"

      conn.exec(sql)
    end

    # Convert the response from a PG::Result
    def self.hydrate data
      student = Student.new

      student.student_id = data['id']
      student.first_name = data['first_name']
      student.last_name = data['last_name']
      student.course_id = data['course_id']

      return student
    end

end
