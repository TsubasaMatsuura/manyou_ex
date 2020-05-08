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

    context '終了期限でソートを押した場合' do
      before do
        task = FactoryBot.create(:task, name: 'third title', detail: 'third content', deadline: '2030-12-01')
        task = FactoryBot.create(:task, name: 'first title', detail: 'first content', deadline: '1990-12-01')
        task = FactoryBot.create(:task, name: 'second title', detail: 'second content', deadline: '2020-12-01')
      end
      it 'タスクの並び順が終了期限の降順で並んでいること', :retry => 3 do
        visit tasks_path
        wait.until {click_link '終了期限でソート' }
        task_list = all('.task_title')
        expect(task_list[0]).to have_content 'third title'
        expect(task_list[1]).to have_content 'second title'
        expect(task_list[2]).to have_content 'first title'
      end
    end

    context '検索ボタンを押した場合' do
      before do
        task = FactoryBot.create(:task, title: 'third title', content: 'third content', end_date: '2030-12-01',user_id: @user.id)
        task = FactoryBot.create(:task, title: 'first title', content: 'first content', end_date: '1990-12-01',user_id: @user.id)
        task = FactoryBot.create(:task, title: 'second title', content: 'second content', end_date: '2020-12-01',user_id: @user.id)
        task = FactoryBot.create(:task, title: 'status', content: 'second content', end_date: '2020-12-01', status: '着手中',user_id: @user.id)
        task = FactoryBot.create(:task, title: 'status1', content: 'second content', end_date: '2020-12-01', status: '着手中',user_id: @user.id)
      end
      it '検索条件に該当したタイトルのみ表示されていること' do
        visit tasks_path
        fill_in 'title', with: 'third title'
        click_button '検索'
        task_list = all('.task_title')
        expect(task_list[0]).to have_content 'third title'
      end
      it '検索条件に該当しないタイトルは表示されていないこと', :retry => 3 do
        visit tasks_path
        fill_in 'title', with: 'third title'
        click_button '検索'
        task_list = all('.task_title')
        wait.until{ expect(task_list[0]).to_not have_content 'second content' }
      end
      it 'ステータスに該当するタイトルのみ表示すること' do
        visit tasks_path
        select '着手中', from: 'status'
        click_button '検索'
        task_list = all('.task_title')
        expect(task_list[0]).to have_content 'status'
      end
      it 'ステータスに該当しないタイトルは表示されないこと' do
        visit tasks_path
        select '着手中', from: 'status'
        click_button '検索'
        task_list = all('.task_title')
        expect(task_list[0]).to_not have_content "second content"
      end
      it '複合的な検索条件に該当するタイトルのみ表示すること' do
        visit tasks_path
        select '着手中', from: 'status'
        click_button '検索'
        task_list = all('.task_title')
        wait.until { expect(task_list[0]).to have_content "status1" }
        wait.until { expect(task_list[1]).to have_content "status" }
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