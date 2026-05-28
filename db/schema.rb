# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[8.1].define(version: 2026_05_28_043809) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "pg_catalog.plpgsql"

  create_table "active_storage_attachments", force: :cascade do |t|
    t.bigint "blob_id", null: false
    t.datetime "created_at", null: false
    t.string "name", null: false
    t.bigint "record_id", null: false
    t.string "record_type", null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", force: :cascade do |t|
    t.bigint "byte_size", null: false
    t.string "checksum"
    t.string "content_type"
    t.datetime "created_at", null: false
    t.string "filename", null: false
    t.string "key", null: false
    t.text "metadata"
    t.string "service_name", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "active_storage_variant_records", force: :cascade do |t|
    t.bigint "blob_id", null: false
    t.string "variation_digest", null: false
    t.index ["blob_id", "variation_digest"], name: "index_active_storage_variant_records_uniqueness", unique: true
  end

  create_table "activities", force: :cascade do |t|
    t.bigint "comment_id", null: false
    t.datetime "created_at", null: false
    t.text "description"
    t.bigint "subtask_id", null: false
    t.bigint "task_id", null: false
    t.datetime "updated_at", null: false
    t.bigint "user_id", null: false
    t.index ["comment_id"], name: "index_activities_on_comment_id"
    t.index ["subtask_id"], name: "index_activities_on_subtask_id"
    t.index ["task_id"], name: "index_activities_on_task_id"
    t.index ["user_id"], name: "index_activities_on_user_id"
  end

  create_table "board_sections", force: :cascade do |t|
    t.bigint "board_id", null: false
    t.datetime "created_at", null: false
    t.integer "position"
    t.bigint "status_id", null: false
    t.datetime "updated_at", null: false
    t.index ["board_id"], name: "index_board_sections_on_board_id"
    t.index ["status_id"], name: "index_board_sections_on_status_id"
  end

  create_table "boards", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.integer "created_by"
    t.string "name"
    t.bigint "project_id", null: false
    t.datetime "updated_at", null: false
    t.bigint "workspace_id", null: false
    t.index ["project_id"], name: "index_boards_on_project_id"
    t.index ["workspace_id"], name: "index_boards_on_workspace_id"
  end

  create_table "cards", force: :cascade do |t|
    t.bigint "board_id", null: false
    t.datetime "created_at", null: false
    t.text "description"
    t.bigint "status_id", null: false
    t.string "title"
    t.datetime "updated_at", null: false
    t.index ["board_id"], name: "index_cards_on_board_id"
    t.index ["status_id"], name: "index_cards_on_status_id"
  end

  create_table "comments", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.text "description"
    t.bigint "task_id", null: false
    t.datetime "updated_at", null: false
    t.bigint "user_id", null: false
    t.index ["task_id"], name: "index_comments_on_task_id"
    t.index ["user_id"], name: "index_comments_on_user_id"
  end

  create_table "labels", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.string "name"
    t.datetime "updated_at", null: false
  end

  create_table "memberships", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.integer "role", default: 0, null: false
    t.datetime "updated_at", null: false
    t.bigint "user_id", null: false
    t.bigint "workspace_id", null: false
    t.index ["user_id"], name: "index_memberships_on_user_id"
    t.index ["workspace_id"], name: "index_memberships_on_workspace_id"
  end

  create_table "notifications", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.bigint "notifiable_id", null: false
    t.string "notifiable_type", null: false
    t.datetime "updated_at", null: false
    t.bigint "user_id", null: false
    t.index ["notifiable_type", "notifiable_id"], name: "index_notifications_on_notifiable"
    t.index ["user_id"], name: "index_notifications_on_user_id"
  end

  create_table "projects", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.text "description"
    t.string "name"
    t.datetime "updated_at", null: false
    t.bigint "workspace_id", null: false
    t.index ["workspace_id"], name: "index_projects_on_workspace_id"
  end

  create_table "statuses", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.string "name"
    t.datetime "updated_at", null: false
  end

  create_table "story_points", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.string "label"
    t.datetime "updated_at", null: false
    t.integer "value"
  end

  create_table "subtasks", force: :cascade do |t|
    t.integer "assignee"
    t.datetime "created_at", null: false
    t.text "description"
    t.date "end_date"
    t.date "start_date"
    t.bigint "status_id", null: false
    t.bigint "story_point_id", null: false
    t.bigint "task_id", null: false
    t.string "title"
    t.datetime "updated_at", null: false
    t.index ["status_id"], name: "index_subtasks_on_status_id"
    t.index ["story_point_id"], name: "index_subtasks_on_story_point_id"
    t.index ["task_id"], name: "index_subtasks_on_task_id"
  end

  create_table "task_types", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.string "name"
    t.datetime "updated_at", null: false
  end

  create_table "tasks", force: :cascade do |t|
    t.integer "assignee"
    t.datetime "created_at", null: false
    t.text "description"
    t.date "end_date"
    t.bigint "label_id", null: false
    t.bigint "project_id", null: false
    t.date "start_date"
    t.bigint "status_id", null: false
    t.bigint "story_point_id", null: false
    t.bigint "task_type_id", null: false
    t.string "title"
    t.datetime "updated_at", null: false
    t.index ["label_id"], name: "index_tasks_on_label_id"
    t.index ["project_id"], name: "index_tasks_on_project_id"
    t.index ["status_id"], name: "index_tasks_on_status_id"
    t.index ["story_point_id"], name: "index_tasks_on_story_point_id"
    t.index ["task_type_id"], name: "index_tasks_on_task_type_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "avatar"
    t.string "city"
    t.datetime "confirmation_sent_at"
    t.string "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "created_at", null: false
    t.datetime "current_sign_in_at"
    t.string "current_sign_in_ip"
    t.datetime "deleted_at"
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.integer "failed_attempts", default: 0, null: false
    t.string "first_name"
    t.string "last_name"
    t.datetime "last_sign_in_at"
    t.string "last_sign_in_ip"
    t.datetime "locked_at"
    t.string "phone"
    t.integer "pincode"
    t.datetime "remember_created_at"
    t.datetime "reset_password_sent_at"
    t.string "reset_password_token"
    t.integer "role", default: 0
    t.integer "sign_in_count", default: 0, null: false
    t.string "state"
    t.string "street"
    t.string "unconfirmed_email"
    t.string "unlock_token"
    t.datetime "updated_at", null: false
    t.index ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
    t.index ["unlock_token"], name: "index_users_on_unlock_token", unique: true
  end

  create_table "workspaces", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.text "description"
    t.string "name"
    t.bigint "owner_id"
    t.datetime "updated_at", null: false
    t.index ["owner_id"], name: "index_workspaces_on_owner_id"
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "active_storage_variant_records", "active_storage_blobs", column: "blob_id"
  add_foreign_key "activities", "comments"
  add_foreign_key "activities", "subtasks"
  add_foreign_key "activities", "tasks"
  add_foreign_key "activities", "users"
  add_foreign_key "board_sections", "boards"
  add_foreign_key "board_sections", "statuses"
  add_foreign_key "boards", "projects"
  add_foreign_key "boards", "workspaces"
  add_foreign_key "cards", "boards"
  add_foreign_key "cards", "statuses"
  add_foreign_key "comments", "tasks"
  add_foreign_key "comments", "users"
  add_foreign_key "memberships", "users"
  add_foreign_key "memberships", "workspaces"
  add_foreign_key "notifications", "users"
  add_foreign_key "projects", "workspaces"
  add_foreign_key "subtasks", "statuses"
  add_foreign_key "subtasks", "story_points"
  add_foreign_key "subtasks", "tasks"
  add_foreign_key "tasks", "labels"
  add_foreign_key "tasks", "projects"
  add_foreign_key "tasks", "statuses"
  add_foreign_key "tasks", "story_points"
  add_foreign_key "tasks", "task_types"
  add_foreign_key "workspaces", "users", column: "owner_id"
end
