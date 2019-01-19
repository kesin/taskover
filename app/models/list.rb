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

  has_many   :tasks, -> { order('status DESC, updated_at DESC') }, dependent: :destroy
  belongs_to :plan
  belongs_to :user
  has_one   :task_sort, class_name: 'Sort', as: :sortable, dependent: :destroy

  scope :with_color_tag, -> (color_tag) { where(color_tag: color_tag) }

  after_save :add_sort
  after_destroy :delete_sort

  def add_sort
    list_sort = plan.list_sort
    if list_sort.nil?
      list_sort = plan.build_list_sort
      list_sort.sort = plan.lists.pluck(:id)
    else
      list_sort.sort.push(id)
    end
    list_sort.save
  end

  def delete_sort
    list_sort = plan.list_sort
    if list_sort.present?
      list_sort.sort.delete(id)
      list_sort.save
    end
  end
end
