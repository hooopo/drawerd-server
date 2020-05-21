# frozen_string_literal: true

# == Schema Information
#
# Table name: users
#
#  id                     :bigint           not null, primary key
#  email                  :string           default(""), not null
#  password_digest        :string           default(""), not null
#  remember_created_at    :datetime
#  remember_token         :string
#  reset_password_sent_at :datetime
#  reset_password_token   :string
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  company_id             :bigint
#
# Indexes
#
#  index_users_on_company_id            (company_id)
#  index_users_on_company_id_and_email  (company_id,email) UNIQUE
#  index_users_on_reset_password_token  (reset_password_token) UNIQUE
#
# Foreign Keys
#
#  fk_rails_...  (company_id => companies.id)
#

class User < ApplicationRecord
  has_secure_password

  belongs_to :company, touch: true
  has_many :groups
  has_many :projects
  has_one :own_company, foreign_key: :owner_id, class_name: "Company", inverse_of: :owner
  has_many :invitations
  has_many :subscriptions
  has_many :purchases
  accepts_nested_attributes_for :own_company

  validates :email, uniqueness: { scope: :company_id, message: "should be uniqueness per company" }
  validates_presence_of :password
  validates_format_of :email, with: /\A[^@\s]+@[^@\s]+\z/

  before_create { generate_token(:remember_token) }

  def generate_token(column)
    begin
      self[column] = SecureRandom.hex(32)
    end while User.exists?(column => self[column])
  end

  attr_accessor :remember_me
  attr_accessor :invite_token

  def remember_me
    true
  end

  def username
    email.split("@")[0]
  end

  def avatar_url
    ["https://www.gravatar.com/avatar", Digest::MD5.hexdigest(email)].join("/")
  end
end
