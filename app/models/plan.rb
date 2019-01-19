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

class Plan < ActiveRecord::Base

  has_many :lists, dependent: :destroy
  has_many :tasks, -> { order('status DESC, updated_at DESC') }, dependent: :destroy
  belongs_to :user
  has_one  :list_sort, class_name: 'Sort', as: :sortable, dependent: :destroy

  COLOR_TAG = {'gray' => 0, 'blue' => 1, 'green' => 2, 'red' => 3, 'yellow' => 4, 'qing' => 5}

  validates :title, presence: true, allow_blank: false
  validates :ident, uniqueness: true, presence: true

  scope :with_color_tag, -> (color_tag) { where(color_tag: color_tag) }

  after_create :add_sort
  after_destroy :delete_sort

  def to_param
    ident
  end

  def add_ident
    self.ident = random_ident
  end

  # generate a 8 length random ident
  def random_ident
    chars = 'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789'
    result = ''
    8.times { result << chars[rand(62)] }
    result
  end

  def add_sort
    plan_sort = user.plan_sort
    if plan_sort.nil?
      plan_sort = user.build_plan_sort
      plan_sort.sort = user.plans.pluck(:id)
    else
      plan_sort.sort.push(id)
    end
    plan_sort.save
  end

  def delete_sort
    plan_sort = user.plan_sort
    if plan_sort.present?
      plan_sort.sort.delete(id)
      plan_sort.save
    end
  end
end
