import * as React from 'react';
import { AbstractReactFactory } from "@projectstorm/react-canvas-core";

import FinalDiagnosticNodeModel from './FinalDiagnosticNodeModel';
import FinalDiagnosticNodeWidget from './FinalDiagnosticNodeWidget';

export default class FinalDiagnosticNodeFactory extends AbstractReactFactory {
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
