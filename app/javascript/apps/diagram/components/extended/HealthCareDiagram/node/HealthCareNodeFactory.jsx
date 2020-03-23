import * as React from 'react';
import { AbstractReactFactory } from "@projectstorm/react-canvas-core";

import HealthCareNodeModel from './HealthCareNodeModel';
import HealthCareNodeWidget from './HealthCareNodeWidget';

export default class HealthCareNodeFactory extends AbstractReactFactory {
  constructor() {
    super('healthCare');
  }

  generateModel(initialConfig) {
    return new HealthCareNodeModel();
  }

  generateReactWidget(event) {
    return <HealthCareNodeWidget engine={this.engine} node={event.model} />;
  }
}
