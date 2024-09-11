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

# Precompile the assets
RUN RAILS_ENV=production bundle exec rake assets:precompile

RUN RAILS_ENV=production rake db:migrate

## Configure Nginx
COPY nginx.conf /etc/nginx/nginx.conf
COPY nginx-default.conf /etc/nginx/conf.d/default.conf

EXPOSE 80

CMD ["sh", "-c", "RAILS_ENV=production rails server & nginx -g 'daemon off;'"]
