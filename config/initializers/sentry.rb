# frozen_string_literal: true

Sentry.init do |config|
  config.dsn = "https://efc0f64a62734113881521032c8ecb97@o502818.ingest.sentry.io/5585565"
  config.breadcrumbs_logger = [:active_support_logger]
  config.traces_sample_rate = 0.5
end
