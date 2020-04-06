# TODO
class NodeComplaintCategory < ApplicationRecord

  # TODO: MANU CHECK
  belongs_to :node, optional: true
  belongs_to :complaint_category, class_name: 'Node', foreign_key: 'complaint_category_id'

end
