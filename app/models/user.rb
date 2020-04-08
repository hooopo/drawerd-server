# frozen_string_literal: true

# == Schema Information
#
# Table name: users
#
#  id                     :bigint           not null, primary key
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  remember_created_at    :datetime
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
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, request_keys: [:subdomain]
  belongs_to :company, optional: true
  has_many :groups
  has_many :projects

  # notice: overise devise validation on email
  validates_uniqueness_of :email, :scope => :company_id
  validates_presence_of :email, allow_blank: true, if: :email_changed?
  validates_format_of :email, with: /\A[^@\s]+@[^@\s]+\z/, allow_blank: true, if: :email_changed?

  def email_required?
    false
  end

  attr_accessor :subdomain

  def self.find_for_authentication(conditions={})
    conditions[:company_id] = Company.find_by_subdomain(conditions.delete(:subdomain)).id
    super(conditions)
  end

  before_create do
    self.company = create_company(subdomain: subdomain)
  end

  def username
    email.split("@")[0]
  end

  def avatar_url
    ["https://www.gravatar.com/avatar", Digest::MD5.hexdigest(email)].join("/")
  end
end
