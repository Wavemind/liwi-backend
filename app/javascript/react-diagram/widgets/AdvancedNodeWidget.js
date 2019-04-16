import * as React from "react";
import { BaseWidget } from "storm-react-diagrams";
import AdvancedNodeModel from "../models/AdvancedNodeModel";

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
      <div key={port.getID()} className="col px-0">
        <div className="port py-1 text-center answer-split" data-name={port.name} data-nodeid={port.parent.id}>{port.label}</div>
      </div>
    );
  }

  render() {
    const { diagramNode } = this.props;
    let outPorts = [];

    diagramNode.getOutPorts().map((outPort) => {
      outPorts.push(this.generateOutPort(outPort));
    });

    let inPort = diagramNode.getInPort();

    return (
      <div className="node">
        <div className="port py-2 node-category">
          <div className="port srd-port" data-name={inPort.name} data-nodeid={inPort.parent.id}></div>
          <div className="col pl-2 pr-0 text-left">
            {(diagramNode.node === 'AND') ? 'AND' : diagramNode.node.reference}
          </div>
          <div className="col pl-0 pr-2 text-right">
            {(diagramNode.node === 'AND') ? null : diagramNode.node.priority}
          </div>
        </div>
        {(diagramNode.node === 'AND') ? null : (
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

export default AdvancedNodeWidget;
