import * as React from "react";
import {withDiagram} from "../../../context/Diagram.context";

class FinalDiagnosticWidget extends React.Component {
  constructor(props) {
    super(props);
    this.state = {};
  }

  openDiagram = (dfId) => {
    const { http } = this.props;
    http.showFinalDiagnosticDiagram(dfId);
  };

  render() {
    const {
      diagramNode,
    } = this.props;

    let inPort = diagramNode.getInPorts()[0];
    let excludingInPort = diagramNode.getInPorts()[1];
    let outPorts = diagramNode.getOutPorts();
    let inExcluded = outPorts[0];

    return (
      <div className="node">
        <div className="port py-2 node-category">
          <div className="port srd-port in-port" data-name={inPort.name} data-nodeid={inPort.parent.id}/>
          <div className="col pl-2 pr-0 text-left">
            {diagramNode.node.reference}
          </div>
          <div className="col pl-0 pr-2 text-right manage-df" onClick={() => this.openDiagram(inPort.parent.node.id)}>
            <span>Manage...</span>
          </div>
        </div>
        <div>
          <div className="py-2 node-label">
            <div className="col text-center">
              {diagramNode.node.label_translations["en"]}
            </div>
          </div>
          <div className="port inExcluded" data-name={excludingInPort.name} data-nodeid={excludingInPort.parent.id}/>
          <div className="port outExcluded" data-name={inExcluded.name} data-nodeid={inExcluded.parent.id}/>
        </div>
      </div>
    );
  }
}

export default withDiagram(FinalDiagnosticWidget);
