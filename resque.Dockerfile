# Set the base image to Ruby 3.0.3
FROM ruby:3.1.2

# Install system dependencies
RUN apt-get update && \
    apt-get install -y nodejs nginx libvips42

# Set the working directory in the container
WORKDIR /app

# Copy the Gemfile and Gemfile.lock files to the container
COPY Gemfile Gemfile.lock ./

# Install the gems
RUN bundle install --jobs 20 --retry 5

# Copy the application code to the container
COPY . .

CMD bundle exec rake RAILS_ENV=production resque:work QUEUE=*
