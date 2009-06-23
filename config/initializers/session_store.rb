# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_eaglecv_session',
  :secret      => 'dda0340b4bc0a8c1b8d489a9283b90a28110593c7f22c48e445720e571cbe7fb0cbd52ad393f556c6550366be62f195467e326a9f5fa9826192fdf5785294bb3'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
