FROM ruby:2.3.0

RUN apt-get update -qq \
  && apt-get install -yqq build-essential \
    libpq-dev \
    nodejs

RUN mkdir /library
WORKDIR /library
COPY Gemfile* ./
RUN bundle install
COPY . .
RUN RAILS_ENV=production bundle exec rake assets:precompile
EXPOSE 3000
CMD ["bundle", "exec", "puma", "-C", "config/puma.rb", "-p", "3000"]
