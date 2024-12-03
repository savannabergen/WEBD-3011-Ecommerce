Rails.configuration.stripe = {
  publishable_key: ENV["pk_test_51QRyDdDzoMWjx7vqDlNP2hWneXRXBhh0QofExKgkqkLIDQCq1uTjjvpNtpy9pPfPnPT9YKfavQElsbAVS4WAvusN00gqle6MDx"],
  secret_key: ENV["sk_test_51QRyDdDzoMWjx7vqsHBuWKQY1r8Sqm2sEufUJjWfX7meD3TUkpyAVShn5Wr6CYxS0NgVgpPrtYuTMUxzh2gsS9Kb00qoyuowXH"]
}
Stripe.api_key = Rails.configuration.stripe[:secret_key]
