# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)
# 固定カテゴリの作成
# 既存データのクリーンアップ(開発環境のみ)
if Rails.env.development?
  puts "Cleaning up existing data..."
  Product.destroy_all
  User.destroy_all
  Category.destroy_all
end

# カテゴリの作成
puts "Creating categories..."
categories_data = ['食品', 'ストック品', '薬', '洋服', '雑貨', 'その他']
created_categories = categories_data.map do |name|
  Category.find_or_create_by!(name: name)
end
puts "Categories created: #{Category.count}"

# テストユーザーの作成
puts "Creating test user..."
user = User.find_or_create_by!(email: 'test3@example.com') do |u|
  u.user_name = 'testuser3'
  u.password = 'password123'
  u.password_confirmation = 'password123'
end
puts "Test user created: #{user.email}"

# テストメモの作成（30件に変更）
puts "Creating test products..."

30.times do |i|
  Product.create!(
    name: "テストメモ #{i + 1}",
    comment: "これはテストメモ #{i + 1} の内容です。スクロール機能を確認するために作成されました。",
    category: created_categories.sample,  # ランダムにカテゴリを選択
    rating: rand(1..5),
    user: user
  )
end

puts "Test products created: #{Product.count}"


# デモユーザーの作成(本番環境用)
if Rails.env.production?
  puts "Creating demo user..."
  demo_user = User.find_or_create_by!(email: 'demo@example.com') do |u|
    u.user_name = 'demouser'
    u.password = 'demodemo'
    u.password_confirmation = 'demodemo'
  end
  
  # デモユーザーの商品を作成
  puts "Creating demo products..."
  demo_products = [
    { name: '買い物リスト', comment: '牛乳、卵、パンを買う', rating: 3, category_name: '食品' },
    { name: 'プロジェクトメモ', comment: 'MVPリリースの準備', rating: 5, category_name: 'その他' },
    { name: 'Ruby学習', comment: 'Railsのアソシエーションを復習', rating: 4, category_name: 'その他' }
  ]
  
  demo_products.each do |product_data|
    category = Category.find_by(name: product_data[:category_name])
    Product.find_or_create_by!(name: product_data[:name], user: demo_user) do |p|
      p.comment = product_data[:comment]
      p.rating = product_data[:rating]
      p.category = category
    end
  end
  puts "Demo products created: #{demo_user.products.count}"
end

# 作成されたデータの確認
puts "Seed data created successfully!"
puts "=" * 50
puts "Users: #{User.count}"
puts "Categories: #{Category.count}"
puts "Products: #{Product.count}"
puts "=" * 50