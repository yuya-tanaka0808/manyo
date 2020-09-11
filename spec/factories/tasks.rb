FactoryBot.define do
  factory :task do
    title { 'Factoryで作成したデフォルトタイトル１' }
    content { 'Factoryで作成したデフォルトコンテント１' }
    time_limit { '2020-09-30 12:00:00' }
    status { '未着手'}
    priority { '中' }
    user_id { User.last.id }
  end

  factory :task1, class: Task do
    title { 'task1' }
    content {'content1-old' }
    time_limit { '2019-10-01 12:00:00' }
    status { '未着手' }
    priority { '高' }
    user_id { User.last.id }
   end

   factory :task2, class: Task do
     title { 'task2' }
     content {'content2-future' }
     time_limit { '2021-10-01 12:00:00' }
     status { '完了' }
     priority { '低' }
     user_id { User.last.id }
    end

    factory :task3, class: Task do
      title { 'task3' }
      content {'content3-now' }
      time_limit { '2020-10-01 12:00:00' }
      status { '未着手' }
      priority { '中' }
      user_id { User.last.id }
     end

end
