import * as React from 'react';

import AdvancedNodeFactory from "../../AdvancedDiagram/node/AdvancedNodeFactory";
import QuestionNodeModel from './QuestionNodeModel';
import QuestionNodeWidget from './QuestionNodeWidget';

export default class QuestionNodeFactory extends AdvancedNodeFactory {
  constructor() {
    super('question');
  }

  generateModel(initialConfig) {
    return new QuestionNodeModel();
  }

  generateReactWidget(event) {
    return <QuestionNodeWidget engine={this.engine} node={event.model} />;
  }
}
