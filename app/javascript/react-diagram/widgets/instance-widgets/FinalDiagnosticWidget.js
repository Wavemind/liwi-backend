import * as React from "react";
import { withDiagram } from "../../../context/Diagram.context";

class FinalDiagnosticWidget extends React.Component {
  constructor(props) {
    super(props);
    this.state = {};
  }

  render() {
    const {
      diagramNode,
      type,
    } = this.props;

    let inPort = diagramNode.getInPorts()[0];
    let excludingInPort = diagramNode.getInPorts()[1];
    let outPorts = diagramNode.getOutPorts();
    let inExcluded = outPorts[0];
    let inHealthCares = outPorts[1];

    return (
      <div className="node">
        <div className="port py-2 node-category">
          {type === 'Diagnostic' ? (
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
          <div className="port inExcluded" data-name={excludingInPort.name} data-nodeid={excludingInPort.parent.id}/>
          <div className="port outExcluded" data-name={inExcluded.name} data-nodeid={inExcluded.parent.id}/>
          <div className="node-answers">
            {type === 'HealthCare' ? (
              <div key={inHealthCares.getID()} className="col px-0" style={{ position: "relative" }}>
                <div className="port out-port" data-name={inHealthCares.name} data-nodeid={inHealthCares.parent.id}/>
              </div>
            ) : null}
          </div>
        </div>
      </div>
    );
  }
}

export default withDiagram(FinalDiagnosticWidget);
