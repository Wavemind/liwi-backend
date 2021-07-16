import * as React from "react";
import * as _ from "lodash";

import AdvancedPortModel from "../../AdvancedDiagram/port/AdvancedPortModel";
import FinalDiagnosisLinkModel from "../link/FinalDiagnosisLinkModel";

export default class FinalDiagnosisPortModel extends AdvancedPortModel {
  constructor(options = {}) {
    super({
      ...options
    });
    this.options.type = "finalDiagnosis";
  }

  createLinkModel() {
    return new FinalDiagnosisLinkModel();
  }

  canLinkToPort(port) {
    let valueReturned = port.options.type !== "advanced" && this.options.id !== port.options.id && this.linkIsAvailable(port);

    if (!valueReturned) {
      _.find(this.getLinks(), link => {
        return link.targetPort === null;
      }).remove();
    }

    return valueReturned;
  }
}
