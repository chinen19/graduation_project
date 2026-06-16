# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)
# 固定カテゴリの作成
categories = ['食品', 'ストック品', '薬', '洋服', '雑貨', 'その他']

categories.each do |category_name|
  Category.find_or_create_by(name: category_name)
end

puts "固定カテゴリを作成しました!"
