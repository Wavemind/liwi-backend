import * as React from "react";
import { DefaultLinkFactory } from "@projectstorm/react-diagrams";

import FinalDiagnosticLinkModel from "./FinalDiagnosticLinkModel";
import FinalDiagnosticLinkWidget from "./FinalDiagnosticLinkWidget";

export default class FinalDiagnosticLinkFactory extends DefaultLinkFactory {
  constructor() {
    super('finalDiagnostic');
  }

  generateModel(event) {
    return new FinalDiagnosticLinkModel();
  }

  generateReactWidget(event) {
    return <FinalDiagnosticLinkWidget link={event.model} diagramEngine={this.engine} />;
  }
}
