import * as React from "react";
import { DefaultLinkFactory } from "@projectstorm/react-diagrams";

import AdvancedLinkModel from "./AdvancedLinkModel";
import AdvancedLinkWidget from "./AdvancedLinkWidget";

export default class AdvancedLinkFactory extends DefaultLinkFactory {
  constructor() {
    super('advanced');
  }

  generateModel(event) {
    return new AdvancedLinkModel();
  }

  generateReactWidget(event) {
    console.log("ici")
    return <AdvancedLinkWidget link={event.model} diagramEngine={this.engine} />;
  }
}
