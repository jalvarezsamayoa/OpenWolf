AdminData.config do |config|
  config.is_allowed_to_view = lambda {|controller| controller.send('requiere_usuario') }
  config.is_allowed_to_update = lambda {|controller| controller.send('usuario_actual_admin?') }
end
