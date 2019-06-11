import * as React from "react";
import {withDiagram} from "../../../context/Diagram.context";
import Alert from "../../../components/utils/FlashMessages";

class FinalDiagnosticWidget extends React.Component {
  constructor(props) {
    super(props);
    this.state = {};
  }

  // Open final diagnostic diagram
  openDiagram = (dfId) => {
    const { http } = this.props;
    http.showFinalDiagnosticDiagram(dfId);
  };

  // Open modal to edit final diagnostic
  editFinalDiagnostic = (diagramNode) => {
    diagramNode.setSelected(false);

    const { set } = this.props;
    set('modalToOpen', 'UpdateFinalDiagnostic');
    set('currentNode', diagramNode.node);
    set('currentDiagramNode', diagramNode);
    set('modalIsOpen', true);
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
          <div className="col pl-0 pr-2 text-right">
            <div className="dropdown">
              <button className="btn btn-secondary dropdown-toggle" type="button" id="dropdownMenuButton"
                      data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
              </button>
              <div className="dropdown-menu" aria-labelledby="dropdownMenuButton">
                <a className="dropdown-item" href="#" onClick={() => this.openDiagram(inPort.parent.node.id)}>Open diagramc</a>
                <a className="dropdown-item" href="#" onClick={() => this.editFinalDiagnostic(inPort.parent)}>Edit</a>
              </div>
            </div>
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
