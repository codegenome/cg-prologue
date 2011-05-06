# Add the rack fiber pool gem
gem "rack-fiber_pool", :require => "rack/fiber_pool"

# Add Our Initializer
initializer('rack_fiber_pool_middleware.rb') do
<<-'FILE'
# Add in our rack fiber pool middleware
Rails.configuration.middleware.insert_before ActionDispatch::Static , Rack::FiberPool

# Remove the rack lock middleware
Rails.configuration.threadsafe!

FILE
end

