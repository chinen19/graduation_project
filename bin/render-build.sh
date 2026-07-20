#!/usr/bin/env bash
# exit on error
set -o errexit

# Node.js の依存関係をインストール
if [ -f "package.json" ]; then
  echo "Installing Node.js dependencies..."
  yarn install

  # Tailwind CSS のビルド
  echo "Building Tailwind CSS..."
  yarn build:css
fi

# Ruby の依存関係をインストール
bundle install

# アセットをプリコンパイル
bundle exec rake assets:precompile
bundle exec rake assets:clean

# データベースのマイグレーション
# bundle exec rake db:migrate
