# encoding: UTF-8
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

ActiveRecord::Schema.define(version: 20140924125124) do

  create_table "admins", force: true do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "admins", ["email"], name: "index_admins_on_email", unique: true
  add_index "admins", ["reset_password_token"], name: "index_admins_on_reset_password_token", unique: true

  create_table "candidatures", force: true do |t|
    t.boolean  "daytime_availability"
    t.boolean  "nighttime_availability"
    t.string   "time_period_preference"
    t.integer  "course1_id"
    t.integer  "course2_id"
    t.integer  "course3_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "student_id"
    t.text     "observation",            default: ""
    t.integer  "course4_id"
    t.integer  "semester_id"
  end

  create_table "courses", force: true do |t|
    t.string   "name"
    t.string   "course_code"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "department_id"
    t.integer  "educational_level", default: 0
  end

  create_table "departments", force: true do |t|
    t.string   "code"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "departments", ["code"], name: "index_departments_on_code", unique: true

  create_table "dumps", force: true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "professors", force: true do |t|
    t.string   "name"
    t.string   "nusp"
    t.string   "email"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.integer  "department_id"
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "unconfirmed_email"
    t.integer  "professor_rank",         default: 0
  end

  create_table "request_for_teaching_assistants", force: true do |t|
    t.integer  "professor_id"
    t.integer  "requested_number"
    t.integer  "priority"
    t.boolean  "student_assistance", default: false
    t.boolean  "work_correction",    default: false
    t.boolean  "test_oversight",     default: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "course_id"
    t.text     "observation",        default: ""
  end

  add_index "request_for_teaching_assistants", ["course_id"], name: "index_request_for_teaching_assistants_on_course_id"

  create_table "secretaries", force: true do |t|
    t.string   "nusp"
    t.string   "name"
    t.string   "email"
    t.string   "password"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "unconfirmed_email"
  end

  create_table "semesters", force: true do |t|
    t.integer  "year"
    t.integer  "parity"
    t.boolean  "open"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "semesters", ["year", "parity"], name: "index_semesters_on_year_and_parity", unique: true

  create_table "students", force: true do |t|
    t.string   "name"
    t.string   "password"
    t.string   "nusp"
    t.integer  "gender"
    t.string   "rg"
    t.string   "cpf"
    t.string   "address"
    t.string   "complement"
    t.string   "district"
    t.string   "zipcode"
    t.string   "city"
    t.string   "state"
    t.string   "tel"
    t.string   "cel"
    t.string   "email"
    t.boolean  "has_bank_account",       default: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "encrypted_password",     default: "",    null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,     null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "unconfirmed_email"
    t.string   "institute"
  end

  add_index "students", ["nusp"], name: "index_students_on_nusp", unique: true

end
