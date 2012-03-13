# -*- coding: utf-8 -*-
class Nota < ActiveRecord::Base
  attr_accessor :dont_send_email
  
  belongs_to :proceso, :polymorphic => true
  belongs_to :usuario
  validates_presence_of :texto, :usuario_id
  
  after_create :notificar_creacion

  scope :publicas, where(:informacion_publica => true)
  scope :privadas, where(:informacion_publica => false)
  scope :restringir, lambda { |restringir_privadas| restringir_privadas == true ? where(:informacion_publica => true) : all  }

  def tipo_nombre
    return ( informacion_publica ? 'Pública' : 'Interno')
  end

  private

  def notificar_creacion
    Notificaciones.delay.deliver_nueva_nota_seguimiento(self) unless (self.dont_send_email == true)
  end
end
# == Schema Information
#
# Table name: notas
#
#  id                  :integer         not null, primary key
#  proceso_id          :integer
#  proceso_type        :string(255)
#  usuario_id          :integer
#  texto               :text
#  created_at          :datetime
#  updated_at          :datetime
#  informacion_publica :boolean         default(TRUE), not null
#

