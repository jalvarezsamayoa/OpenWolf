class Usuario < ActiveRecord::Base
  versioned :except => [:password, :last_request_at, :sing_in_count, :failed_attempts,
                        :current_sing_int_at, :last_sign_in_ip]

  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable, :lockable and :timeoutable
  devise :database_authenticatable, :registerable,   
  :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me, :nombre, :cargo, :departamento_id, :areadocumento_id, :puesto_id, :institucion_id, :essupervisorarea, :username

  attr_accessor :login
  
  acts_as_authorization_subject  :association_name => :roles, :join_table_name => "roles_usuarios"

  belongs_to :institucion

  has_and_belongs_to_many :roles, :join_table => "roles_usuarios"
  
  has_many :actividades
  has_many :solicitudes
  has_many :documentos

  validates_associated :institucion
  accepts_nested_attributes_for :roles

  validates_presence_of :nombre, :email, :cargo, :institucion_id
  validates_uniqueness_of :nombre, :email

  scope :udip, :joins => :roles, :conditions => "roles.name = 'userudip' or roles.name = 'superudip'"
  scope :supervisores, :joins => :roles, :conditions => "roles.name = 'superudip'"
  scope :enlaces, :joins => :roles, :conditions => "roles.name = 'userudip' or roles.name = 'superudip' or roles.name = 'enlace'"
  scope :ciudadanos, :joins => :roles, :conditions => "roles.name = 'ciudadano'"
  
  
  def to_label
    nombre_cargo
  end

  def nombre_cargo
    return nombre + ', ' + cargo
  end

  def nombre_institucion
    return nombre + ' en ' + institucion.nombre
  end
  
  protected

  def self.find_for_database_authentication(conditions)
    login = conditions.delete(:login)
    where(conditions).where(["username = :value OR email = :value", { :value => login }]).first
  end
  
end
