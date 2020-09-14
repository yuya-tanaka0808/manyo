User.create!(name: "admin",
             email: "admin@seeds.com",
             password: 'password',
             password_confirmation: 'password',
             admin: true
)

19.times do |n|
  User.create!(name: "number#{n}",
               email: "number#{n}@seeds.com",
               password: 'password',
               password_confirmation: 'password',
               )
end

10.times do |n|
  Label.create!(name: "Label#{n}")
end

5.times do |n|
  Task.create!(title: "Task-#{n}",
               content: "abc",
               time_limit: '2020-09-30 12:00:00',
               status: '未着手',
               priority: '高',
               user_id:  1
  )
end
5.times do |n|
  Task.create!(title: "Task-#{n}",
               content: "def",
               time_limit: '2020-09-30 12:00:00',
               status: '着手中',
               priority: '中',
               user_id: 1
  )
end
5.times do |n|
  Task.create!(title: "Task-#{n}",
               content: "ghi",
               time_limit: '2020-09-30 12:00:00',
               status: '完了',
               priority: '低',
               user_id: 1
)
end

7.times do |n|
  Task.create!(title: "Task-#{n}",
               content: "abc",
               time_limit: '2020-09-30 12:00:00',
               status: '未着手',
               priority: '高',
               user_id:  2
  )
end
7.times do |n|
  Task.create!(title: "Task-#{n}",
               content: "def",
               time_limit: '2020-09-30 12:00:00',
               status: '着手中',
               priority: '中',
               user_id: 2
  )
end
7.times do |n|
  Task.create!(title: "Task-#{n}",
               content: "ghi",
               time_limit: '2020-09-30 12:00:00',
               status: '完了',
               priority: '低',
               user_id: 2
  )
end
