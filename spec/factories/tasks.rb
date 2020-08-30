FactoryBot.define do
  factory :task do
    title { 'Factoryで作成したデフォルトタイトル１' }
    content { 'Factoryで作成したデフォルトコンテント１' }
  end
  factory :second_task, class: Task do
    title { 'Factoryで作ったデフォルトのタイトル２' }
    content { 'Factoryで作ったデフォルトのコンテント２' }
  end
end
