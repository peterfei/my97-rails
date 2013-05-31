module My97engine
  class Engine < ::Rails::Engine
    initializer 'my97engine.load_my97engine' do |app|
      app.middleware.use ::ActionDispatch::Static, "#{root}/vendor"
    end
  end
end

