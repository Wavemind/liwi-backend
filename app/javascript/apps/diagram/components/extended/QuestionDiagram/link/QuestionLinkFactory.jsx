import * as React from "react";
import AdvancedLinkFactory from "../../AdvancedDiagram/link/AdvancedLinkFactory";

import QuestionLinkModel from "./QuestionLinkModel";
import AdvancedLinkWidget from "../../AdvancedDiagram/link/AdvancedLinkWidget";

export default class QuestionLinkFactory extends AdvancedLinkFactory {
  constructor() {
    super('question');
  }

  generateModel(event) {
    return new QuestionLinkModel();
  }

  generateReactWidget(event) {
    return <AdvancedLinkWidget link={event.model} diagramEngine={this.engine} />;
  }
}
