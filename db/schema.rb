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

ActiveRecord::Schema.define(version: 2019_01_28_154802) do

  create_table "activities", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
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

  create_table "algorithm_version_diagnostics", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.bigint "algorithm_version_id"
    t.bigint "diagnostic_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["algorithm_version_id"], name: "index_algorithm_version_diagnostics_on_algorithm_version_id"
    t.index ["diagnostic_id"], name: "index_algorithm_version_diagnostics_on_diagnostic_id"
  end

  create_table "algorithm_versions", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "version"
    t.text "json"
    t.boolean "archived", default: false
    t.bigint "user_id"
    t.bigint "algorithm_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["algorithm_id"], name: "index_algorithm_versions_on_algorithm_id"
    t.index ["user_id"], name: "index_algorithm_versions_on_user_id"
  end

  create_table "algorithms", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "name"
    t.string "description"
    t.boolean "archived", default: false
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_algorithms_on_user_id"
  end

  create_table "answer_types", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "value"
    t.string "display"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "answers", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "reference"
    t.string "label"
    t.string "operator"
    t.string "value"
    t.bigint "question_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["question_id"], name: "index_answers_on_question_id"
  end

  create_table "available_nodes", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.bigint "algorithm_id"
    t.bigint "node_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["algorithm_id"], name: "index_available_nodes_on_algorithm_id"
    t.index ["node_id"], name: "index_available_nodes_on_node_id"
  end

  create_table "categories", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "name"
    t.string "reference_prefix"
  end

  create_table "devices", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "reference_number"
    t.string "name"
    t.string "model"
    t.string "brand"
    t.string "os"
    t.string "os_version"
    t.integer "status"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "diagnostic_health_cares", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.bigint "diagnostic_id"
    t.bigint "health_care_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["diagnostic_id"], name: "index_diagnostic_health_cares_on_diagnostic_id"
    t.index ["health_care_id"], name: "index_diagnostic_health_cares_on_health_care_id"
  end

  create_table "diagnostics", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "reference"
    t.string "label"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "group_users", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.bigint "group_id"
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["group_id"], name: "index_group_users_on_group_id"
    t.index ["user_id"], name: "index_group_users_on_user_id"
  end

  create_table "groups", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "nodes", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "label"
    t.string "reference"
    t.integer "priority"
    t.string "type"
    t.bigint "category_id"
    t.text "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "answer_type_id"
    t.index ["answer_type_id"], name: "index_nodes_on_answer_type_id"
    t.index ["category_id"], name: "index_nodes_on_category_id"
  end

  create_table "roles", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
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

  add_foreign_key "activities", "devices"
  add_foreign_key "activities", "users"
  add_foreign_key "algorithm_version_diagnostics", "algorithm_versions"
  add_foreign_key "algorithm_version_diagnostics", "diagnostics"
  add_foreign_key "algorithm_versions", "algorithms"
  add_foreign_key "algorithm_versions", "users"
  add_foreign_key "algorithms", "users"
  add_foreign_key "available_nodes", "algorithms"
  add_foreign_key "group_users", "groups"
  add_foreign_key "group_users", "users"
  add_foreign_key "nodes", "answer_types"
  add_foreign_key "users", "roles"
end
