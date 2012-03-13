class Role < ActiveRecord::Base 
  acts_as_authorization_role :join_table_name => "roles_usuarios"
  
  scope :basicos, :conditions => "name != 'superadmin' and name != 'localadmin' and name != 'ciudadano'"

  scope :name_like, lambda { |nombre|
    unless nombre.nil? || nombre.empty? || nombre.first.nil?
      where("roles.name like ?", "%#{nombre}%" )
    end
  }
end
# == Schema Information
#
# Table name: roles
#
#  id                :integer         not null, primary key
#  name              :string(40)
#  authorizable_type :string(40)
#  authorizable_id   :integer
#  created_at        :datetime
#  updated_at        :datetime
#

