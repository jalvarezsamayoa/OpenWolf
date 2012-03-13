require 'spec_helper'

describe Nota do
  pending "add some examples to (or delete) #{__FILE__}"
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

