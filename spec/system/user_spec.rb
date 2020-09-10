require 'rails_helper'
RSpec.describe 'ユーザー管理機能', type: :system do

  let!(:user) { FactoryBot.create(:user) }
  let!(:admin_user) { FactoryBot.create(:admin_user) }

  describe '新規作成機能テスト' do
    context 'ユーザーを新規作詞した場合' do
      it 'ユーザー詳細が表示される' do
        visit tasks_path
        click_on 'Sign up'
        fill_in 'user_name', with: 'test_user'
        fill_in 'user_email', with: 'test@example.com'
        fill_in 'user_password', with: 'password'
        fill_in 'user_password_confirmation', with: 'password'
        click_on 'アカウントを作成する'
        expect(page).to have_content 'test_user'
        expect(page).to have_content 'test@example.com'
      end
    end
    context 'ログインせずにタスク一覧にとぼうとした場合' do
      it 'ログイン画面に遷移する' do
        visit tasks_path
        expect(page).to have_content 'ログインしてください'
      end
    end
  end

  describe '一般ユーザーセッション機能テスト' do
    context 'ユーザーデータが有りログインしてない場合' do
      it 'ログイン出来ること' do
        visit new_session_path
        fill_in 'session_email', with: 'user1@example.com'
        fill_in 'session_password', with: 'password'
        sleep 0.5
        click_on 'Log in'
        expect(page).to have_content 'タスク一覧'
      end
    end
    context 'ユーザーがログインしている場合' do
      before do
        visit new_session_path
        fill_in 'session_email', with: 'user1@example.com'
        fill_in 'session_password', with: 'password'
        click_on 'Log in'
      end
      it '自分の詳細ページをみれること' do
        click_on 'Profile'
        expect(page).to have_content 'user1@example.com'
      end
      it '他人の詳細ページにとぶとタスク一覧画面に戻されること' do
        visit user_path(admin_user.id)
        expect(page).to have_content '権限がありません'
      end
      it '管理画面にアクセスできないこと' do
        visit admin_users_path
        expect(page).to have_content '管理者以外アクセスできません！'
      end
      it 'ログアウトが出来ること' do
        click_on 'Logout'
        expect(page).to have_content 'ログアウトしました'
      end
    end
  end

  describe '管理ユーザーセッション機能テスト' do
    context '管理ユーザーがログインしている場合' do
      before do
        visit new_session_path
        fill_in 'session_email', with: 'admin@example.com'
        fill_in 'session_password', with: 'password'
        click_on 'Log in'
      end
      it '管理画面にアクセスできること' do
        visit admin_users_path
        expect(page).to have_content 'ユーザー管理一覧'
      end
      it 'ユーザーの新規登録ができること' do
        click_on 'アカウントを作成する'
        fill_in 'user_name', with: 'test_user'
        fill_in 'user_email', with: 'test@example.com'
        fill_in 'user_password', with: 'password'
        fill_in 'user_password_confirmation', with: 'password'
        click_on 'アカウントを作成する'
        expect(page).to have_content 'test_user'
      end
      it 'ユーザーの詳細画面にアクセスできること' do
        visit admin_user_path(user.id)
        expect(page).to have_content 'user1のページ'
      end
      it 'ユーザーの編集画面から編集できること' do
        visit edit_admin_user_path(user.id)
        fill_in 'user_name', with: 'update_user'
        fill_in 'user_email', with: 'update@example.com'
        fill_in 'user_password', with: 'password'
        fill_in 'user_password_confirmation', with: 'password'
        click_on 'アカウントを編集する'
        expect(page).to have_content 'update'
      end
      it 'ユーザーを削除できること' do
        visit admin_users_path
        within first('tbody tr') do
         click_link '削除'
        end
        expect(page).to have_content 'ユーザーを削除しました'
      end
    end
  end

end
