Dado /^que existe el usuario "([^"]*)" con perfil "([^"]*)"$/ do |user_login, role_name|
  u = Factory :usuario, :username => user_login
  u.has_role!(role_name)
end
