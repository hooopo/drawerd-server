# frozen_string_literal: true

class SqlExporter
  attr_reader :project

  def initialize(project)
    @project = project
  end

  def self.template
    <<~ERB
      <% tables.each do |table| %>
      Table <%= table.name %> {
        <% table.columns.order("id asc").each do |column| %>
          <%= column.name  %> <%= column.column_type %> <%= column.to_dbml_option %>
        <% end %>
        <%= table.to_dbml_option %>
      }
      <% end %>
      <% relationships.each do |r| %>
        <%= r.to_dbml_ref if project.export_foreign_key? %>
      <% end %>
    ERB
  end

  def tables
    project.tables.order("id asc")
  end

  def relationships
    project.relationships
  end

  def dbml
    @dbml ||= ERB.new(self.class.template).result(binding)
  end

  def dbml_file
    tmp = Tempfile.new
    tmp.write dbml
    tmp.close
    tmp.path
  end

  def ddl
    `dbml2sql #{dbml_file} --#{project.adapter}`
  end

  def ddl_file
    file_path = Rails.root.join("tmp/#{project.id}.sql")
    `dbml2sql #{dbml_file} --#{project.adapter} > #{file_path}`
    file_path.to_s
  end
end
