import * as React from "react";
import AdvancedLinkFactory from "../../AdvancedDiagram/link/AdvancedLinkFactory";

import FinalDiagnosticLinkModel from "./FinalDiagnosticLinkModel";
import AdvancedLinkWidget from "../../AdvancedDiagram/link/AdvancedLinkWidget";

export default class FinalDiagnosticLinkFactory extends AdvancedLinkFactory {
  constructor() {
    super('finalDiagnostic');
  }

  generateModel(event) {
    return new FinalDiagnosticLinkModel();
  }

  generateReactWidget(event) {
    return <AdvancedLinkWidget link={event.model} diagramEngine={this.engine} />;
  }
}
