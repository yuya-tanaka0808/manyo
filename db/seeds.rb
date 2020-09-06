3.times do |n|
  User.create!(name: "number#{n}",
               email: "number#{n}@seeds.com",
               password: 'password',
               password_confirmation: 'password',
               )
end
