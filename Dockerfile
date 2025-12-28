FROM ruby:3.3.10
WORKDIR /everydayrails-rspec-jp-2024
COPY Gemfile* /everydayrails-rspec-jp-2024/
RUN bundle install
EXPOSE 3000
CMD ["rails", "server", "-b", "0.0.0.0"]
