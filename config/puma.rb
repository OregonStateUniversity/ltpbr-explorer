workers Integer(ENV.fetch('WEB_CONCURRENCY', 2))
threads_count = ENV.fetch("RAILS_MAX_THREADS") { 5 }
threads threads_count, threads_count
rackup      DefaultRackup
port        ENV.fetch('PORT') { 3000 }
environment ENV.fetch('RACK_ENV') { 'development' }

preload_app!

before_fork do
  ActiveRecord::Base.connection_pool.disconnect! if defined?(ActiveRecord)
end

on_worker_boot do
  # Worker specific setup for Rails 4.1+
  # See: https://devcenter.heroku.com/articles/
  # deploying-rails-applications-with-the-puma-web-server#on-worker-boot
  ActiveRecord::Base.establish_connection if defined?(ActiveRecord)
end

plugin :tmp_restart
