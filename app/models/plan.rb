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
#

class Plan < ActiveRecord::Base

  has_many :lists
  has_many :tasks

  validates_uniqueness_of :ident

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
