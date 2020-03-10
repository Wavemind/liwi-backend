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
    let valueReturned = port.constructor.name !== 'AdvancedPortModel' && this.options.id !== port.options.id && this.linkIsAvailable(port);

    if (!valueReturned) {
      _.find(this.getLinks(), (link) => {return link.targetPort === null}).remove();
    }

    return valueReturned;
  }
}
