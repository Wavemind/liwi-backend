import * as React from "react";
import { BaseWidget } from "storm-react-diagrams";
import AdvancedNodeModel from "../models/AdvancedNodeModel";
import { withDiagram} from "../../context/Diagram.context";

export interface AdvancedNodeWidgetProps {
  diagramNode: AdvancedNodeModel;
  size?: number;
}

export interface AdvancedNodeWidgetState {}

/**
 * @author Jean Neige
 */
class AdvancedNodeWidget extends BaseWidget<AdvancedNodeWidgetProps, AdvancedNodeWidgetState> {
  static defaultProps: AdvancedNodeWidgetProps = {
    size: 150,
    node: null
  };

  constructor(props: AdvancedNodeWidgetProps) {
    super(props);
    this.state = {};
  }

  generateOutPort(port) {
    return (
      <div key={port.getID()} className="col px-0" style={{position: 'relative'}}>
          <div className="py-1 text-center answer-split">{port.label}</div>
          <div className="port out-port" data-name={port.name} data-nodeid={port.parent.id} />
      </div>
    );
  }

  setContextState = (id) => {
    const {set} = this.props;

    set("currentNodeId", id);
    set("modalIsOpen", true);
  };

  render() {
    const { diagramNode } = this.props;
    let outPorts = [];

    diagramNode.getOutPorts().map((outPort) => {
      outPorts.push(this.generateOutPort(outPort));
    });

    let inPort = diagramNode.getInPort();

    return (
      <div className={`node ${(diagramNode.node === 'AND') ? 'and' : ''}`}>
        <div className="port py-2 node-category">
          <div className="port srd-port in-port" data-name={inPort.name} data-nodeid={inPort.parent.id} />
          {(diagramNode.node === 'AND') ? '' : <div className="condition-container"><a href="#" onClick={() => this.setContextState(inPort.parent.node.id)} className="manage-conditions">Conds</a></div>}
          <div className="col pl-2 pr-0 text-left">
            {(diagramNode.node === 'AND') ? 'AND' : diagramNode.node.reference}
          </div>
          <div className="col pl-0 pr-2 text-right">
            {(diagramNode.node === 'AND') ? '' : diagramNode.node.priority}
          </div>
        </div>
        {(diagramNode.node === 'AND') ? (
          <div>
            <div className="node-answers">
              <div className="port srd-port" style={{top: 28, left: 8}} data-name={diagramNode.getOutPort().name} data-nodeid={diagramNode.getOutPort().parent.id} />
            </div>
          </div>
          ) : (
          <div>
            <div className="py-2 node-label">
              <div className="col text-center">
                {diagramNode.node.label_translations['en']}
              </div>
            </div>
            <div className="node-answers">
                {outPorts}
            </div>
          </div>
          )}
      </div>
    );
  }
}

export default withDiagram(AdvancedNodeWidget);
