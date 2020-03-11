import * as React from "react";

import AdvancedPortModel from "../../AdvancedDiagram/port/AdvancedPortModel";
import FinalDiagnosticLinkModel from "../link/FinalDiagnosticLinkModel";

export default class FinalDiagnosticPortModel extends AdvancedPortModel {
  constructor(options = {}) {
    super({
      ...options,
    });
    this.options.type = 'finalDiagnostic';
  }

  createLinkModel() {
    return new FinalDiagnosticLinkModel();
  }

  canLinkToPort(port) {
    let valueReturned = port.options.type !== 'advanced' && this.options.id !== port.options.id && this.linkIsAvailable(port);

    if (!valueReturned) {
      _.find(this.getLinks(), (link) => {return link.targetPort === null}).remove();
    }

    return valueReturned;
  }
}
