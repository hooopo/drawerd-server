class TsvDetector
  attr_reader :text
  def initialize(text)
    @text = text
  end

  def tsv?
    return false if text.blank?
    if first_line = text.split("\n")[0]
      return true if first_line.scan("\t").size > first_line.scan(",").size
    end
  end
end