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

ActiveRecord::Schema.define(version: 20190516162954) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"
  enable_extension "postgis"
  enable_extension "pg_trgm"

  create_table "bookings", force: :cascade do |t|
    t.integer  "seats",      default: [],              array: true
    t.integer  "user_id"
    t.integer  "movie_id"
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
    t.index ["movie_id"], name: "index_bookings_on_movie_id", using: :btree
    t.index ["user_id"], name: "index_bookings_on_user_id", using: :btree
  end

  create_table "books", force: :cascade do |t|
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.string   "title",       limit: 32, default: "", null: false
    t.float    "price"
    t.integer  "subject_id"
    t.text     "description"
  end

  create_table "c_books", force: :cascade do |t|
    t.string   "name"
    t.string   "author"
    t.date     "publish_year"
    t.string   "category"
    t.float    "price"
    t.integer  "sold_count"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.index ["author"], name: "index_c_books_on_author", using: :btree
    t.index ["category"], name: "index_c_books_on_category", using: :btree
    t.index ["name"], name: "index_c_books_on_name", using: :btree
    t.index ["sold_count"], name: "index_c_books_on_sold_count", using: :btree
  end

  create_table "e_users", force: :cascade do |t|
    t.string   "name"
    t.string   "email"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_e_users_on_email", unique: true, using: :btree
  end

  create_table "expenses", force: :cascade do |t|
    t.string   "name"
    t.string   "split_type"
    t.float    "amount"
    t.integer  "e_user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["e_user_id"], name: "index_expenses_on_e_user_id", using: :btree
  end

  create_table "movies", force: :cascade do |t|
    t.string   "name"
    t.integer  "seats",      default: [],              array: true
    t.integer  "theater_id"
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
    t.index ["theater_id"], name: "index_movies_on_theater_id", using: :btree
  end

  create_table "subjects", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string   "name"
  end

  create_table "theaters", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "user_expenses", force: :cascade do |t|
    t.float    "amount"
    t.float    "settled"
    t.boolean  "complete"
    t.integer  "payer_id"
    t.integer  "payee_id"
    t.integer  "expense_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["expense_id"], name: "index_user_expenses_on_expense_id", using: :btree
  end

  create_table "users", force: :cascade do |t|
    t.string   "name"
    t.string   "password"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "bookings", "movies"
  add_foreign_key "bookings", "users"
  add_foreign_key "expenses", "e_users"
  add_foreign_key "movies", "theaters"
  add_foreign_key "user_expenses", "expenses"
end
