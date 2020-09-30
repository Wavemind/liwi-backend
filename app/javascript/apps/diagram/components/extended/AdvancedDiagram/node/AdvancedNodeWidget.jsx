import * as React from "react";
import { PortWidget } from "@projectstorm/react-diagrams-core";

import { withDiagram } from "../../../../engine/context/Diagram.context";
import { getLabel } from "../../../../helpers/nodeHelpers";


class AdvancedNodeWidget extends React.Component {
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
            {getReferencePrefix(node.options.dbInstance.node.node_type, node.options.dbInstance.node.type) + node.options.dbInstance.node.reference}
          </div>
        </div>
        <div>
          <div className="py-2 node-label">
            <div className="col text-center">
              {getLabel(node.options.dbInstance.node)}
            </div>
          </div>
          <div className="node-answers">
            {node.getOutPorts().map((port, index) => (
              <div key={`div-${port.options.id}`} className="col px-0" style={{ position: "relative" }}>
                <div key={`name-${port.options.id}`} className="py-1 text-center answer-split">{port.options.name}</div>
                <PortWidget key={`port-${port.options.id}`} engine={engine} port={port} node={node} className="out-port">
                  &nbsp; {/*It need to have content in PortWidget to make a link*/}
                </PortWidget>
              </div>
            ))}
          </div>
        </div>
      </div>
    );
  }
}

export default withDiagram(AdvancedNodeWidget);
