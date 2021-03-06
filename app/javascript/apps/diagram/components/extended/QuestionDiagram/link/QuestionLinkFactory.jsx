import * as React from "react";
import { DefaultLinkFactory } from "@projectstorm/react-diagrams";

import QuestionLinkModel from "./QuestionLinkModel";
import AdvancedLinkWidget from "../../AdvancedDiagram/link/AdvancedLinkWidget";

export default class QuestionLinkFactory extends DefaultLinkFactory {
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
