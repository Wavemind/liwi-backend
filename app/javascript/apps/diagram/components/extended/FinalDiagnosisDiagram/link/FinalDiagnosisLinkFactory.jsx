import * as React from "react";
import { DefaultLinkFactory } from "@projectstorm/react-diagrams";

import FinalDiagnosisLinkModel from "./FinalDiagnosisLinkModel";
import FinalDiagnosisLinkWidget from "./FinalDiagnosisLinkWidget";

export default class FinalDiagnosisLinkFactory extends DefaultLinkFactory {
  constructor() {
    super('finalDiagnosis');
  }

  generateModel(event) {
    return new FinalDiagnosisLinkModel();
  }

  generateReactWidget(event) {
    return <FinalDiagnosisLinkWidget link={event.model} diagramEngine={this.engine} />;
  }
}
