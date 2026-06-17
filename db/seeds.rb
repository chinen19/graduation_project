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

# 既存データのクリーンアップ（開発環境のみ）
if Rails.env.development?
  puts "Cleaning up existing data..."
  Product.destroy_all
  User.destroy_all
  Category.destroy_all
end

# カテゴリの作成
puts "Creating categories..."
categories_data = ['食品', 'ストック品', '薬', '洋服', '雑貨', 'その他']
categories_data.each do |name|
  Category.find_or_create_by!(name: name)
end
puts "Categories created: #{Category.count}"

# テストユーザーの作成
puts "Creating test user..."
user = User.find_or_create_by!(email: 'test@example.com') do |u|
  u.user_name = 'testuser'
  u.password = 'password'
  u.password_confirmation = 'password'
end
puts "Test user created: #{user.email}"

# テストメモの作成
puts "Creating test products..."
5.times do |i|
  Product.find_or_create_by!(name: "テストメモ#{i + 1}", user: user) do |p|
    p.comment = "これはテストメモ#{i + 1}です。メモの内容をここに記載します。"
    p.rating = rand(1..5)
    p.category = Category.all.sample
  end
end
puts "Test products created: #{Product.count}"

# デモユーザーの作成（本番環境用）
if Rails.env.production?
  puts "Creating demo user..."
  demo_user = User.find_or_create_by!(email: 'demo@example.com') do |u|
    u.user_name = 'demouser'
    u.password = 'demodemo'
    u.password_confirmation = 'demodemo'
  end
  
  # デモユーザーのメモを作成
  puts "Creating demo products..."
 demo_memos = [
  { name: '買い物リスト', comment: '牛乳、卵、パンを買う', rating: 3, category_name: '食品' },
  { name: 'プロジェクトメモ', comment: 'MVPリリースの準備', rating: 5, category_name: 'その他' },
  { name: 'Ruby学習', comment: 'Railsのアソシエーションを復習', rating: 4, category_name: 'その他' }
 ]

  
  demo_memos.each do |memo_data|
    category = Category.find_by(name: memo_data[:category_name])
    Product.find_or_create_by!(name: memo_data[:name], user: demo_user) do |p|
      p.comment = memo_data[:comment]
      p.rating = memo_data[:rating]
      p.category = category
    end
  end
  puts "Demo products created: #{demo_user.products.count}"
end

puts "Seed data created successfully!"
puts "=" * 50
puts "Users: #{User.count}"
puts "Categories: #{Category.count}"
puts "Products: #{Product.count}"
puts "=" * 50
