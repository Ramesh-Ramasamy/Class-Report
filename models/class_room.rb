require 'set'
class ClassRoom
  attr_accessor :standard, :students, :student_uniq_ids

  def initialize standard
    @standard = standard
    @students = [] 
    @student_uniq_ids = Set.new
  end

  # Factory to create the classroom, students
  def self.create_classroom_factory standard, student_details
    cr = ClassRoom.new standard
    cr.students, cr.student_uniq_ids = Student.create_student_factory student_details
    cr.assign_average_compare
    cr
  end

  # group by grade, using instance variable to avoid recalculation 
  def group_by_grade
    @grade_student_mapping ||= @students.group_by{|st| st.grade}
  end

  # group by average compare
  def group_by_average­_compare
    @average­_compare_student_mapping ||= @students.group_by{|st| st.average­_compare}
  end

  # return count of given grade
  def grade_count grade
    group_by_grade.keys.include?(grade) ? group_by_grade[grade].count : 0
  end

  # return count of given comparator(Above/Below)
  def grade_average_compare_count comparator
    group_by_average­_compare.keys.include?(comparator) ? group_by_average­_compare[comparator].count : 0
  end

  # calculating average mark for all the grades
  def grade_average
    @grade_average_map ||= group_by_grade.keys.each_with_object({}) do |g, grade_average_map|
      grade_average_map[g] = group_by_grade[g].map{|s| s.total}.sum / group_by_grade[g].count
    end
  end
  
  # return average mark for the given grade
  def specific_grade_average grade    
    grade_average[grade]
  end

  # Assign average compare for all the students
  def assign_average_compare
    @students.each do |st|
      st.average­_compare = st.total >=  specific_grade_average(st.grade) ? "ABOVE" : "BELOW" 
    end
  end

  # print score card for the class room
  def score_card
    p "ID | Subject1 | Subject2 | Subject3 | Subject4 | GrandTotal | Grade |  Average-Compare"
    @students.each do |st|
      p "|#{st.id}|  #{st.subject1} | #{st.subject2} |  #{st.subject3}  | #{st.subject4}  | #{st.total}  | #{st.grade} | #{st.average­_compare} |"
    end
    p "******************************************"
    p "******************************************"
    p "Grade Report"
    p "Number of students in A Grade :: #{grade_count 'A'}" 
    p "Number of students in B Grade :: #{grade_count 'B'}"
    p "Number of students in C Grade :: #{grade_count 'C'}"
    p "Number of students above their grade average :: #{grade_average_compare_count 'ABOVE'}"
    p "Number of students below their grade average :: #{grade_average_compare_count 'BELOW'}"

    p "******************************************"
  end

end