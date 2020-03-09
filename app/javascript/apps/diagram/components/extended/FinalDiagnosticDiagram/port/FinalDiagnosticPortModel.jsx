import * as React from "react";

import AdvancedPortModel from "../../AdvancedDiagram/port/AdvancedPortModel";
import FinalDiagnosticLinkModel from "../link/FinalDiagnosticLinkModel";

export default class FinalDiagnosticPortModel extends AdvancedPortModel {
  constructor(options = {}) {
    super({
      ...options,
    });
  }

  createLinkModel() {
    return new FinalDiagnosticLinkModel();
  }

  canLinkToPort(port) {
    console.info('finalDiagnostic - canLinkToPort', { from: this, to: port });
    console.log(this.options.id === port.options.id);
    return port.constructor.name !== 'AdvancedPortModel' && this.options.id !== port.options.id;
  }
}
