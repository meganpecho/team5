class CourseFinderController < ApplicationController
  def find_courses
    
  end
  
  def course_results
    values = []
    params.each do |key, value|
      logger.debug(key[0,6])
      if key[0,6] == "skill-"
        logger.debug(key[6..-1])
        values.push(key[6..-1].to_i)
      end
    end
    logger.debug(values)
    courses = []
    values.each do |val|
      CourseSkill.where("skill_id = ?", val).each do |course|
        if !courses.include? course.course_id
          courses.push(course.course_id)
        end
      end
    end
    taken = JSON.parse(current_user.course_ids)
    taken.each do |course_id|
      if courses.include? course_id
        courses.delete(course_id)
      end
    end
    logger.debug(taken)
    logger.debug(courses)
    @courses = courses.map { |c| Course.find(c) }
    logger.debug(courses)
  end
end
