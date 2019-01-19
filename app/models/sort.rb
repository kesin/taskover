# == Schema Information
#
# Table name: sorts
#
#  id            :bigint(8)        not null, primary key
#  sortable_id   :integer          not null
#  sortable_type :string(255)      not null
#  sort          :text(65535)      not null
#

class Sort < ActiveRecord::Base
  serialize :sort
  belongs_to :sortable, polymorphic: true
end
