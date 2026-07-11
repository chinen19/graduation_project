# ベースイメージの指定
FROM ruby:3.2.2

# 必要なパッケージのインストール
RUN apt-get update -qq && \
    apt-get install -y build-essential libpq-dev nodejs yarn && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# 作業ディレクトリの設定
WORKDIR /app

# Gemfile と Gemfile.lock をコピー
COPY Gemfile Gemfile.lock ./

# Bundler のインストールと gem のインストール
RUN gem install bundler && bundle install

# package.json と yarn.lock をコピー
COPY package.json yarn.lock ./

# Node.js の依存関係をインストール
RUN yarn install

# アプリケーションのコードをコピー
COPY . .

# アセットプリコンパイル
RUN RAILS_ENV=production SECRET_KEY_BASE=dummy bundle exec rails assets:precompile

# Start script を作成
RUN echo '#!/bin/bash\n\
set -e\n\
bundle exec rails db:migrate RAILS_ENV=production\n\
bundle exec rails db:seed RAILS_ENV=production\n\
exec bundle exec puma -C config/puma.rb' > /app/start.sh && chmod +x /app/start.sh

# ポートの公開（Render では 10000 を使用）
EXPOSE 10000

# アプリケーションの起動（start.sh を使用）
CMD ["/app/start.sh"]