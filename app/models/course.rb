class Course < ApplicationRecord
    has_many :prerequisites
    has_many :prerequisite_id, class_name: "Prerequisite", foreign_key: "prerequisite_id"
    
    def prerequisites
        directPre = Prerequisite.where("course_id = ?", self.id)
        directPre.each do |pre|
            
        end
    end
    
    def full_title
        "#{self.subject} #{self.course_num} #{self.title}"
    end
    
    def skills
        skills = CourseSkill.where("course_id = ?", self.id)
        skills_a = []
        skills.each do |skill|
            skills_a.push(Skill.find(skill.skill_id))
        end
        return skills_a
    end
    
    def self.to_csv
      attributes = %w{course_id subject subject_desc course_num title description}
      
      CSV.generate(headers: true) do |csv|
        csv << attributes
      
        all.each do |course|
          csv << attributes.map{ |attr| course.send(attr) }
        end
      end
    end
end
