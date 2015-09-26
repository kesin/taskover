# == Schema Information
#
# Table name: lists
#
#  id         :integer          not null, primary key
#  title      :text(65535)
#  plan_id    :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class List < ActiveRecord::Base
end
