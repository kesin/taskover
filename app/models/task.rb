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

class Task < ActiveRecord::Base

  belongs_to :plan
  belongs_to :list
  belongs_to :user

  def closed?
    self.status == 0
  end

  def opened?
    self.status == 1
  end

  def close!
    self.transaction do
      update_attributes(status: 0)
    end
  end

  def open!
    self.transaction do
      update_attributes(status: 1)
    end
  end

end
