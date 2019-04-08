import * as React from "react";
import { BaseWidget } from "storm-react-diagrams";
import AdvancedNodeModel from "../models/AdvancedNodeModel";

export interface AdvancedNodeWidgetProps {
  node: AdvancedNodeModel;
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

  generatePort(output, port) {
    let displayedPort = <div className="port srd-port" data-name={port.name} data-nodeid={port.parent.id}>{output === 'out' ? '+' : ''}</div>;
    let displayedLabel = <div className="name">{port.label}</div>;

    return (
      <div className={`srd-default-port srd-default-port--${output}`} key={port.getID()}>
        {displayedLabel}
        {displayedPort}
      </div>
    );
  }

  render() {
    return (
      <div className={"srd-default-node"} style={{ background: this.props.node.color }}>
        <div className={"srd-default-node__title"}>
          <div className={"srd-default-node__name"}>{this.props.node.name}</div>
        </div>
        <div className={"srd-default-node__ports"}>
          <div className={"srd-default-node__in"}>
            {_.map(this.props.node.getInPorts(), this.generatePort.bind(this, 'in'))}
          </div>
          <div className={"srd-default-node__out"}>
            {_.map(this.props.node.getOutPorts(), this.generatePort.bind(this, 'out'))}
          </div>
        </div>
      </div>
    );
  }
}

export default AdvancedNodeWidget;
