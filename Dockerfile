FROM ruby:3.0.1

RUN apt-get update -qq
RUN apt-get install -y --no-install-recommends postgresql-client

WORKDIR /trdr
COPY Gemfile /trdr/Gemfile
COPY Gemfile.lock /trdr/Gemfile.lock
RUN bundle install

COPY . /trdr

COPY entrypoint.sh /usr/bin/
RUN chmod +x /usr/bin/entrypoint.sh
ENTRYPOINT ["entrypoint.sh"]
EXPOSE 3000

CMD ["rails", "server", "-b", "0.0.0.0"]

