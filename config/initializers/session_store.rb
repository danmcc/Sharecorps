# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_sharecorps_session',
  :secret      => '4b4a1d4abdb67293e36d69c03a4c1838e98c46bc0e1b05650610947db46ba724429181b4fd994affa66cb0d7842338d0aa69b7dee8e3b72247bfa5905ab467b0'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
