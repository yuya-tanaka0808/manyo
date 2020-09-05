require 'rails_helper'
RSpec.describe 'タスク管理機能', type: :system do
  let!(:task1) {FactoryBot.create(:task, title: 'task1',content: 'content1-old', time_limit: '2019-10-01 12:00:00', status: '未着手')}
  let!(:task2) {FactoryBot.create(:task, title: 'task2',content: 'content2-future', time_limit: '2021-10-01 12:00:00', status: '完了')}
  let!(:task3) {FactoryBot.create(:task, title: 'task3',content: 'content3-now', time_limit: '2020-10-01 12:00:00', status: '未着手')}

  describe '新規作成機能' do
    context 'タスクを新規作成した場合' do
      it '作成したタスクが表示される' do
        # task = FactoryBot.create(:task,title: 'task')
        # visit tasks_path
        # expect(page).to have_content 'task'
        visit new_task_path
        fill_in 'task_title', with: 'test'
        fill_in 'task_content', with: 'testcontent'
        select 2018, from: 'task_time_limit_1i'
        select '着手中', from: 'task_status'
        click_on '投稿する' #new画面
        click_on '保存する' #confirm画面
        expect(page).to have_content 'testcontent'
        expect(page).to have_content 2018
        expect(page).to have_content '着手中'
      end
    end
  end
  describe '一覧表示機能' do
    context '一覧画面に遷移した場合' do
      it '作成済みのタスク一覧が表示される' do
        #テストで使用するためタスク作成
        task = FactoryBot.create(:task, title: 'task10', content: 'content10', time_limit: '2020-09-01 13:00:00')
        visit tasks_path
        #タスク一覧ページに遷移出来ているか確認
        current_path
        #タスクがデータベースに作成されているか確認
        Task.count
        #表示するHTMLにタスク情報が入っているか確認
        page.html
        expect(page).to have_content 'task10'
      end
    end
    context 'タスクが作成日時の降順に並んでいる場合' do
      it '新しいタスクが一番上に表示される'do
        visit tasks_path
        task_list = all('.task_row')
        # タスク一覧を配列として取得するためにView側でidを降っておく
        expect(task_list[0]).to have_content 'task3'
      end
    end
    context '期限でソートした場合' do
      it 'タスクが期限の降順で並んでいること' do
        visit tasks_path(sort_expired: "true")
        task_list = all('.task_row_timelimit')
        expect(task_list[0]).to have_content '2021/10/01'
        expect(task_list[1]).to have_content '2020/10/01'
      end
    end
  end
  describe '検索機能' do
    context 'タイトルであいまい検索した場合' do
      it '検索ワードを含むタスク名だけ表示' do
        visit tasks_path
        fill_in :serch_title, with: 'task1'
        click_on '検索'
        expect(page).to have_content 'old'
      end
    end
    context '状態選択で検索した場合' do
      it '選択した状態と一致するタスク名だけ表示' do
        visit tasks_path
        select '完了', from: 'serch_status'
        click_on '検索'
        expect(page).to have_content 'future'
      end
    end
    context 'タイトルであいまい検索＋状態選択で検索した場合' do
      it '検索ワードを含み、かつ選択した状態と一致するタスク名だけ表示' do
        visit tasks_path
        fill_in :serch_title, with: '3'
        select '未着手', from: 'serch_status'
        click_on '検索'
        expect(page).to have_content 'now'
      end
    end
  end
  describe '詳細表示機能' do
     context '任意のタスク詳細画面に遷移した場合' do
       it '該当タスクの内容が表示される' do
         task = FactoryBot.create(:task, title: 'task5', content:'content5-show')
         visit task_path(task.id)
         expect(page).to have_content 'show'
       end
     end
  end
end
