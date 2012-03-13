require 'test_helper'

class TempAssetTest < ActiveSupport::TestCase
  # Replace this with your real tests.
  test "the truth" do
    assert true
  end
end
# == Schema Information
#
# Table name: temp_assets
#
#  id                   :integer         not null, primary key
#  institucion_id       :integer
#  usuario_id           :integer
#  options              :text
#  created_at           :datetime
#  updated_at           :datetime
#  archivo_file_name    :string(255)
#  archivo_content_type :string(255)
#  archivo_file_size    :integer
#  archivo_updated_at   :datetime
#

