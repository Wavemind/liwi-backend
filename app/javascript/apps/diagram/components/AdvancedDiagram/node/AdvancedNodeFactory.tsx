import * as React from 'react';
import { AbstractReactFactory } from '@projectstorm/react-canvas-core';
import { DiagramEngine } from '@projectstorm/react-diagrams-core';

import AdvancedNodeModel from './AdvancedNodeModel';
import AdvancedNodeWidget from './AdvancedNodeWidget';

export default class AdvancedNodeFactory extends AbstractReactFactory<AdvancedNodeModel, DiagramEngine> {
  constructor() {
    super('advanced');
  }

  generateModel(initialConfig) {
    return new AdvancedNodeModel();
  }

  generateReactWidget(event): JSX.Element {
    return <AdvancedNodeWidget engine={this.engine as DiagramEngine} node={event.model} />;
  }
}
