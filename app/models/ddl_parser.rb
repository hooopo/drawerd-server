class DdlParser

  attr_reader :ddl
  def initialize(ddl)
    @ddl = ddl
  end

  def tables
    []
  end

  def refs
    []
  end
end