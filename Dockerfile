FROM ruby:2.5

RUN mkdir /enerbot
WORKDIR /enerbot

COPY . /enerbot
RUN bundle install

ENTRYPOINT [ "ruby", "client.rb" ]