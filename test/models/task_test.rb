# == Schema Information
#
# Table name: tasks
#
#  id          :integer          not null, primary key
#  title       :text(65535)
#  description :text(65535)
#  status      :integer          default(1)
#  list_id     :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  plan_id     :integer
#

require 'test_helper'

class TaskTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
