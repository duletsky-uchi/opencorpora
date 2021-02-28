FROM ruby:2.7.1

ENV RAILS_ENV production
ENV RAILS_MASTER_KEY e127bd2a8b2d1106d3b5fa3d305a8bb1
ENV RAILS_LOG_TO_STDOUT 1
ENV SECRET_KEY_BASE secret_key_base: 91012ec8025f9fb40014518bbb59f549adcb9fd689cb2eba720a1a368e25665f4fc4c3844022937ce3bf22e62bb9ae7c9275873833d6e238295eeff416b059$

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
