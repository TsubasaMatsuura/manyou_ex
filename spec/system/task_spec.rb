require 'rails_helper'
RSpec.describe 'タスク管理機能', type: :system do
  describe 'タスク一覧画面' do
    context 'タスクを作成した場合' do
      it '作成済みのタスクが表示される' do
        task = FactoryBot.create(:task, name: 'task')
      # タスク一覧ページに遷移
      visit tasks_path
      # visitした（遷移した）page（タスク一覧ページ）に「task」という文字列が
      # have_contentされているか。（含まれているか。）ということをexpectする（確認・期待する）
      expect(page).to have_content 'task'
      end
    end
  end
  describe 'タスク登録画面' do
    context '必要項目を入力して、createボタンを押した場合' do
      it 'データが保存される' do
        visit new_task_path
        fill_in "task_name", with: "abcdef"
        fill_in "task_detail", with: "ghijkl"
        click_on "Create Task"

        expect(page).to have_content "abcdef"
        expect(page).to have_content "ghijkl"
      end
    end
  end
  describe 'タスク詳細画面' do
    context '任意のタスク詳細画面に遷移した場合' do
      it '該当タスクの内容が表示されたページに遷移する' do
        ask = FactoryBot.create(:task, name: 'wwwww', detail: 'xxxx')
        visit tasks_path

      expect(page).to have_content "wwwww"

      end
    end
  end
end