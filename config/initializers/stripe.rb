# Stripe.api_key = Rails.application.credentials.dig(:stripe, :api_key)
Stripe.api_key = Rails.application.credentials.dig(:stripe, :secret_key)