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

ActiveRecord::Schema.define(version: 2019_08_30_123307) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "hstore"
  enable_extension "plpgsql"

  create_table "activities", force: :cascade do |t|
    t.decimal "longitude", precision: 13, scale: 9
    t.decimal "latitude", precision: 13, scale: 9
    t.string "timezone"
    t.string "version"
    t.bigint "user_id"
    t.bigint "device_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["device_id"], name: "index_activities_on_device_id"
    t.index ["user_id"], name: "index_activities_on_user_id"
  end

  create_table "algorithms", force: :cascade do |t|
    t.string "name"
    t.string "description"
    t.boolean "archived", default: false
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_algorithms_on_user_id"
  end

  create_table "answer_types", force: :cascade do |t|
    t.string "value"
    t.string "display"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "answers", force: :cascade do |t|
    t.string "reference"
    t.hstore "label_translations"
    t.integer "operator"
    t.string "value"
    t.bigint "node_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["node_id"], name: "index_answers_on_node_id"
  end

  create_table "children", force: :cascade do |t|
    t.float "weight"
    t.bigint "node_id"
    t.bigint "instance_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["instance_id"], name: "index_children_on_instance_id"
    t.index ["node_id"], name: "index_children_on_node_id"
  end

  create_table "conditions", force: :cascade do |t|
    t.integer "operator"
    t.string "referenceable_type"
    t.bigint "referenceable_id"
    t.string "first_conditionable_type"
    t.bigint "first_conditionable_id"
    t.string "second_conditionable_type"
    t.bigint "second_conditionable_id"
    t.boolean "top_level", default: true
    t.integer "score"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["first_conditionable_type", "first_conditionable_id"], name: "index_first_conditionable_id"
    t.index ["referenceable_type", "referenceable_id"], name: "index_referenceable_id"
    t.index ["second_conditionable_type", "second_conditionable_id"], name: "index_second_conditionable_id"
  end

  create_table "devices", force: :cascade do |t|
    t.string "mac_address"
    t.string "name"
    t.string "model"
    t.string "brand"
    t.string "os"
    t.string "os_version"
    t.integer "status", default: 0
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "group_id"
    t.index ["group_id"], name: "index_devices_on_group_id"
  end

  create_table "diagnostics", force: :cascade do |t|
    t.string "reference"
    t.hstore "label_translations"
    t.bigint "version_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "node_id"
    t.index ["node_id"], name: "index_diagnostics_on_node_id"
    t.index ["version_id"], name: "index_diagnostics_on_version_id"
  end

  create_table "final_diagnostic_health_cares", force: :cascade do |t|
    t.bigint "node_id"
    t.bigint "final_diagnostic_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["final_diagnostic_id"], name: "index_final_diagnostic_health_cares_on_final_diagnostic_id"
    t.index ["node_id"], name: "index_final_diagnostic_health_cares_on_node_id"
  end

  create_table "group_accesses", force: :cascade do |t|
    t.boolean "access", default: true
    t.datetime "end_date"
    t.bigint "version_id"
    t.bigint "group_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["group_id"], name: "index_group_accesses_on_group_id"
    t.index ["version_id"], name: "index_group_accesses_on_version_id"
  end

  create_table "groups", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "instances", force: :cascade do |t|
    t.bigint "node_id"
    t.string "instanceable_type"
    t.bigint "instanceable_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "final_diagnostic_id"
    t.index ["final_diagnostic_id"], name: "index_instances_on_final_diagnostic_id"
    t.index ["instanceable_type", "instanceable_id"], name: "index_instances_on_instanceable_type_and_instanceable_id"
    t.index ["node_id"], name: "index_instances_on_node_id"
  end

  create_table "languages", force: :cascade do |t|
    t.string "name"
    t.string "code"
  end

  create_table "medias", force: :cascade do |t|
    t.hstore "label_translations"
    t.string "url"
    t.string "fileable_type"
    t.bigint "fileable_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["fileable_type", "fileable_id"], name: "index_medias_on_fileable_type_and_fileable_id"
  end

  create_table "medical_case_answers", force: :cascade do |t|
    t.string "value"
    t.bigint "medical_case_id"
    t.bigint "version_id"
    t.bigint "answer_id"
    t.index ["answer_id"], name: "index_medical_case_answers_on_answer_id"
    t.index ["medical_case_id"], name: "index_medical_case_answers_on_medical_case_id"
    t.index ["version_id"], name: "index_medical_case_answers_on_version_id"
  end

  create_table "medical_case_final_diagnostics", force: :cascade do |t|
    t.bigint "final_diagnostic_id"
    t.bigint "medical_case_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["final_diagnostic_id"], name: "index_medical_case_final_diagnostics_on_final_diagnostic_id"
    t.index ["medical_case_id"], name: "index_medical_case_final_diagnostics_on_medical_case_id"
  end

  create_table "medical_case_health_cares", force: :cascade do |t|
    t.bigint "node_id"
    t.bigint "medical_case_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["medical_case_id"], name: "index_medical_case_health_cares_on_medical_case_id"
    t.index ["node_id"], name: "index_medical_case_health_cares_on_node_id"
  end

  create_table "medical_cases", force: :cascade do |t|
    t.string "file"
    t.bigint "patient_id"
    t.bigint "version_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["patient_id"], name: "index_medical_cases_on_patient_id"
    t.index ["version_id"], name: "index_medical_cases_on_version_id"
  end

  create_table "nodes", force: :cascade do |t|
    t.hstore "label_translations"
    t.string "reference"
    t.integer "priority"
    t.integer "stage"
    t.string "type"
    t.bigint "diagnostic_id"
    t.hstore "description_translations"
    t.integer "min_score", default: 0
    t.bigint "algorithm_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "final_diagnostic_id"
    t.bigint "answer_type_id"
    t.string "formula"
    t.index ["algorithm_id"], name: "index_nodes_on_algorithm_id"
    t.index ["answer_type_id"], name: "index_nodes_on_answer_type_id"
    t.index ["diagnostic_id"], name: "index_nodes_on_diagnostic_id"
    t.index ["final_diagnostic_id"], name: "index_nodes_on_final_diagnostic_id"
  end

  create_table "patients", force: :cascade do |t|
    t.string "first_name"
    t.string "last_name"
    t.date "birth_date"
    t.bigint "got_homis_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "roles", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "first_name"
    t.string "last_name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string "current_sign_in_ip"
    t.string "last_sign_in_ip"
    t.integer "failed_attempts", default: 0, null: false
    t.string "unlock_token"
    t.datetime "locked_at"
    t.boolean "deactivated", default: false
    t.string "invitation_token"
    t.datetime "invitation_created_at"
    t.datetime "invitation_sent_at"
    t.datetime "invitation_accepted_at"
    t.integer "invitation_limit"
    t.string "invited_by_type"
    t.bigint "invited_by_id"
    t.integer "invitations_count", default: 0
    t.bigint "role_id"
    t.string "provider", default: "email", null: false
    t.string "uid", default: "", null: false
    t.text "tokens"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["invitation_token"], name: "index_users_on_invitation_token", unique: true
    t.index ["invitations_count"], name: "index_users_on_invitations_count"
    t.index ["invited_by_id"], name: "index_users_on_invited_by_id"
    t.index ["invited_by_type", "invited_by_id"], name: "index_users_on_invited_by_type_and_invited_by_id"
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
    t.index ["role_id"], name: "index_users_on_role_id"
    t.index ["uid", "provider"], name: "index_users_on_uid_and_provider", unique: true
  end

  create_table "versions", force: :cascade do |t|
    t.string "name"
    t.boolean "archived", default: false
    t.bigint "user_id"
    t.bigint "algorithm_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "triage_questions_order", default: [], array: true
    t.integer "triage_first_look_assessments_order", default: [], array: true
    t.integer "triage_chief_complaints_order", default: [], array: true
    t.integer "triage_vital_signs_order", default: [], array: true
    t.integer "triage_chronical_conditions_order", default: [], array: true
    t.index ["algorithm_id"], name: "index_versions_on_algorithm_id"
    t.index ["user_id"], name: "index_versions_on_user_id"
  end

  add_foreign_key "activities", "devices"
  add_foreign_key "activities", "users"
  add_foreign_key "algorithms", "users"
  add_foreign_key "devices", "groups"
  add_foreign_key "diagnostics", "versions"
  add_foreign_key "group_accesses", "groups"
  add_foreign_key "group_accesses", "versions"
  add_foreign_key "nodes", "algorithms"
  add_foreign_key "nodes", "answer_types"
  add_foreign_key "users", "roles"
  add_foreign_key "versions", "algorithms"
  add_foreign_key "versions", "users"
end
