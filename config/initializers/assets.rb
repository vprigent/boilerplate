Rails.application.config.assets.version = '1.0'

Rails.application.config.assets.precompile += %w( admin.css admin.js shame.css shame.js critical.js )
Rails.application.config.assets.precompile += %w( highlight.pack.js hljs.css )
