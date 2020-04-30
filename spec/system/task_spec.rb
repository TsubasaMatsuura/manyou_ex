require 'rails_helper'
RSpec.describe 'タスク管理機能', type: :system do
  before do

    @task = FactoryBot.create(:task, name: 'task')
  end
  describe 'タスク一覧画面' do
    context 'タスクを作成した場合' do
      it '作成済みのタスクが表示される' do
        visit tasks_path
        expect(page).to have_content 'task'
      end
    end
    context '複数のタスクを作成した場合' do
      it 'タスクが作成日時の降順に並んでいる' do
       new_task = FactoryBot.create(:task, name: 'new_task')
       visit tasks_path
       task_list = all('.task_row') 
       expect(task_list[0]).to have_content 'new_task'
       expect(task_list[1]).to have_content 'task'
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
        task = FactoryBot.create(:task, name: 'wwwww', detail: 'xxxx')
        visit tasks_path

        expect(page).to have_content "wwwww"
        expect(page).to have_content "xxxx"
      end
    end
  end


end