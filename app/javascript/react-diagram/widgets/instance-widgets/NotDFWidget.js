import * as React from "react";

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

  render() {
    const { diagramNode } = this.props;
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
            {diagramNode.node.reference}
          </div>
          <div className="col pl-0 pr-2 text-right">
            {diagramNode.node.priority}
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

export default NotDFWidget;
