# == Schema Information
#
# Table name: plans
#
#  id          :integer          not null, primary key
#  title       :text(65535)
#  description :text(65535)
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  color_tag   :integer          default(0)
#  ident       :string(255)      not null
#  user_id     :integer          not null
#

require 'test_helper'

class PlanTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
