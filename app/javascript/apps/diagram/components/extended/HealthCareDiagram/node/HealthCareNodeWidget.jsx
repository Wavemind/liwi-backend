import * as React from "react";
import { PortWidget } from "@projectstorm/react-diagrams-core";

import { withDiagram } from "../../../../engine/context/Diagram.context";
import { getLabel } from "../../../../helpers/nodeHelpers";


class HealthCareNodeWidget extends React.Component {
  constructor(props) {
    super(props);
    this.state = {};
  }

  render() {
    const { getReferencePrefix, node, engine } = this.props;

    return (
      <div className="node">
        <div className="port py-2 node-category">
          <div className="port srd-port in-port">
            <PortWidget engine={engine} port={node.getInPort()}>
              &nbsp; {/*It need to have content in PortWidget to make a link*/}
            </PortWidget>
          </div>
          <div className="col pl-2 pr-0 text-left">
            {getReferencePrefix(node.dbInstance.node.node_type, node.dbInstance.node.type) + node.dbInstance.node.reference}
          </div>
          <div className="col pl-0 pr-2 text-right">
            {/*{(node.dbInstance.node.is_default === false) ? (*/}
            {/*  <div className="dropdown">*/}
            {/*    <button className="btn btn-secondary dropdown-toggle" type="button" id="dropdownMenuButton"*/}
            {/*            data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">*/}
            {/*    </button>*/}
            {/*    <div className="dropdown-menu" aria-labelledby="dropdownMenuButton">*/}
            {/*      {(node.dbInstance.node.node_type === "QuestionsSequence") ? (<a className="dropdown-item" href="#" onClick={() => this.openDiagram(node.dbInstance.node.id)}>Open diagram</a>) : null}*/}
            {/*      <a className="dropdown-item" href="#" onClick={() => this.editNode(node)}>Edit</a>*/}
            {/*    </div>*/}
            {/*  </div>*/}
            {/*) : null}*/}
          </div>
        </div>
        <div>
          <div className="py-2 node-label">
            <div className="col text-center">
              {getLabel(node.dbInstance.node)}
            </div>
          </div>
        </div>
      </div>
    );
  }
}

export default withDiagram(HealthCareNodeWidget);
