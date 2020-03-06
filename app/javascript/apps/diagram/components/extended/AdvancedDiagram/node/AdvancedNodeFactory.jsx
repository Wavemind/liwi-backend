import * as React from 'react';
import { AbstractReactFactory } from '@projectstorm/react-canvas-core';

import AdvancedNodeModel from './AdvancedNodeModel';
import AdvancedNodeWidget from './AdvancedNodeWidget';

export default class AdvancedNodeFactory extends AbstractReactFactory {
  constructor() {
    super('advanced');
  }

  generateModel(initialConfig) {
    return new AdvancedNodeModel();
  }

  generateReactWidget(event) {
    return <AdvancedNodeWidget engine={this.engine} node={event.model} />;
  }
}
