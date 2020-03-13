import * as React from 'react';
import { AbstractReactFactory } from "@projectstorm/react-canvas-core";

import QuestionsSequenceNodeModel from './QuestionsSequenceNodeModel';
import QuestionsSequenceNodeWidget from './QuestionsSequenceNodeWidget';

export default class QuestionsSequenceNodeFactory extends AbstractReactFactory {
  constructor() {
    super('questionsSequence');
  }

  generateModel(initialConfig) {
    return new QuestionsSequenceNodeModel();
  }

  generateReactWidget(event) {
    return <QuestionsSequenceNodeWidget engine={this.engine} node={event.model} />;
  }
}
