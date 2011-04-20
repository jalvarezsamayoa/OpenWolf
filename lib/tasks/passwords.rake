namespace :passwords do
  desc "Reiniciar todos los pwds"

  task :reset => :environment do
    puts "Reiniciando passwords"
    Usuario.order("usuarios.id").each do |usuario|
      puts "#{usuario.username}"
      usuario.password = '123456'
      usuario.password_confirmation = '123456'
      unless usuario.save
        puts "Error! #{usuario.username}"
      end
    end
  end
end
