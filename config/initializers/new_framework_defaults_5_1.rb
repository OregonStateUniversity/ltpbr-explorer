# From 5.1.4 -> 5.1.5 -> 5.1.6

# Make `form_with` generate non-remote forms.
Rails.application.config.action_view.form_with_generates_remote_forms = true

# Unknown asset fallback will return the path passed in when the given
# asset is not present in the asset pipeline.
Rails.application.config.assets.unknown_asset_fallback = false
