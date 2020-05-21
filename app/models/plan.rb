# frozen_string_literal: true

class Plan
  PRO_ID = 593774
  ENTERPRISE_ID = 593761

  TYPES = Hash.new(:free).merge(
    PRO_ID => :pro,
    ENTERPRISE_ID => :enterprise
  )
end
