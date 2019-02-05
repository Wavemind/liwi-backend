# health cares for a final diagnostic
class FinalDiagnosticHealthCare < ApplicationRecord

  belongs_to :treatable, polymorphic: true
  belongs_to :final_diagnostic

end
