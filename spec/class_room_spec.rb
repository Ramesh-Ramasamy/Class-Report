require_relative '../models/class_room'
require_relative '../models/student'

describe ClassRoom do
  context "When testing the ClassRoom class with invalid arguments" do

    it "should throw an error if we call the create_classroom_factory method with duplicate student entry" do
      score_details = ["1,S1-18,S2-34,S3-56,S4-54","2,S1-23,S2-78,S3-87,S4-67","2,S1-23,S2-78,S3-87,S4-67"]
      expect { ClassRoom.create_classroom_factory("vii", score_details) }.to raise_error(RuntimeError,/Duplicate Record found for id/)
    end

  end

  context "When testing the ClassRoom class with valid arguments" do

    it "should create students if we call the create_classroom_factory method with valid student entry" do
      score_details = ["1,S1-18,S2-34,S3-56,S4-54","2,S1-23,S2-78,S3-87,S4-67"]
      cr = ClassRoom.create_classroom_factory("vii", score_details)
      expect(cr.student_uniq_ids.include?("1")).to eq true
    end

  end
  
end