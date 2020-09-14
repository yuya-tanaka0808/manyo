FactoryBot.define do
  factory :label do
    name { "FirstLabel" }
  end

  factory :label2, class: Label do
    name { "SecondLabel" }
  end

  factory :label3, class: Label do
    name { "ThirdLabel" }
  end
end
