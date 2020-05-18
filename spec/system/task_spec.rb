require 'rails_helper'
RSpec.describe 'タスク管理機能', type: :system do
  before do

     FactoryBot.create(:task, name: '付け加えた名前1', detail: '付け加えたコメント1', progress: '完了')
    @task2 = FactoryBot.create(:second_task, name: '付け加えた名前3', detail: '付け加えたコメント3')
  end

  describe 'タスク一覧画面' do
    context 'タスクを作成した場合' do
      it '作成済みのタスクが表示されること' do
        # beforeに必要なタスクデータが作成されるので、ここでテストデータ作成処理を書く必要がない
        visit tasks_path
        expect(page).to have_content '付け加えた名前1'
      end
    end

    context '複数のタスクを作成した場合' do
      it 'タスクが作成日時の降順に並んでいること' do
        visit tasks_path
        task_list = all('.task_row') # タスク一覧を配列として取得するため、View側でidを振っておく

        expect(page).to have_content '付け加えた名前3'
        expect(page).to have_content '付け加えた名前1'
      end
    end
  end

  describe 'タスク登録画面' do
    context '必要項目を入力して、createボタンを押した場合' do
      it 'データが保存されること' do
        visit new_task_path
        fill_in "task_name", with: "abcdef"
        fill_in "task_detail", with: "ghijkl"
        click_on "登録する"

        expect(page).to have_content "abcdef"
      end
    end
  end

  describe 'タスク詳細画面' do
     context '任意のタスク詳細画面に遷移した場合' do
       it '該当タスクの内容が表示されたページに遷移すること' do
        task = FactoryBot.create(:task, name: 'wwwww', detail: 'xxxx')
        visit task_path(task)
         
         expect(page).to have_content "wwwww"
       end
     end
  end

  describe 'タスク一覧' do
    context '最終期限ボタンを押したら' do
      
      before do
        
        # 1 全てのタスクを取得してdeadlineを一日置きになる様に設定する
        all_tasks = Task.all
        all_tasks.each_with_index do |task, i|
          task.deadline = Date.today + i
          task.save
        end
       end
      it '期日が迫っている日から見せ、progressが登録されている' do    
        visit tasks_path
        click_on "終了期限でソート"
        
        sleep 3
        
        expect(page).to have_content "付け加えたコメント3"
       
      end
    end
  end

  describe 'タスク一覧' do
    context '進捗状態で完了、を指定後、検索を押したら' do
    it '完了タスクだけ表示' do
        visit tasks_path
        all_tasks = Task.all
        
        find('#task_progress').find("option[value='2']").select_option  

        click_on "検索"

        sleep 3
        expect(find("tbody").text).to have_content "完了"
        expect(find("tbody").text).not_to have_content "着手中"
        expect(find("tbody").text).not_to have_content "未着手"
      end
    end
  end

  describe 'タスク一覧' do
    context 'タスク名Name検索で、付け加えた名前1、を指定後、検索を押したら' do
    it 'タスク名、付け加えた名前1、だけを表示' do
        visit tasks_path
        all_tasks = Task.all
        
        fill_in "task_name", with: "付け加えた名前1"
        click_on "検索"
        
        sleep 3
        
        expect(find("tbody").text).to have_content "付け加えた名前1"

      end
    end
  end

end