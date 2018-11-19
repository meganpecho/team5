module PrerequisitesHelper
    
    def getCourses()
        courses = Course.all.select(:title, :id, :subject, :course_num).order(:subject).group_by(&:subject)
        results = { results: [], paginate: { more: true } }
        courses.each do |subject, course_sub|
          group = {
            text: subject,
            children: []
          }
          course_sub.each do |course|
            formatted = {
              id: course.id.to_s,
              text: "[#{course.subject} #{course.course_num}] #{course.title}"
            }
            group[:children].push(formatted)
          end
          results[:results].push(group)
        end
        return results
    end
end
