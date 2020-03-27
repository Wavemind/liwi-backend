import * as React from "react";
import { DefaultLinkFactory } from "@projectstorm/react-diagrams";

import QuestionsSequenceLinkModel from "./QuestionsSequenceLinkModel";
import AdvancedLinkWidget from "../../AdvancedDiagram/link/AdvancedLinkWidget";

export default class QuestionsSequenceLinkFactory extends DefaultLinkFactory {
  constructor() {
    super('questionsSequence');
  }

  generateModel(event) {
    return new QuestionsSequenceLinkModel();
  }

  generateReactWidget(event) {
    return <AdvancedLinkWidget link={event.model} diagramEngine={this.engine} />;
  }
}
