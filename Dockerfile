FROM ruby:2.7.2-slim
LABEL maintainer Travis CI GmbH <support+travis-build-docker-images@travis-ci.com>
WORKDIR /app

# packages required for bundle install
RUN ( \
   apt-get update ; \
   apt-get install -y --no-install-recommends git make gcc g++ libpq-dev libjemalloc-dev \
   && rm -rf /var/lib/apt/lists/* \
)

# throw errors if Gemfile has been modified since Gemfile.lock
RUN bundle config --global frozen 1
RUN bundle config set deployment 'true'

RUN mkdir -p /app
WORKDIR /app
COPY Gemfile      /app
COPY Gemfile.lock /app
RUN gem install bundler
RUN bundler install --verbose --retry=3
RUN gem install --user-install executable-hooks
COPY . /app

CMD bundle exec bin/run_backup
