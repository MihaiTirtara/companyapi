FROM ruby:2.3.0-slim
RUN apt-get update -qq && apt-get install -y build-essential

ENV APP_ROOT /var/www/docker-sinatra
ENTRYPOINT mkdir -p $APP_ROOT
WORKDIR $APP_ROOT
COPY Gemfile* $APP_ROOT/
RUN gem install bundler --version 2.0.2
RUN bundle install
COPY . $APP_ROOT

EXPOSE 4567

CMD ["bundle", "exec", "rackup", "--host", "0.0.0.0", "-p", "4567"]
