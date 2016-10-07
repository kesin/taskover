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

  has_many :lists, -> { order('created_at DESC') }, dependent: :destroy
  has_many :tasks, -> { order('status DESC, updated_at DESC') }, dependent: :destroy
  belongs_to :user

  COLOR_TAG = {'gray' => 0, 'blue' => 1, 'green' => 2, 'red' => 3, 'yellow' => 4, 'qing' => 5}

  validates :title, presence: true, allow_blank: false
  validates :ident, uniqueness: true, presence: true

  scope :with_color_tag, -> (color_tag) { where(color_tag: color_tag) }

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
end
