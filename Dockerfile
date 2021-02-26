FROM ruby:3.0

# RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add -
# RUN echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list
#
# RUN curl -sL https://deb.nodesource.com/setup_14.x | bash -

RUN apt-get update -qq
# RUN apt-get install -y --no-install-recommends postgresql-client yarn nodejs
RUN apt-get install -y --no-install-recommends postgresql-client

WORKDIR /trdr
COPY Gemfile /trdr/Gemfile
COPY Gemfile.lock /trdr/Gemfile.lock
RUN bundle install

# ADD yarn.lock /yarn.lock
# ADD package.json /package.json
# RUN yarn install --check-files

COPY . /trdr

COPY entrypoint.sh /usr/bin/
RUN chmod +x /usr/bin/entrypoint.sh
ENTRYPOINT ["entrypoint.sh"]
EXPOSE 3000

CMD ["rails", "server", "-b", "0.0.0.0"]

