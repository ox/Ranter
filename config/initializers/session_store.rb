# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_Ranter_session',
  :secret      => '83a296fc0f994c29d66d165e501ab0d13bd8bbb68f028e3729cdb46adac1e54e2b269818c28a493f3d649a915efd5e43129035e2a315a00433a41b69eea90258'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
