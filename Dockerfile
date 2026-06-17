FROM ruby:3.2.2

RUN apt-get update -qq && apt-get install -y \
  build-essential \
  libpq-dev \
  nodejs \
  yarn

WORKDIR /app

COPY Gemfile Gemfile.lock ./
RUN bundle install

COPY . .

EXPOSE 3000

CMD ["sh", "-c", "bundle exec rails db:migrate RAILS_ENV=production && bundle exec puma -C config/puma.rb"]
