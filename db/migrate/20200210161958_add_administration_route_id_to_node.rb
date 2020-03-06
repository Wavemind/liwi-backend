class AddAdministrationRouteIdToNode < ActiveRecord::Migration[5.2]
  def change
    add_reference :nodes, :administration_route, column: :administration_route_id, foreign_key: true
  end
end
