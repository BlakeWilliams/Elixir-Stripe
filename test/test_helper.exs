secret = System.get_env("STRIPE_SECRET_KEY")
Stripe.set_secret(secret)

ExUnit.start
