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
#  user_id    :integer          not null
#

class List < ActiveRecord::Base

  has_many   :tasks, -> { order('status DESC, updated_at DESC') }
  belongs_to :plan
  belongs_to :user

  scope :with_color_tag, -> (color_tag) { where(color_tag: color_tag) }
end
