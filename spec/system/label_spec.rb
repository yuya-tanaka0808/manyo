require 'rails_helper'
RSpec.describe 'ラベル機能', type: :system do
  let!(:admin_user) { FactoryBot.create(:admin_user)}
  let!(:user) { FactoryBot.create(:user)}
  let!(:label){FactoryBot.create(:label)}
  let!(:label2){FactoryBot.create(:label2)}
  let!(:label3){FactoryBot.create(:label3)}
  let!(:task1){FactoryBot.create(:task1)}
  let!(:task2){FactoryBot.create(:task2)}
  let!(:task3){FactoryBot.create(:task3)}

 describe 'ラベルCRUD機能' do

   context '一般ユーザーでログインしている場合' do
     before do
       visit new_session_path
       fill_in 'session_email', with: 'user1@example.com'
       fill_in 'session_password', with: 'password'
       click_on 'Log in'
     end
     it 'ラベル画面にアクセスできない' do
       visit labels_path
       expect(page).to have_content '管理者以外アクセスできません'
     end
   end

   context '管理者でログインしている場合' do
     before do
       visit new_session_path
       fill_in 'session_email', with: 'admin@example.com'
       fill_in 'session_password', with: 'password'
       click_on 'Log in'
     end
     it 'ラベル一覧を見ることが出来る' do
       visit labels_path
       expect(page).to have_content 'ラベル一覧'
     end
     it '新規ラベルを作成できる' do
       visit new_label_path
       fill_in 'label_name', with: '新規ラベル'
       click_on '登録する'
       expect(page).to have_content '新規ラベル'
     end
     it 'ラベルを編集出来る' do
       visit labels_path
       within first('tbody tr') do
        click_link '編集'
       end
        fill_in 'label_name', with: '変更'
        click_on '更新する'
        expect(page).to have_content '変更'
     end
     it 'ラベルを削除できる' do
       visit labels_path
       click_link '削除', match: :first
       page.accept_confirm "Are you sure?"
      expect(page).to have_no_content 'FirstLabel'
     end

   end
 end

  describe 'タスク関連' do
    before do
      visit new_session_path
      fill_in 'session_email', with: 'user1@example.com'
      fill_in 'session_password', with: 'password'
      click_on 'Log in'
    end

    context 'タスクを新規作成した場合' do
      it 'ラベル選択して追加できる' do
        visit new_task_path
        fill_in 'task_title', with: 'Labeltitle'
        fill_in 'task_content', with: 'Labelcontent'
        check 'FirstLabel'
        check 'SecondLabel'
        check 'ThirdLabel'
        click_on '保存する' #new画面
        expect(page).to have_content 'FirstLabel'
        expect(page).to have_content 'SecondLabel'
        expect(page).to have_content 'ThirdLabel'
      end
    end
    context 'タスクを編集した場合' do
      it 'ラベルを追加できる' do
        visit tasks_path
        click_link '編集', match: :first
        check 'FirstLabel'
        check 'SecondLabel'
        check 'ThirdLabel'
        click_on '保存する'
        click_link '詳細', match: :first
        expect(page).to have_content 'FirstLabel'
        expect(page).to have_content 'SecondLabel'
        expect(page).to have_content 'ThirdLabel'
      end
    end
    context 'タスクからラベルを削除する編集をした場合' do
      before do
        visit tasks_path
        click_link '編集', match: :first
        check 'FirstLabel'
        check 'SecondLabel'
        check 'ThirdLabel'
        click_on '保存する'
      end
      it 'ラベルを削除できる' do
        click_link '編集', match: :first
        uncheck 'SecondLabel'
        uncheck 'ThirdLabel'
        click_on '保存する'
        click_link '詳細', match: :first
        expect(page).to have_no_content 'SecondLabel'
        expect(page).to have_no_content 'ThirdLabel'
      end
    end

    context 'ラベル検索をした場合' do
      before do
        visit tasks_path
        click_link '編集', match: :first
        check 'ThirdLabel'
        click_on '保存する'
      end
      it '選択したラベルのタスクのみが表示される' do
        visit tasks_path
        # binding.irb
        # check 'ThirdLabel'
        check "serch_label_ids_609"
        # check 'label_row[2]'
        # choose('ThirdLabel')
        # select 'ThirdLabel', from: 'label_ids'
        # select 'ThirdLabel', from: 'serch_label_ids'
        # select 'ThirdLabel', from: 'serch[label_ids][]'
        # select 'ThirdLabel', from: 'serch_label_ids_230'
        # select '257', from: 'serch_label_ids_257'
        # select('option value' from: 'select locator')
        # binding.irb
        # label_list = all('#label_row')
        # binding.irb
        # check 'label_list[2]'
        click_on '検索'
        expect(page).to have_no_content 'future'
        expect(page).to have_no_content 'old'
      end
    end

  end
end
