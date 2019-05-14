class Course

  attr_accessor :course_id, :name, :course_type, :start_date, :end_date

  # connection to database
  def self.open_connection
    PG.connect(dbname: "attendance_app")
  end

  # get all data from courses table
  def self.all
    conn = self.open_connection
    sql = "SELECT * FROM courses ORDER BY id"

    response = conn.exec(sql)

    # mapping new array by hydrating each response from the db
    courses = response.map do |data_item|
      self.hydrate(data_item)
    end

    return courses
  end
  # Info from 1 course
  def self.find(id)
    conn = self.open_connection

    sql = "SELECT * FROM courses where id=#{id}"

    response = conn.exec(sql)

    course = response.map do |data_item|
      self.hydrate(data_item)
    end

    return course
  end

  # destroy course from table
  def self.destroy(id)
    conn = self.open_connection

    sql = "DELETE FROM courses WHERE id = #{id}"

    conn.exec(sql)
  end

  def self.hydrate(data)
    course = Course.new()

    # column names go in quotations
    course.course_id = data['id']
    course.name = data['name']
    course.course_type = data['course_type']
    course.start_date = data['start_date']
    course.end_date = data['end_date']

    return course
  end

end
