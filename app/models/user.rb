# == Schema Information
#
# Table name: users
#
#  id                     :integer          not null, primary key
#  email                  :string(255)      default(""), not null
#  encrypted_password     :string(255)      default(""), not null
#  reset_password_token   :string(255)
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  sign_in_count          :integer          default(0), not null
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :string(255)
#  last_sign_in_ip        :string(255)
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  ident                  :string(255)      not null
#

class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :recoverable,
         :rememberable, :trackable, :validatable

  has_many :plans
  has_many :lists
  has_many :tasks

  ACCESSABLE_ATTRS = [:ident, :email, :password, :password_confirmation, :remember_me]
  ALLOW_IDENT_CHARS_REGEXP = /\A[A-Za-z0-9\.\-\_]+\z/

  validates :ident, format: { with: ALLOW_IDENT_CHARS_REGEXP, message: '只允许数字、大小写字母、中划线、和小数点' },
                    length: { in: 3..20 },
                    presence: true,
                    uniqueness: { case_sensitive: true }

  # Virtual attribute for authenticating by either username or email
  # This is in addition to a real persisted field like 'username'
  attr_accessor :login

  def login=(login)
    @login = login
  end

  def login
    @login || self.ident || self.email
  end

  def self.find_for_database_authentication(warden_conditions)
    conditions = warden_conditions.dup
    if login = conditions.delete(:login)
      where(conditions.to_h).where(["lower(ident) = :value OR lower(email) = :value", { :value => login.downcase }]).first
    elsif conditions.has_key?(:ident) || conditions.has_key?(:email)
      where(conditions.to_h).first
    end
  end

end
