import * as React from "react";
import {withDiagram} from "../../../context/Diagram.context";

class NotDFWidget extends React.Component {
  constructor(props) {
    super(props);
    this.state = {};
  }

  // Generate out ports for regular node
  generateOutPort(port) {
    return (
      <div key={port.getID()} className="col px-0" style={{ position: "relative" }}>
        <div className="py-1 text-center answer-split">{port.label}</div>
        <div className="port out-port" data-name={port.name} data-nodeid={port.parent.id}/>
      </div>
    );
  }

  // Open final diagnostic diagram
  openDiagram = (nodeId) => {
    const { http } = this.props;
    http.showQuestionsSequenceDiagram(nodeId);
  };

  editNode = (node) => {
    node.setSelected(false);

    const { set } = this.props;
    set(
      ['modalToOpen', 'currentNode', 'currentDiagramNode', 'modalIsOpen'],
      ['Update' + node.node.node_type, node.node, node, true]
    );
  };

  render() {
    const {
      diagramNode,
      getReferencePrefix
    } = this.props;

    let outPorts = [];
    let inPort = diagramNode.getInPorts()[0];

    diagramNode.getOutPorts().map((outPort) => {
      outPorts.push(this.generateOutPort(outPort));
    });

    return (
      <div className="node">
        <div className="port py-2 node-category">
          {(inPort !== undefined) ? (
            <div className="port srd-port in-port" data-name={inPort.name} data-nodeid={inPort.parent.id}/>
          ) : null}
          <div className="col pl-2 pr-0 text-left">
            {getReferencePrefix(diagramNode.node.node_type, diagramNode.node.type) + diagramNode.node.reference}
          </div>
          <div className="col pl-0 pr-2 text-center">
            {(diagramNode.node.category_name === 'scored') ? diagramNode.node.min_score : diagramNode.node.priority}
          </div>
          <div className="col pl-0 pr-2 text-right">
            {(diagramNode.node.is_default === false) ? (
              <div className="dropdown">
                <button className="btn btn-secondary dropdown-toggle" type="button" id="dropdownMenuButton" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                </button>
                <div className="dropdown-menu" aria-labelledby="dropdownMenuButton">
                  {(diagramNode.node.node_type === "QuestionsSequence") ? (<a className="dropdown-item" href="#" onClick={() => this.openDiagram(diagramNode.node.id)}>Open diagram</a>) : null}
                  <a className="dropdown-item" href="#" onClick={() => this.editNode(diagramNode)}>Edit</a>
                </div>
              </div>
            ) : null}
          </div>
        </div>
        <div>
          <div className="py-2 node-label">
            <div className="col text-center">
              {diagramNode.node.label_translations["en"]}
            </div>
          </div>
          <div className="node-answers">
            {outPorts}
          </div>
        </div>
      </div>
    );
  }
}

export default withDiagram(NotDFWidget);
