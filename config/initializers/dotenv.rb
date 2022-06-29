if Rails.env.development? || Rails.env.test?
  Dotenv.require_keys(
    "CLOUDINARY_URL",
    "CLOUDINARY_NAME",
    "CLOUDINARY_API_KEY",
    "CLOUDINARY_API_SECRET",
    "BRAINTREE_NONCE_PREFIX",
    "BRAINTREE_CLIENT_AUTHORIZATION",
    "BRAINTREE_MERCHANT_ID",
    "BRAINTREE_PUBLIC_KEY",
    "BRAINTREE_PRIVATE_KEY",
    "PAYPAL_CLIENT_ID",
    "SENDGRID_API_KEY"
  )

  Dotenv.parse(".env.local")
end
