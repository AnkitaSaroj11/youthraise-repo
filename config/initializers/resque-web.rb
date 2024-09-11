Resque::Server.use(Rack::Auth::Basic) do |user, password|
  user == Rails.application.credentials.dig(:resque, :user)
  password == Rails.application.credentials.dig(:resque, :password)
end