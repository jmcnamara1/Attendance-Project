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

    def self.find id
      conn = self.open_connection

      sql = "SELECT * FROM students WHERE student_id = #{id}"

      response = conn.exec(sql)

      return self.hydrate response[0]
    end


    def save
      conn = Student.open_connection

      if (self.student_id)
        sql = "UPDATE students SET first_name='#{self.first_name}', last_name='#{self.last_name}', course_id='#{self.course_id}' WHERE student_id = '#{self.student_id}'"
      else
        sql = "INSERT INTO students (first_name ,last_name ,course_id ) VALUES ('#{self.first_name}', '#{self.last_name}', '#{self.course_id}')"
      end

      conn.exec(sql)
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
