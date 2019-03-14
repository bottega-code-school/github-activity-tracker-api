if Rails.env == 'production'
  Rails.application.config.session_store :cookie_store, key: '_bottega_activity_session', domain: 'bottega-activity-tracker-api.herokuapp.com'
else
  Rails.application.config.session_store :cookie_store, key: '_bottega_activity_session'
end

