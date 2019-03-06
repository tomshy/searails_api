# frozen_string_literal: true

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

ActiveRecord::Schema.define(version: 20_190_227_143_407) do
  # These are extensions that must be enabled in order to support this database
  enable_extension 'plpgsql'

  create_table 'articles', force: :cascade do |t|
    t.string 'title'
    t.text 'body'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.bigint 'blog_id'
    t.bigint 'user_id'
    t.index ['blog_id'], name: 'index_articles_on_blog_id'
    t.index ['user_id'], name: 'index_articles_on_user_id'
  end

  create_table 'blogs', force: :cascade do |t|
    t.string 'name'
    t.bigint 'user_id'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.index ['user_id'], name: 'index_blogs_on_user_id'
  end

  create_table 'comments', force: :cascade do |t|
    t.string 'body'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.bigint 'article_id'
    t.bigint 'user_id'
    t.index ['article_id'], name: 'index_comments_on_article_id'
    t.index ['user_id'], name: 'index_comments_on_user_id'
  end

  create_table 'users', force: :cascade do |t|
    t.string 'name'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.string 'email'
    t.string 'password'
    t.string 'username'
  end

  add_foreign_key 'articles', 'blogs'
  add_foreign_key 'articles', 'users'
  add_foreign_key 'blogs', 'users'
  add_foreign_key 'comments', 'articles'
  add_foreign_key 'comments', 'users'
end
