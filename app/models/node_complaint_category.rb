# health cares for a final diagnostic
class NodeComplaintCategory < ApplicationRecord

  belongs_to :node
  belongs_to :complaint_categories, class_name: 'Node', foreign_key: 'complaint_category_id'

end
