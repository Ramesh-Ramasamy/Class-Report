require_relative '../models/student'

describe Student do

  context "When testing the Student class with invalid arguments" do

    it "should throw an error if we call the create_student_factory method with duplicate student entry" do
      student_details = ["1,S1-18,S2-34,S3-56,S4-54","2,S1-23,S2-78,S3-87,S4-67","2,S1-23,S2-78,S3-87,S4-67"]
      expect { Student.create_student_factory student_details }.to raise_error(RuntimeError,/Duplicate Record found for id/)
    end

  end

  context "When testing the Student class with no arguments" do 

    it "should raise an error if we call the validate_input_format method without argument " do 
      expect {  Student.create_student_factory }.to raise_error(ArgumentError)
    end

  end

  context "When testing the Student class with valid arguments" do 

    it "should create student if we call the create_student_factory method with duplicate correct entry" do
      student_details = ["1,S1-18,S2-34,S3-56,S4-54","2,S1-23,S2-78,S3-87,S4-67"]
      students, student_ids = Student.create_student_factory student_details
      expect(student_ids.include?("1")).to eq true
    end

    it "should calcualte total for the subject_mark arguments passed" do 
      random_marks = [34,78,45,89]
      st = Student.new 1, *random_marks
      expect(st.total).to eq random_marks.sum
    end
    
    it "should return the garde when we call the get_grade method even with the edge values" do 
      random_marks = [100,100,100,40]
      st = Student.new 1, *random_marks
      grade = st.get_grade st.total
      if st.total >= 340
        expect(grade).to eq "A"
      elsif st.total >= 300
        expect(grade).to eq "B"
      else
        expect(grade).to eq "C"
      end
    end
    
  end
  
end