import * as React from "react";
import { BaseWidget } from "storm-react-diagrams";
import AdvancedNodeModel from "../models/AdvancedNodeModel";

import FinalDiagnosticWidget from "./instance-widgets/FinalDiagnosticWidget";
import NotDFWidget from "./instance-widgets/NotDFWidget";
import AndWidget from "./instance-widgets/AndWidget";



/**
 * @author Quentin Girard
 * Generate node by type
 */
class AdvancedNodeWidget extends BaseWidget {
  static defaultProps = {
    size: 150,
    node: null
  };

  constructor(props) {
    super(props);
    this.state = {};
  }

  render() {
    const { diagramNode } = this.props;

    const type = diagramNode.node.type;

    if (type === "FinalDiagnostic") {
      return <FinalDiagnosticWidget diagramNode={diagramNode}/>;
    } else if (type === "Management" || type === "Treatment" || type === "PredefinedSyndrome" || type === "Question") {
      return <NotDFWidget diagramNode={diagramNode}/>;
    } else {
      return <AndWidget diagramNode={diagramNode}/>;
    }
  }
}

export default AdvancedNodeWidget;
