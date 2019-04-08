import * as React from "react";
import { DefaultPortLabel, BaseWidget } from "storm-react-diagrams";
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

  generatePort(port) {
    return <DefaultPortLabel model={port} key={port.id} />;
  }

  render() {
    return (
      <div className={"srd-default-node"} style={{ background: this.props.node.color }}>
        <div className={"srd-default-node__title"}>
          <div className={"srd-default-node__name"}>{this.props.node.name}</div>
        </div>
        <div className={"srd-default-node__ports"}>
          <div className={"srd-default-node__in"}>
            {_.map(this.props.node.getInPorts(), this.generatePort.bind(this))}
          </div>
          <div className={"srd-default-node__out"}>
            {_.map(this.props.node.getOutPorts(), this.generatePort.bind(this))}
          </div>
        </div>
      </div>
    );
  }
}

export default AdvancedNodeWidget;
