import * as React from 'react';
import QuestionsSequenceScoreLabelModel from './QuestionsSequenceScoreLabelModel';
import QuestionsSequenceScoreLabelWidget from './QuestionsSequenceScoreLabelWidget';
import { DefaultLabelFactory } from "@projectstorm/react-diagrams-defaults";


export default class QuestionsSequenceScoreLabelFactory extends DefaultLabelFactory {
  constructor() {
    super('questionsSequenceScore');
  }

  generateReactWidget(event) {
    return <QuestionsSequenceScoreLabelWidget model={event.model} />;
  }

  generateModel(event) {
    return new QuestionsSequenceScoreLabelModel();
  }
}
