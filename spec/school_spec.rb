require_relative "../models/school"

describe School do 
  context "When testing the School class with invalid arguments" do 
    it "should return false if we call the validate_input_format method with empty value " do 
      expect( School.validate_input_format "" ).to eq false
    end

    it "should return false if we call the validate_input_format method with score > 100" do 
      expect(School.validate_input_format "1,S1-123,S2-76,S3-35,S4-89" ).to eq false
    end

    it "should return false if we call the validate_input_format method with char id value " do 
      expect( School.validate_input_format "a,S1-23,S2-76,S3-35,S4-89" ).to eq false
    end

    it "should return false if we call the validate_input_format method with negative id value " do 
      expect( School.validate_input_format "-21,S1-23,S2-76,S3-35,S4-89" ).to eq false
    end

    it "should return false if we call the validate_input_format method with missing '-' " do 
      expect( School.validate_input_format "1,S123,S2-76,S3-35,S4-89" ).to eq false
    end

    it "should return false if we call the validate_input_format method with missing ',' " do 
      expect( School.validate_input_format "1S1-23,S2-76,S3-35,S4-89" ).to eq false
    end

    it "should return false if we call the validate_input_format method with missing or lowercase 'S' " do 
      expect( School.validate_input_format "1,23,s2-76,S3-35,S4-89" ).to eq false
    end

    it "should return false if we call the validate_input_format method with extra char in-between " do 
      expect( School.validate_input_format "1,@S1-23,S2-76,S3-35,S4-89" ).to eq false
    end

    it "should return false if we call the validate_input_format method with greater subject number " do 
      expect( School.validate_input_format "1, S9-23,S2-76,S3-35,S4-89" ).to eq false
    end

  end

  context "When testing the School class with no arguments" do
     
    it "should raise an error if we call the validate_input_format method without argument " do 
      expect { School.validate_input_format }.to raise_error(ArgumentError)
    end

    it "should raise an error if we call the create_class_room method without argument " do 
      expect { School.create_class_room }.to raise_error(ArgumentError)
    end

  end

  context "When testing the School class with valid arguments" do 
    
    it "should return array of score string if we call the validate_input_format method with subject mark value as 0 " do 
      student = School.validate_input_format "1,S1-00,S2-0,S3-01,S4-64"
      expect(student).to eq true
    end

    it "should return student string ignoring leading and trailing spaces if present when we call the validate_input_format method " do 
      student = School.validate_input_format "    1,S1-23,S2-76,S3-35,S4-89 "
      expect(student).to eq true
    end

  end
  
end