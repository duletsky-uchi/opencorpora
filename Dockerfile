FROM ruby:2.7.1

ENV RAILS_ENV production
ENV RAILS_MASTER_KEY 1ac2c4b00d7c0cfdcab13727a3822099
ENV RAILS_LOG_TO_STDOUT 1
ENV SECRET_KEY_BASE 2d19d9b604c7a6dc590e4e54ff0cce93a531dc4e44a319c5aeed2404b2654031c49a986b5074717e966e6e53f8b328a238962d1c

RUN mkdir -p /app \
  && apt-get update -qq \
  && apt-get install -yq apt-utils build-essential libpq-dev postgresql-client tzdata screen nodejs \
  && apt-get clean \
  && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* \
  && truncate -s 0 /var/log/*log

WORKDIR /app

# Adding gems
COPY Gemfile Gemfile
COPY Gemfile.lock Gemfile.lock
RUN bundle install --full-index --jobs 20 --retry 5 --without development test

# Adding project files
COPY . .

EXPOSE 3000

CMD ["bundle", "exec", "puma", "-C", "config/puma.rb"]
