# Change :secret_key to :private_key to match your YAML file
Stripe.api_key = Rails.application.credentials.dig(:stripe, :private_key)