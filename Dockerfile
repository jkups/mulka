FROM ruby:3.0.3

RUN curl https://deb.nodesource.com/setup_12.x | bash
RUN curl https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add -
RUN echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list

RUN apt-get update -qq && apt-get install -y nodejs yarn postgresql-client
WORKDIR /mulka

COPY Gemfile Gemfile.lock ./
RUN bundle install

EXPOSE 3000

COPY . .
