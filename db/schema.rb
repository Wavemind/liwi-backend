# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2022_12_14_084145) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "hstore"
  enable_extension "plpgsql"

  create_table "accesses", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "role_id"
    t.index ["role_id"], name: "index_accesses_on_role_id"
    t.index ["user_id"], name: "index_accesses_on_user_id"
  end

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

  create_table "administration_routes", force: :cascade do |t|
    t.string "category"
    t.hstore "name_translations"
  end

  create_table "algorithms", force: :cascade do |t|
    t.string "name"
    t.string "description"
    t.boolean "archived", default: false
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "age_limit"
    t.json "medal_r_config"
    t.json "village_json"
    t.integer "minimum_age"
    t.boolean "consent_management", default: true
    t.integer "study_id"
    t.boolean "track_referral", default: true
    t.hstore "emergency_content_translations"
    t.hstore "age_limit_message_translations"
    t.bigint "emergency_content_version", default: 0
    t.index ["user_id"], name: "index_algorithms_on_user_id"
  end

  create_table "answer_types", force: :cascade do |t|
    t.string "value"
    t.string "display"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "answer_required", default: true
  end

  create_table "answers", force: :cascade do |t|
    t.integer "reference"
    t.hstore "label_translations"
    t.integer "operator"
    t.string "value"
    t.bigint "node_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "unavailable", default: false
    t.bigint "source_id"
    t.index ["node_id"], name: "index_answers_on_node_id"
    t.index ["source_id"], name: "index_answers_on_source_id"
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
    t.string "referenceable_type"
    t.bigint "referenceable_id"
    t.string "first_conditionable_type"
    t.bigint "first_conditionable_id"
    t.integer "score"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "cut_off_start"
    t.integer "cut_off_end"
    t.bigint "instance_id"
    t.bigint "answer_id"
    t.bigint "source_id"
    t.index ["answer_id"], name: "index_conditions_on_answer_id"
    t.index ["first_conditionable_type", "first_conditionable_id"], name: "index_first_conditionable_id"
    t.index ["instance_id"], name: "index_conditions_on_instance_id"
    t.index ["referenceable_type", "referenceable_id"], name: "index_referenceable_id"
    t.index ["source_id"], name: "index_conditions_on_source_id"
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
    t.bigint "health_facility_id"
    t.index ["health_facility_id"], name: "index_devices_on_health_facility_id"
  end

  create_table "diagnoses", force: :cascade do |t|
    t.integer "reference"
    t.hstore "label_translations"
    t.bigint "version_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "node_id"
    t.integer "cut_off_start"
    t.integer "cut_off_end"
    t.bigint "source_id"
    t.index ["node_id"], name: "index_diagnoses_on_node_id"
    t.index ["source_id"], name: "index_diagnoses_on_source_id"
    t.index ["version_id"], name: "index_diagnoses_on_version_id"
  end

  create_table "formulations", force: :cascade do |t|
    t.float "minimal_dose_per_kg"
    t.float "maximal_dose_per_kg"
    t.float "maximal_dose"
    t.integer "medication_form"
    t.decimal "dose_form"
    t.integer "liquid_concentration"
    t.integer "doses_per_day"
    t.decimal "unique_dose"
    t.integer "breakable"
    t.boolean "by_age", default: false
    t.bigint "node_id"
    t.bigint "administration_route_id"
    t.hstore "description_translations"
    t.hstore "injection_instructions_translations"
    t.hstore "dispensing_description_translations"
    t.bigint "source_id"
    t.index ["administration_route_id"], name: "index_formulations_on_administration_route_id"
    t.index ["node_id"], name: "index_formulations_on_node_id"
    t.index ["source_id"], name: "index_formulations_on_source_id"
  end

  create_table "health_facilities", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "local_data_ip"
    t.string "main_data_ip"
    t.integer "architecture"
    t.string "pin_code"
    t.string "token"
    t.decimal "latitude"
    t.decimal "longitude"
    t.string "country"
    t.string "area"
    t.bigint "study_id"
    t.index ["study_id"], name: "index_health_facilities_on_study_id"
  end

  create_table "health_facility_accesses", force: :cascade do |t|
    t.boolean "access", default: true
    t.datetime "end_date"
    t.bigint "version_id"
    t.bigint "health_facility_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["health_facility_id"], name: "index_health_facility_accesses_on_health_facility_id"
    t.index ["version_id"], name: "index_health_facility_accesses_on_version_id"
  end

  create_table "instances", force: :cascade do |t|
    t.bigint "node_id"
    t.string "instanceable_type"
    t.bigint "instanceable_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "final_diagnosis_id"
    t.integer "position_x", default: 100
    t.integer "position_y", default: 100
    t.hstore "duration_translations"
    t.hstore "description_translations"
    t.boolean "is_pre_referral", default: false
    t.bigint "source_id"
    t.index ["final_diagnosis_id"], name: "index_instances_on_final_diagnosis_id"
    t.index ["instanceable_type", "instanceable_id"], name: "index_instances_on_instanceable_type_and_instanceable_id"
    t.index ["node_id"], name: "index_instances_on_node_id"
    t.index ["source_id"], name: "index_instances_on_source_id"
  end

  create_table "languages", force: :cascade do |t|
    t.string "name"
    t.string "code"
  end

  create_table "medal_data_config_variables", force: :cascade do |t|
    t.string "label"
    t.string "api_key"
    t.bigint "version_id"
    t.bigint "question_id"
    t.index ["question_id"], name: "index_medal_data_config_variables_on_question_id"
    t.index ["version_id"], name: "index_medal_data_config_variables_on_version_id"
  end

  create_table "medias", force: :cascade do |t|
    t.hstore "label_translations"
    t.string "url"
    t.string "fileable_type"
    t.bigint "fileable_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "source_id"
    t.index ["fileable_type", "fileable_id"], name: "index_medias_on_fileable_type_and_fileable_id"
    t.index ["source_id"], name: "index_medias_on_source_id"
  end

  create_table "medical_staffs", force: :cascade do |t|
    t.string "first_name"
    t.string "last_name"
    t.integer "role"
    t.bigint "health_facility_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["health_facility_id"], name: "index_medical_staffs_on_health_facility_id"
  end

  create_table "node_complaint_categories", force: :cascade do |t|
    t.bigint "node_id"
    t.bigint "complaint_category_id"
    t.index ["complaint_category_id"], name: "index_node_complaint_categories_on_complaint_category_id"
    t.index ["node_id"], name: "index_node_complaint_categories_on_node_id"
  end

  create_table "node_exclusions", force: :cascade do |t|
    t.bigint "excluding_node_id"
    t.bigint "excluded_node_id"
    t.integer "node_type"
    t.index ["excluded_node_id"], name: "index_node_exclusions_on_excluded_node_id"
    t.index ["excluding_node_id"], name: "index_node_exclusions_on_excluding_node_id"
  end

  create_table "nodes", force: :cascade do |t|
    t.hstore "label_translations"
    t.integer "reference"
    t.integer "stage"
    t.string "type"
    t.bigint "diagnosis_id"
    t.hstore "description_translations"
    t.integer "min_score", default: 0
    t.bigint "algorithm_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "answer_type_id"
    t.string "formula"
    t.string "reference_table_male"
    t.string "reference_table_female"
    t.boolean "is_default", default: false
    t.bigint "reference_table_x_id"
    t.bigint "reference_table_y_id"
    t.bigint "snomed_id"
    t.string "snomed_label"
    t.integer "system"
    t.boolean "is_mandatory", default: false
    t.bigint "node_id"
    t.boolean "is_anti_malarial", default: false
    t.boolean "is_antibiotic", default: false
    t.boolean "is_triage", default: false
    t.boolean "is_identifiable", default: false
    t.float "min_value_warning"
    t.float "max_value_warning"
    t.float "min_value_error"
    t.float "max_value_error"
    t.boolean "estimable", default: false
    t.bigint "reference_table_z_id"
    t.boolean "is_neonat", default: false
    t.boolean "is_danger_sign", default: false
    t.boolean "unavailable", default: false
    t.integer "emergency_status", default: 0
    t.integer "level_of_urgency", default: 5
    t.integer "step"
    t.hstore "min_message_error_translations"
    t.hstore "max_message_error_translations"
    t.hstore "min_message_warning_translations"
    t.hstore "max_message_warning_translations"
    t.integer "round"
    t.integer "cut_off_start"
    t.integer "cut_off_end"
    t.boolean "is_referral", default: false
    t.hstore "placeholder_translations"
    t.boolean "is_pre_fill", default: false
    t.bigint "source_id"
    t.index ["algorithm_id"], name: "index_nodes_on_algorithm_id"
    t.index ["answer_type_id"], name: "index_nodes_on_answer_type_id"
    t.index ["diagnosis_id"], name: "index_nodes_on_diagnosis_id"
    t.index ["node_id"], name: "index_nodes_on_node_id"
    t.index ["reference_table_x_id"], name: "index_nodes_on_reference_table_x_id"
    t.index ["reference_table_y_id"], name: "index_nodes_on_reference_table_y_id"
    t.index ["reference_table_z_id"], name: "index_nodes_on_reference_table_z_id"
    t.index ["source_id"], name: "index_nodes_on_source_id"
  end

  create_table "roles", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "stage"
  end

  create_table "studies", force: :cascade do |t|
    t.string "label"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.hstore "description_translations"
    t.string "default_language", default: "en"
  end

  create_table "technical_files", force: :cascade do |t|
    t.bigint "user_id"
    t.string "file"
    t.boolean "active", default: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_technical_files_on_user_id"
  end

  create_table "user_logs", force: :cascade do |t|
    t.bigint "user_id"
    t.string "action"
    t.string "model_type"
    t.bigint "model_id"
    t.json "data"
    t.string "ip_address"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["user_id"], name: "index_user_logs_on_user_id"
  end

  create_table "user_studies", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "study_id"
    t.index ["study_id"], name: "index_user_studies_on_study_id"
    t.index ["user_id"], name: "index_user_studies_on_user_id"
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
    t.string "provider", default: "email", null: false
    t.string "uid", default: "", null: false
    t.text "tokens"
    t.integer "role"
    t.string "encrypted_otp_secret"
    t.string "encrypted_otp_secret_iv"
    t.string "encrypted_otp_secret_salt"
    t.integer "consumed_timestep"
    t.boolean "otp_required_for_login"
    t.string "otp_backup_codes", array: true
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["invitation_token"], name: "index_users_on_invitation_token", unique: true
    t.index ["invitations_count"], name: "index_users_on_invitations_count"
    t.index ["invited_by_id"], name: "index_users_on_invited_by_id"
    t.index ["invited_by_type", "invited_by_id"], name: "index_users_on_invited_by_type_and_invited_by_id"
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
    t.index ["uid", "provider"], name: "index_users_on_uid_and_provider", unique: true
  end

  create_table "version_languages", force: :cascade do |t|
    t.bigint "version_id"
    t.bigint "language_id"
    t.index ["language_id"], name: "index_version_languages_on_language_id"
    t.index ["version_id"], name: "index_version_languages_on_version_id"
  end

  create_table "versions", force: :cascade do |t|
    t.string "name"
    t.boolean "archived", default: false
    t.bigint "user_id"
    t.bigint "algorithm_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "top_left_question_id"
    t.bigint "first_top_right_question_id"
    t.bigint "second_top_right_question_id"
    t.json "medal_r_json"
    t.integer "medal_r_json_version", default: 0
    t.boolean "is_arm_control", default: false
    t.string "job_id", default: ""
    t.hstore "description_translations"
    t.json "full_order_json"
    t.boolean "in_prod", default: false
    t.integer "minimum_age"
    t.integer "age_limit"
    t.hstore "age_limit_message_translations"
    t.bigint "source_id"
    t.index ["algorithm_id"], name: "index_versions_on_algorithm_id"
    t.index ["first_top_right_question_id"], name: "index_versions_on_first_top_right_question_id"
    t.index ["second_top_right_question_id"], name: "index_versions_on_second_top_right_question_id"
    t.index ["source_id"], name: "index_versions_on_source_id"
    t.index ["top_left_question_id"], name: "index_versions_on_top_left_question_id"
    t.index ["user_id"], name: "index_versions_on_user_id"
  end

  add_foreign_key "activities", "devices"
  add_foreign_key "activities", "users"
  add_foreign_key "algorithms", "users"
  add_foreign_key "answers", "answers", column: "source_id"
  add_foreign_key "conditions", "conditions", column: "source_id"
  add_foreign_key "devices", "health_facilities"
  add_foreign_key "diagnoses", "diagnoses", column: "source_id"
  add_foreign_key "diagnoses", "nodes"
  add_foreign_key "diagnoses", "versions"
  add_foreign_key "formulations", "formulations", column: "source_id"
  add_foreign_key "health_facilities", "studies"
  add_foreign_key "health_facility_accesses", "health_facilities"
  add_foreign_key "health_facility_accesses", "versions"
  add_foreign_key "instances", "instances", column: "source_id"
  add_foreign_key "medal_data_config_variables", "versions"
  add_foreign_key "medias", "medias", column: "source_id"
  add_foreign_key "node_exclusions", "nodes", column: "excluded_node_id"
  add_foreign_key "node_exclusions", "nodes", column: "excluding_node_id"
  add_foreign_key "nodes", "algorithms"
  add_foreign_key "nodes", "answer_types"
  add_foreign_key "nodes", "nodes"
  add_foreign_key "nodes", "nodes", column: "reference_table_z_id"
  add_foreign_key "nodes", "nodes", column: "source_id"
  add_foreign_key "technical_files", "users"
  add_foreign_key "versions", "algorithms"
  add_foreign_key "versions", "users"
  add_foreign_key "versions", "versions", column: "source_id"
end
