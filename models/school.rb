require_relative './student'
require_relative "./class_room"
class School
  #Read inputs from file
  def self.read_student_details
    File.read("input.txt")
  end

  #validate input using regex
  def self.validate_input_format student
    (/^[0-9]+,(S[1-4]-([0-9]{1,2}|100),){3}S[1-4]-([0-9]{1,2}|100)$/ =~ student.strip) == 0
  end

  #extract student details from file content
  def self.extract_student_details student_details
    raise("Empty student details provided") if student_details.nil? || student_details.empty?
    students = []
    student_details.split("\n").each_with_index do |student, index|
      student = student.strip  #remove leading and trailing spaces
      if validate_input_format student
        students << student  #inserting every valid record from input file to input list
      else
        raise "Invalid student entry at line number - #{index+1}"
      end
    end
    students
  end

  #create the class and assign students using create_classroom_factory
  def self.create_class_room standard
    student_details = extract_student_details(read_student_details)
    class_room = ClassRoom.create_classroom_factory standard, student_details
  end

end

class_vii = School.create_class_room "vii" #create object for class vii
class_vii.score_card # display score card 