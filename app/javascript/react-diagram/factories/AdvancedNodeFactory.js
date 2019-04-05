import { DiagramEngine, DefaultNodeFactory } from "storm-react-diagrams";
import AdvancedNodeWidget from "../widgets/AdvancedNodeWidget";
import AdvancedNodeModel from "../models/AdvancedNodeModel";
import * as React from "react";

class AdvancedNodeFactory extends DefaultNodeFactory {
  constructor() {
    super("advanced");
  }

  generateReactWidget(diagramEngine: DiagramEngine, node: AdvancedNodeModel): JSX.Element {
    return <AdvancedNodeWidget node={node} />;
  }

  getNewInstance() {
    return new AdvancedNodeModel();
  }
}

export default AdvancedNodeFactory;
