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

ActiveRecord::Schema.define(version: 20150313014141) do

  create_table "ativacoes", force: :cascade do |t|
    t.string   "codigo",     null: false
    t.integer  "termo_id"
    t.datetime "ativado_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "ativacoes", ["codigo"], name: "index_ativacoes_on_codigo"
  add_index "ativacoes", ["termo_id"], name: "index_ativacoes_on_termo_id"

  create_table "termos", force: :cascade do |t|
    t.string   "conteudo",                   null: false
    t.boolean  "ativo",      default: false
    t.integer  "usuario_id"
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
  end

  add_index "termos", ["ativo"], name: "index_termos_on_ativo"
  add_index "termos", ["usuario_id"], name: "index_termos_on_usuario_id"

  create_table "usuarios", force: :cascade do |t|
    t.string   "email",                     null: false
    t.boolean  "ativo",      default: true
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
  end

  add_index "usuarios", ["ativo"], name: "index_usuarios_on_ativo"
  add_index "usuarios", ["email"], name: "index_usuarios_on_email"

end
