# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20181119060016) do

  create_table "course_skills", force: :cascade do |t|
    t.integer "course_id"
    t.integer "skill_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["course_id"], name: "index_course_skills_on_course_id"
    t.index ["skill_id"], name: "index_course_skills_on_skill_id"
  end

  create_table "courses", force: :cascade do |t|
    t.integer "course_id"
    t.string "subject"
    t.text "subject_desc"
    t.integer "course_num"
    t.string "title"
    t.text "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "job_objects", force: :cascade do |t|
    t.integer "listing_id"
    t.string "title"
    t.text "description"
    t.string "apply_text"
    t.string "apply_url"
    t.date "post_date"
    t.boolean "relocation_assistance"
    t.boolean "telecommuting"
    t.string "category"
    t.text "keywords"
    t.string "job_type"
    t.string "company_name"
    t.string "company_url"
    t.string "company_logo"
    t.string "company_tagline"
    t.string "job_url"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "perks"
    t.string "company_location"
  end

  create_table "job_searches", force: :cascade do |t|
    t.integer "search_type"
    t.string "search_keywords"
    t.string "search_results"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "search_location"
    t.integer "user_id"
    t.string "title"
    t.boolean "ready"
    t.index ["user_id"], name: "index_job_searches_on_user_id"
  end

  create_table "majors", force: :cascade do |t|
    t.string "title"
    t.string "subject"
    t.string "concentration"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "prerequisites", force: :cascade do |t|
    t.integer "course_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "prerequisite_id"
    t.index ["course_id"], name: "index_prerequisites_on_course_id"
  end

  create_table "skills", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "name"
    t.string "email"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "password_digest"
    t.integer "clearance"
    t.string "course_ids"
    t.integer "major_id"
    t.boolean "setup"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["major_id"], name: "index_users_on_major_id"
  end

end