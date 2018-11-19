module SetupsHelper
    
    def getCourses()
        courses = Course.all.select(:title, :id, :subject, :course_num).order(:subject, :course_num)
        results = []
        courses.each do |course|
          results.push({
            class_num: course.course_num.to_s,
            class_name: course.title,
            class_type: course.subject,
            class_id: course.id.to_s,
            search_help: "#{course.subject} #{course.course_num}"
          })
        end
        return results
    end
    
end
