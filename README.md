# README

create_table "labels", force: :cascade do |t|
    t.string "title"
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_labels_on_user_id"
  end

  create_table "tasks", force: :cascade do |t|
    t.string "name"
    t.text "detail"
    t.date "deadline"
    t.integer "progress"
    t.integer "priority"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "name"
    t.string "email"
    t.string "password_digest"
    t.boolean "admin"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

ヘロクデプロイ

  heroku login
heroku create
git add .
git commit -m '変更内容'
git push origin 作業ブランチ名
プルリクエストを行う。
承認された場合、GitHub上でmergeする。
Githubの作業ブランチを削除する。
git checkout master (Localにてmasterブランチに切り替える
git pull origin master (差分を取り込む
git branch -d ブランチ名 (Localの作業ブランチを削除する
git push heroku master
heroku run rails db:migrate