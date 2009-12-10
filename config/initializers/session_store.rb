# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_spoiler-free_session',
  :secret      => '0952cd42100c44df4c2554f9aaa3bce5f17b16e4b96d2f340481b3bce5c1274931bb6dfea5cecfa223e5ba3aa059f28609937edb77ddc93a71a3f78111bb8228'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
