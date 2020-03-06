import * as React from 'react';

import AdvancedNodeFactory from "../../AdvancedDiagram/node/AdvancedNodeFactory";
import FinalDiagnosticNodeModel from './FinalDiagnosticNodeModel';
import FinalDiagnosticNodeWidget from './FinalDiagnosticNodeWidget';

export default class FinalDiagnosticNodeFactory extends AdvancedNodeFactory {
  constructor() {
    super('finalDiagnostic');
  }

  generateModel(initialConfig) {
    return new FinalDiagnosticNodeModel();
  }

  generateReactWidget(event) {
    return <FinalDiagnosticNodeWidget engine={this.engine} node={event.model} />;
  }
}
