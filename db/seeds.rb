# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

require 'csv'

csv_text = File.read(Rails.root.join('lib', 'seeds', 'ALL_UNIQUE_COURSES.csv'))
csv = CSV.parse(csv_text, :headers => true, :encoding => 'ISO-8859-1')
csv.each do |row|
  puts row
  t = Course.new(
    course_id: row['CRSE_ID'],
    subject: row['SUBJECT'],
    subject_desc: row['SUBJECT_DESCR'],
    course_num: row['CATALOG_NBR'],
    title: row['COURSE_TITLE'],
    description: row['DESCRLONG']
    )
  t.save
end

majors = [
  {
    title: "MS in Computer Science",
    subject: "CS",
    concentration: nil
  },
  {
    title: "MS in Information Systems",
    subject: "IS",
    concentration: nil
  },
  {
    title: "MS in Information Systems",
    subject: "IS",
    concentration: "Business Analysis/Systems Analysis"
  },
  {
    title: "MS in Information Systems",
    subject: "IS",
    concentration: "Business Intelligence"
  },
  {
    title: "MS in Information Systems",
    subject: "IS",
    concentration: "Database Administration"
  },
  {
    title: "MS in Information Systems",
    subject: "IS",
    concentration: "IT Project Management"
  }
]

majors.each do |major|
  Major.new(title: major[:title], subject: major[:subject], concentration: major[:concentration]).save
end

csv_text = File.read(Rails.root.join('lib', 'seeds', 'UniqueSkills.csv'))
csv = CSV.parse(csv_text, :headers => true, :encoding => 'ISO-8859-1')
csv.each do |row|
  puts row
  t = Skill.new(
    name: row['Skills'],
    )
  t.save
end

csv_text = File.read(Rails.root.join('lib', 'seeds', 'CourseSkills.csv'))
csv = CSV.parse(csv_text, :headers => true, :encoding => 'ISO-8859-1')
csv.each do |row|
  puts row
  t = CourseSkill.new(
    course_id: row['course_id'],
    skill_id: row['skill_id']
    )
  t.save
end