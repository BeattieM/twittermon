FROM ruby:2.4.1
RUN apt-get update -qq && apt-get install -y build-essential libpq-dev nodejs
RUN mkdir /twittermon
WORKDIR /twittermon
ADD Gemfile /twittermon/Gemfile
ADD Gemfile.lock /twittermon/Gemfile.lock
RUN bundle install
ADD . /twittermon
RUN chmod 766 lint