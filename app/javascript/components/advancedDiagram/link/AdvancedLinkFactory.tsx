import * as React from "react";
import { DefaultLinkFactory } from "@projectstorm/react-diagrams";

import AdvancedLinkModel from "./AdvancedLinkModel";
import AdvancedLinkWidget from "./AdvancedLinkWidget";

export default class AdvancedLinkFactory extends DefaultLinkFactory {
  constructor() {
    super('advanced');
  }

  generateModel(): AdvancedLinkModel {
    return new AdvancedLinkModel();
  }

  generateReactWidget(event): JSX.Element {
    return <AdvancedLinkWidget link={event.model} diagramEngine={this.engine} />;
  }
}
