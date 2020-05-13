require 'rails_helper'
RSpec.describe 'ユーザー登録・ログイン・ログアウト機能', type: :system do
  describe 'ユーザー登録のテスト' do
    context 'ユーザーのデータがなくログインしていない状態' do
      it 'ユーザー新規登録のテスト' do
        visit new_user_path
        fill_in 'user[name]', with: 'sample'
        fill_in 'user[email]', with: 'sample@example.com'
        fill_in 'user[password]', with: '00000000'
        fill_in 'user[password_confirmation]', with: '00000000'
        click_button 'Create my account'
        expect(current_path).to eq user_path(id: 1)
      end
      it 'ログインしていない時はログイン画面に飛ぶテスト' do
        visit tasks_path
        expect(current_path).to eq new_user_path
      end
    end
  end
  describe 'セッション機能のテスト' do
    before do
      user = FactoryBot.create(:user)
      admin_user = FactoryBot.create(:admin_user)
    end
    context 'ユーザーが作成されている場合' do
      it 'ログインができること' do
        visit new_session_path
        fill_in 'session[email]', with: 'sample@example.com'
        fill_in 'session[password]', with: '00000000'
        click_button 'Log in'
        expect(current_path).to eq user_path(id: 2)
      end
    end

    context 'ログインされている場合' do
      before do
        visit new_session_path
        fill_in 'session[email]', with: 'sample@example.com'
        fill_in 'session[password]', with: '00000000'
        click_button 'Log in'

      end

      it '自分の詳細画面(マイページ)に飛べること' do
        visit user_path(id: 4)
        expect(current_path).to eq user_path(id: 4)
      end

      it '一般ユーザーが他人の詳細画面に飛ぶとタスク一覧ページに遷移すること' do
        visit user_path(id: 7)

        expect(page).to have_content '他の人のページへアクセスは出来ません!'
      end

      it 'ログアウトができること' do
        visit user_path(id: 8)
        click_link 'Logout'
        save_and_open_page
        expect(page).to have_content 'ログアウトしました'
      end
    end
  end

  describe '管理画面のテスト' do
    before do
      @user = FactoryBot.create(:user)
      admin_user = FactoryBot.create(:admin_user)
    end

    context '管理者ユーザーでログインしている場合' do
      before do
        visit new_session_path
        fill_in 'session[email]', with: 'admin2@example.com'
        fill_in 'session[password]', with: '00000000'
        click_button 'Log in'
      end

      it '管理者は管理画面にアクセスできること' do
        visit admin_users_path
        expect(current_path).to eq admin_users_path
      end

      it '管理者はユーザーを新規登録できること' do
        visit new_admin_user_path
        fill_in 'user[name]', with: 'sample1'
        fill_in 'user[email]', with: 'sample1@example.com'
        fill_in 'user[password]', with: '00000000'
        fill_in 'user[password_confirmation]', with: '00000000'
        click_button 'Create my account'
      end

      it '管理者はユーザーの詳細画面にアクセスできること' do
        visit user_path(id: 15)
        expect(page).to have_content 'sampleのページ'
      end

      it '管理者はユーザーの編集画面からユーザーを編集できること' do
        visit edit_admin_user_path(@user)
        fill_in 'user[name]', with: 'sample2'
        fill_in 'user[email]', with: 'sample2@example.com'
        fill_in 'user[password]', with: '00000000'
        fill_in 'user[password_confirmation]', with: '00000000'
        click_button '更新する'
        expect(page).to have_content 'ユーザー詳細を編集しました！'
      end

      it '管理者はユーザーの削除をできること' do
        visit admin_users_path
        all('td')[4].click_link 'Destroy'
        page.driver.browser.switch_to.alert.accept
        expect(page).to have_content 'ユーザーは削除されました。'
      end
    end
  end
end