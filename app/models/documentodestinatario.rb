class Documentodestinatario < ActiveRecord::Base
  versioned

  ORIGINAL = 1
  COPIA = 0
  ESTADO_NOENTREGADO = 1
  ESTADO_ENTREGADO = 2
  ESTADO_RECHAZADO = 3
  ESTADOS = [["Pendiente Entrega", ESTADO_NOENTREGADO],
             ["Entregado", ESTADO_ENTREGADO],
             ["Rechazado", ESTADO_RECHAZADO]]
  
  belongs_to :documento
  belongs_to :usuario
  belongs_to :institucion
  belongs_to :copia, :class_name => "Documento", :foreign_key => :copia_id

  default_scope :include => [:documento, :usuario, :institucion]
  
  
end
