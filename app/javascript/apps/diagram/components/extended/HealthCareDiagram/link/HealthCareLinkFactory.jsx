import * as React from "react";
import { DefaultLinkFactory } from "@projectstorm/react-diagrams";

import HealthCareLinkModel from "./HealthCareLinkModel";
import AdvancedLinkWidget from "../../AdvancedDiagram/link/AdvancedLinkWidget";

export default class HealthCareLinkFactory extends DefaultLinkFactory {
  constructor() {
    super('healthCare');
  }

  generateModel(event) {
    return new HealthCareLinkModel();
  }

  generateReactWidget(event) {
    return <AdvancedLinkWidget link={event.model} diagramEngine={this.engine} />;
  }
}
