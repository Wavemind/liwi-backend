import * as React from "react";
import { withDiagram } from "../../../engine/context/Diagram.context";

class Item extends React.Component {

  render() {
    const { node, getReferencePrefix } = this.props;

    return (
      <div className="p-2"
           draggable={true}
           id={`node-${node.id}`}
           onDragStart={event => {
             event.dataTransfer.setData("node", JSON.stringify(node));
           }}
      >
        <div className="mx-1 node">
          <div className="port py-2 node-category">
            <div className="col pl-2 pr-0 text-left">
              {getReferencePrefix(node.node_type, node.type) + node.reference}
            </div>
            <div className="col pl-0 pr-2 text-right">
              {node.is_mandatory ? "Mandatory" : "Optional"}
            </div>
          </div>
          <div className="py-2 node-label">
            <div className="col text-center">
              {node.label_translations["en"]}
            </div>
          </div>
        </div>
      </div>
    );
  }
}

export default withDiagram(Item);


