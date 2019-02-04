# Intermediary table between algorithm version and diagnostic
class EnabledDiagnostic < ApplicationRecord

  belongs_to :diagnostic
  belongs_to :algorithm_version

end
