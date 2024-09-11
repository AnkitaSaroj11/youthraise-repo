if Rails.env.production?
  Resque.redis = 'redis.youthraise.com'
elsif Rails.env.development?
  Resque.redis = 'redis://localhost:6379/1'
end