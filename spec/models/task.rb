require 'rails_helper'
RSpec.describe 'タスク管理機能', type: :model do
  it 'titleが空ならバリデーションが通らない' do
    task = Task.new(name: '', detail: '失敗テスト')
    expect(task).to be_valid
  end
  it 'contentが空ならバリデーションが通らない' do
    task = Task.new(name: '失敗', detail: '')
    expect(task).to be_valid
  end
  it 'titleとcontentに内容が記載されていればバリデーションが通る' do
    task = Task.new(name: 'achive', detail: 'achive')
    expect(task).to be_valid
  end

   context "scope" do
    it 'to include task_name, abcde' do
      task = FactoryBot.create(:task, name: "abcde", detail: "fghi")
      expect(Task.search_name("abcde").count).to eq 1
    end

    it 'to include task_progress, 完了' do
      task_progress = Task.create(name: "aaaaa", detail: "bbbbb", progress: 2)

      expect(Task.search_progress( 2 ).count).to eq 1
    end
  end
end