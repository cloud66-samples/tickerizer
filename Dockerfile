FROM ruby:3.0.6-bullseye

RUN apt-get update -qq
RUN apt-get install -y build-essential nodejs npm

WORKDIR /app

RUN gem install bundler --version=2.2.6

COPY Gemfile Gemfile.lock ./
COPY package.json yarn.lock ./

RUN npm install -g yarn
RUN yarn install --check-files
RUN bundle lock --add-platform x86_64-linux && bundle install

COPY . .

RUN bundle exec rake assets:precompile
