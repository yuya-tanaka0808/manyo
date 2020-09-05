FactoryBot.define do
  factory :task do
    title { 'Factoryで作成したデフォルトタイトル１' }
    content { 'Factoryで作成したデフォルトコンテント１' }
    time_limit { '2020-09-30 12:00:00' }
    status { '未着手'}
  end
end
