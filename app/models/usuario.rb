# -*- coding: utf-8 -*-
class Usuario < ActiveRecord::Base
  # configuracion plugin vestal_versions
  # provee log de cambios excepto en los siguientes campos
  versioned :except => [:password, :last_request_at, :sing_in_count, :failed_attempts,
                        :current_sing_int_at, :last_sign_in_ip]

  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable, :lockable and :timeoutable
  devise :database_authenticatable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me, :nombre, :cargo, :departamento_id, :areadocumento_id, :puesto_id, :institucion_id, :essupervisorarea, :username, :role_ids, :login

  # atributo virtual necesario para que plugin Devise
  # pueda utilizar campo login en lugar de email
  attr_accessor :login

  # configuracion plugin acl9
  # agrega funcion usuario.has_role?
  acts_as_authorization_subject  :association_name => :roles, :join_table_name => "roles_usuarios"

  ############
  # Relaciones
  ############

  belongs_to :institucion

  has_and_belongs_to_many :roles, :join_table => "roles_usuarios"
  
  has_many :actividades
  has_many :solicitudes
  has_many :documentos
  has_many :documentotraslados
  has_many :documentostrasladados, :class_name => "Documentotraslado", :foreign_key => "destinatario_id"

  ###############
  # Validaciones
  ###############

  validates_associated :institucion
  accepts_nested_attributes_for :roles

  validates_presence_of :nombre, :email, :cargo, :institucion_id, :username
  validates_uniqueness_of :nombre, :email, :username

  def before_destroy
    check_for_children({:actividades => "Actividades", :solicitudes => "Solicitudes", :documentos => "Documentos"})
  end

  #################
  # Filtros
  #################

  default_scope :include => :institucion, :order => "instituciones.nombre asc, usuarios.nombre asc"
  
  scope :udip, :joins => :roles, :conditions => "roles.name = 'userudip' or roles.name = 'superudip'"
  scope :supervisores, :joins => :roles, :conditions => "roles.name = 'superudip'"
  scope :enlaces, :joins => :roles, :conditions => "roles.name = 'userudip' or roles.name = 'superudip' or roles.name = 'enlace'"
  scope :ciudadanos, :joins => :roles, :conditions => "roles.name = 'ciudadano'"

  scope :nombre_like, lambda { |nombre|
    unless nombre.nil? || nombre.empty? || nombre.first.nil?
      valor = "%#{nombre}%".upcase
      where("UPPER(usuarios.username) like ? or UPPER(usuarios.nombre) like ? or UPPER(usuarios.cargo) like ? or UPPER(instituciones.nombre) like ?", valor, valor, valor, valor )
   end
  }

  ###############################
  # Metodos publicos de Instancia
  ###############################

  # metodo auxiliar para plugin Formtastic
  def to_label
    nombre_cargo
  end

  # retorna combinacion de nombre real de usuario mas su cargo
  def nombre_cargo
    return nombre + ', ' + cargo
  end

  # retorna combinacion de nombre real de usuario mas nombre de
  # institucion donde labora
  def nombre_institucion
    return nombre + ' en ' + institucion.nombre
  end

  ################################
  # Metodos protegidos
  ################################
  

    protected
  # Permite que plugin Devise pueda utilizar 'username' en lugar de 'email'
  def self.find_for_database_authentication(conditions)
    login = conditions.delete(:login)
    where(conditions).where(["usuarios.username = :value OR usuarios.email = :value", { :value => login }]).first
  end
  
end
