# Be sure to restart your server when you modify this file.

# Version of your assets, change this if you want to expire all your assets.
Rails.application.config.assets.version = "1.0"

# Add all CSS files to precompile
Rails.application.config.assets.precompile += %w( 
  application.css
  active_admin.css
)

# Add additional assets to the asset load path.
# Rails.application.config.assets.paths << Emoji.images_path
