ActiveAdmin.setup do |config|
  config.site_title = "Cr Sessions"
  config.authentication_method = :authenticate_admin_user!
  config.current_user_method = :current_user
  config.logout_link_path = :destroy_user_session_path
  config.logout_link_method = :delete
  config.batch_actions = true
  config.filter_attributes = [ :encrypted_password, :password, :password_confirmation ]
  config.localize_format = :long

  config.use_webpacker = false

  config.register_stylesheet "active_admin.css"
  config.register_javascript "active_admin.js"

  config.authorization_adapter = ActiveAdmin::CanCanAdapter
  config.cancan_ability_class = "AdminAbility"
end
