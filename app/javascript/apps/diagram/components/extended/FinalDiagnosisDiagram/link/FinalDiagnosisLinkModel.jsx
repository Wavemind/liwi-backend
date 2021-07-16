import * as React from "react";

import AdvancedLinkModel from "../../AdvancedDiagram/link/AdvancedLinkModel";
import { NotificationManager } from "react-notifications";

export default class FinalDiagnosisLinkModel extends AdvancedLinkModel {
  constructor(options = {}) {
    super({ ...options });

    this.options.type = "finalDiagnosis";
    this.options.width = 3;
  }

  /**
   * Exclude an other final diagnosis
   */
  createLink = async () => {
    let excludedId = this.targetPort.options.nodeId;
    let excludingId = this.sourcePort.options.nodeId;
    let httpRequest = await this.http.excludeDiagnosis(excludingId, excludedId);
    let result = await httpRequest.json();

    if (httpRequest.status !== 200) {
      this.options.triggerEvent = false;
      this.remove();
      NotificationManager.error(result);
    }
  };

  /**
   * Remove link in database
   */
  removeLink = async () => {
    let httpRequest = await this.http.removeExcluding(this.sourcePort.options.nodeId, this.targetPort.options.nodeId);
    let result = await httpRequest.json();

    if (httpRequest.status !== 200) {
      this.options.triggerEvent = false;
      this.remove();
      NotificationManager.error(result);
    }
  };
}
