import * as React from "react";
import { DefaultPortModel } from "@projectstorm/react-diagrams";

import AdvancedLinkModel from "../link/AdvancedLinkModel";

export default class AdvancedPortModel extends DefaultPortModel {
  constructor(options = {}) {
    super({
      ...options,
      type: 'advanced'
    });
  }

  createLinkModel() {
    return new AdvancedLinkModel();
  }

  canLinkToPort(port) {
    return port.constructor.name !== 'FinalDiagnosticPortModel';
  }
}
