import * as React from "react";
import { BaseWidget } from "storm-react-diagrams";
import AdvancedNodeModel from "../models/AdvancedNodeModel";

import FinalDiagnosticWidget from "./instance-widgets/FinalDiagnosticWidget";
import NotDFWidget from "./instance-widgets/NotDFWidget";
import AndWidget from "./instance-widgets/AndWidget";


export interface AdvancedNodeWidgetProps {
  diagramNode: AdvancedNodeModel;
  size?: number;
}

export interface AdvancedNodeWidgetState {
}

/**
 * @author Quentin Girard
 * Generate node by type
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

  render() {
    const { diagramNode } = this.props;

    const type = diagramNode.node.node_type;

    if (type === "FinalDiagnostic") {
      return <FinalDiagnosticWidget diagramNode={diagramNode}/>;
    } else if (type === "Management" || type === "Treatment" || type === "QuestionsSequence" || type === "Question") {
      return <NotDFWidget diagramNode={diagramNode}/>;
    } else {
      return <AndWidget diagramNode={diagramNode}/>;
    }
  }
}

export default AdvancedNodeWidget;
