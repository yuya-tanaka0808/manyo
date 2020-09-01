require 'rails_helper'
RSpec.describe 'タスク管理機能', type: :system do
  let!(:task1) {FactoryBot.create(:task, title: 'task0',content: 'content0')}
  before do
    FactoryBot.create(:task)
    FactoryBot.create(:second_task)
  end
  describe '新規作成機能' do
    context 'タスクを新規作成した場合' do
      it '作成したタスクが表示される' do
        # task = FactoryBot.create(:task,title: 'task')
        # visit tasks_path
        # expect(page).to have_content 'task'
        visit new_task_path
        fill_in 'task_title', with: 'タスク'
        fill_in 'task_content', with: 'コンテンツ'
        click_on '投稿する' #new画面
        click_on '投稿する' #confirm画面
        expect(page).to have_content 'タスク'
      end
    end
  end
  describe '一覧表示機能' do
    context '一覧画面に遷移した場合' do
      it '作成済みのタスク一覧が表示される' do
        #テストで使用するためタスク作成
        task = FactoryBot.create(:task, title: 'task1', content: 'content1')
        visit tasks_path
        #タスク一覧ページに遷移出来ているか確認
        current_path
        #タスクがデータベースに作成されているか確認
        Task.count
        #表示するHTMLにタスク情報が入っているか確認
        page.html
        expect(page).to have_content 'task'
      end
    end
    context 'タスクが作成日時の降順に並んでいる場合' do
      it '新しいタスクが一番上に表示される'do
        visit tasks_path
        task_list = all('.task_row')
        # タスク一覧を配列として取得するためにView側でidを降っておく
        expect(task_list[0]).to have_content 'タイトル２'
      end
    end
  end
  describe '詳細表示機能' do
     context '任意のタスク詳細画面に遷移した場合' do
       it '該当タスクの内容が表示される' do
         task = FactoryBot.create(:task, title: 'task2', content:'content2')
         visit task_path(task.id)
         expect(page).to have_content 'task'
       end
     end
  end
end
