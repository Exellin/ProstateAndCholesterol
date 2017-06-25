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

ActiveRecord::Schema.define(version: 20170513160906) do

  create_table "cholesterol_histories", force: :cascade do |t|
    t.integer  "year"
    t.string   "month"
    t.integer  "total_cholesterol"
    t.integer  "hdl"
    t.integer  "ldl"
    t.integer  "triglyceride"
    t.integer  "glucose"
    t.integer  "profile_id"
    t.datetime "created_at",        null: false
    t.datetime "updated_at",        null: false
    t.index ["profile_id"], name: "index_cholesterol_histories_on_profile_id"
  end

  create_table "comments", force: :cascade do |t|
    t.text     "content"
    t.integer  "post_id"
    t.integer  "user_id"
    t.integer  "parent_comment_id"
    t.boolean  "deleted",           default: false
    t.datetime "created_at",                        null: false
    t.datetime "updated_at",                        null: false
    t.index ["parent_comment_id"], name: "index_comments_on_parent_comment_id"
    t.index ["post_id"], name: "index_comments_on_post_id"
    t.index ["user_id"], name: "index_comments_on_user_id"
  end

  create_table "medications", force: :cascade do |t|
    t.string   "purpose"
    t.integer  "age_recommended"
    t.integer  "age_prescribed"
    t.string   "name"
    t.integer  "strength"
    t.integer  "dosage"
    t.integer  "year_last_used"
    t.string   "month_last_used"
    t.boolean  "still_using"
    t.integer  "profile_id"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.index ["profile_id"], name: "index_medications_on_profile_id"
  end

  create_table "posts", force: :cascade do |t|
    t.string   "title"
    t.text     "content"
    t.integer  "user_id"
    t.integer  "topic_id"
    t.boolean  "deleted",    default: false
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
    t.index ["topic_id"], name: "index_posts_on_topic_id"
    t.index ["user_id"], name: "index_posts_on_user_id"
  end

  create_table "profiles", force: :cascade do |t|
    t.integer  "user_id"
    t.string   "first_name"
    t.string   "last_name"
    t.integer  "birth_year"
    t.string   "city"
    t.string   "administrative_division"
    t.string   "country"
    t.integer  "years_in_current_locale"
    t.string   "ancestral_descent"
    t.string   "race"
    t.text     "story"
    t.integer  "age_noticed_symptoms"
    t.integer  "age_urinary_malfunction"
    t.integer  "age_bladder_infection"
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
    t.index ["user_id"], name: "index_profiles_on_user_id"
  end

  create_table "psa_histories", force: :cascade do |t|
    t.integer  "year"
    t.string   "month"
    t.decimal  "psa"
    t.integer  "profile_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["profile_id"], name: "index_psa_histories_on_profile_id"
  end

  create_table "topics", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string   "email",                  default: "",    null: false
    t.string   "encrypted_password",     default: "",    null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,     null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.boolean  "admin",                  default: false
    t.datetime "created_at",                             null: false
    t.datetime "updated_at",                             null: false
    t.string   "username"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

end
