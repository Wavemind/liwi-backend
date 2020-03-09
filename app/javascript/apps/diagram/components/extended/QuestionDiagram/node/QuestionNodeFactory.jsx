import * as React from 'react';
import { AbstractReactFactory } from "@projectstorm/react-canvas-core";

import QuestionNodeModel from './QuestionNodeModel';
import QuestionNodeWidget from './QuestionNodeWidget';

export default class QuestionNodeFactory extends AbstractReactFactory {
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
