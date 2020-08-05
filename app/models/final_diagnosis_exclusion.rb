# Exclusion between final diagnosis
class FinalDiagnosisExclusion < ApplicationRecord

  belongs_to :excluding_diagnosis, class_name: 'FinalDiagnostic'
  belongs_to :excluded_diagnosis, class_name: 'FinalDiagnostic'



end
