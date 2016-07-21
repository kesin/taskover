# == Schema Information
#
# Table name: lists
#
#  id         :integer          not null, primary key
#  title      :text(65535)
#  plan_id    :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  color_tag  :integer          default(0)
#

class List < ActiveRecord::Base

  has_many   :tasks
  belongs_to :plan
  belongs_to :user
end
