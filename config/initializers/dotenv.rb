# Raise if variables not set
Dotenv.require_keys()

# parse a list of env files for programmatic inspection without modifying the ENV
Dotenv.parse(".env.local")
