import * as React from 'react';
import { AbstractReactFactory } from "@projectstorm/react-canvas-core";

import FinalDiagnosisNodeModel from './FinalDiagnosisNodeModel';
import FinalDiagnosisNodeWidget from './FinalDiagnosisNodeWidget';

export default class FinalDiagnosisNodeFactory extends AbstractReactFactory {
  constructor() {
    super('finalDiagnosis');
  }

  generateModel(initialConfig) {
    return new FinalDiagnosisNodeModel();
  }

  generateReactWidget(event) {
    return <FinalDiagnosisNodeWidget engine={this.engine} node={event.model} />;
  }
}
