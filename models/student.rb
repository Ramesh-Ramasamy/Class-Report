class Student
    attr_accessor :id, :subject1, :subject2, :subject3, :subject4, :grade, :total, :average­_compare
    def initialize id, subject1, subject2, subject3, subject4
      #initializing id and all 4 subjects
      @id, @subject1, @subject2, @subject3, @subject4 = id, subject1, subject2, subject3, subject4
      #calculate and assign total
      @total = calculate_total
      #Assign grade
      @grade = get_grade @total
    end
    
    #factory for creating multiple student object
    def self.create_student_factory student_details
      uniq_ids = Set.new #Uniqness check
      students = student_details.map do |student|
        id, subjects_with_scores = student.split(",", 2)
        subject_marks = subjects_with_scores.split(",").map{|s| s.split("-")[1].to_i}
        raise "Duplicate Record found for id #{id}" if uniq_ids.include?(id) #If duplicate present
        uniq_ids.add(id)
        Student.new(id, *subject_marks)
      end
      [students, uniq_ids] # Return students and uniq student ids
    end

    #Calculating total
    def calculate_total
      @subject1 + @subject2 + @subject3 + @subject4
    end

    #getter for grade based on total
    def get_grade total 
      case total
        when 340..400 
          'A'
        when 300..340 
          'B'
        else 
          'C'
      end
    end
  
end