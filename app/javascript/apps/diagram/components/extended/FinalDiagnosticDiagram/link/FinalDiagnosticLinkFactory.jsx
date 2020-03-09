import * as React from "react";
import { DefaultLinkFactory } from "@projectstorm/react-diagrams";

import FinalDiagnosticLinkModel from "./FinalDiagnosticLinkModel";
import AdvancedLinkWidget from "../../AdvancedDiagram/link/AdvancedLinkWidget";

export default class FinalDiagnosticLinkFactory extends DefaultLinkFactory {
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
