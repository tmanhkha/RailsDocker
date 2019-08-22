FROM ruby:2.6

LABEL maintainer='manhkha.thai@gmail.com'

RUN apt-get update -yqq && apt-get install -yqq --no-install-recommends \
  apt-transport-https

RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add -

RUN curl -sL https://deb.nodesource.com/setup_8.x -o nodesource_setup.sh

RUN echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list

RUN apt-get update -yqq && apt-get install -yqq --no-install-recommends \
  nodejs \
  yarn

COPY Gemfile* /usr/src/app/

WORKDIR /usr/src/app

RUN bundle install

COPY . /usr/src/app/

CMD ["bin/rails", "s", "-b", "0.0.0.0"]
