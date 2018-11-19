class CourseSkill < ApplicationRecord
  belongs_to :course
  belongs_to :skill
  
  def course_title
    course = Course.where(:id => self.course_id)[0]
    if course
      return course.full_title
    else
      return ""
    end
  end
  
  def skill_name
    skill = Skill.where(:id => self.skill_id)[0]
    if skill
      return skill.name
    else
      return ""
    end
  end
  
  def self.to_csv
    attributes = %w{course_id skill_id}
    
    CSV.generate(headers: true) do |csv|
      csv << attributes
    
      all.each do |course_skills|
        csv << attributes.map{ |attr| course_skills.send(attr) }
      end
    end
  end
end
