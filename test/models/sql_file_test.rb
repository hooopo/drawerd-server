# == Schema Information
#
# Table name: sql_files
#
#  id         :bigint           not null, primary key
#  body       :text
#  filename   :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  project_id :bigint
#  user_id    :bigint
#
# Indexes
#
#  index_sql_files_on_project_id  (project_id)
#  index_sql_files_on_user_id     (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (project_id => projects.id)
#  fk_rails_...  (user_id => users.id)
#

require 'test_helper'

class SqlFileTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
