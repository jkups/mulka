# # Raise if variables not set
Dotenv.require_keys(
  "CLOUDINARY_NAME", "CLOUDINARY_API_KEY", "CLOUDINARY_API_SECRET"
)

# # parse a list of env files for programmatic inspection without modifying the ENV
Dotenv.parse(".env.local")
