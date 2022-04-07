FROM ruby:3

# based on https://github.com/timbru31/docker-ruby-node/blob/master/3.1/16/Dockerfile
RUN curl -sL https://deb.nodesource.com/setup_17.x | bash -\
  && apt-get update -qq && apt-get install -qq --no-install-recommends \
    postgresql-client nodejs redis-tools \
  && apt-get upgrade -qq \
  && apt-get clean \
  && rm -rf /var/lib/apt/lists/*\
  && npm install -g yarn

RUN mkdir /myapp
WORKDIR /myapp

COPY Gemfile /myapp/Gemfile
COPY Gemfile.lock /myapp/Gemfile.lock

RUN bundle install

COPY . /myapp

RUN yarn install

EXPOSE 3000

CMD "bin/dev"
