import * as React from "react";

import AdvancedLinkModel from "../../AdvancedDiagram/link/AdvancedLinkModel";
import { NotificationManager } from "react-notifications";

export default class FinalDiagnosticLinkModel extends AdvancedLinkModel {

  /**
   * Exclude an other final diagnostic
   */
  createLink() {
    let excludedId = this.targetPort.options.nodeId;
    let excludingId = this.sourcePort.options.nodeId;

    this.http.excludeDiagnostic(excludingId, excludedId).then(httpRequest => {
      httpRequest.json().then(result => {
        if (httpRequest.status !== 200) {
          this.triggerEvent = false;
          this.remove();
          NotificationManager.error(result);
        }
      });
    });
  }

  /**
   * Remove link in database
   */
  removeLink() {
    this.http.removeExcluding(this.sourcePort.options.nodeId).then(httpRequest => {
      httpRequest.json().then(result => {
        if (httpRequest.status !== 200) {
          this.triggerEvent = false;
          this.remove();
          NotificationManager.error(result);
        }
      });
    });
  }
}
