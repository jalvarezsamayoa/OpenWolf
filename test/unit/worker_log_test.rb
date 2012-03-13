require 'test_helper'

class WorkerLogTest < ActiveSupport::TestCase
  # Replace this with your real tests.
  test "the truth" do
    assert true
  end
end
# == Schema Information
#
# Table name: worker_logs
#
#  id         :integer         not null, primary key
#  status     :text
#  process_id :integer
#  last_error :text
#  created_at :datetime
#  updated_at :datetime
#

