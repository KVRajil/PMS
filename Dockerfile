FROM ruby:3.0.2
ARG COMMIT
RUN apt-get update -qq && apt-get install -y nodejs postgresql-client
RUN mkdir /project_management_app
WORKDIR /project_management_app
COPY Gemfile /project_management_app/Gemfile
COPY Gemfile.lock /project_management_app/Gemfile.lock
RUN bundle lock --add-platform x86_64-linux
RUN bundle check || bundle install
COPY . /project_management_app
RUN echo $COMMIT > /project_management_app/config/revision.txt

# Add a script to be executed every time the container starts.
COPY entrypoint.sh /usr/bin/
RUN chmod +x /usr/bin/entrypoint.sh
ENTRYPOINT ["entrypoint.sh"]
EXPOSE 3000

# Start the main process.
CMD ["rails", "server", "-b", "0.0.0.0"]
