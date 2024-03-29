# frozen_string_literal: true

# == Schema Information
#
# Table name: projects
#
#  id                              :bigint           not null, primary key
#  adapter(postgresql,mysql,mssql) :string           default("postgresql"), not null
#  arrow_color                     :string
#  auto_draw                       :boolean          default(FALSE)
#  bg_color                        :string
#  export_foreign_key              :boolean          default(TRUE)
#  import_sql_data                 :jsonb
#  name                            :string
#  relation_csv_data               :jsonb
#  share_key                       :string
#  table_body_color                :string
#  table_csv_data                  :jsonb
#  table_header_color              :string
#  created_at                      :datetime         not null
#  updated_at                      :datetime         not null
#  company_id                      :bigint
#  user_id                         :bigint
#
# Indexes
#
#  index_projects_on_company_id  (company_id)
#  index_projects_on_user_id     (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (company_id => companies.id)
#  fk_rails_...  (user_id => users.id)
#

require "test_helper"

class ProjectTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
