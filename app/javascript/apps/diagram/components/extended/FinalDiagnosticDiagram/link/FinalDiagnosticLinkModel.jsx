import * as React from "react";

import AdvancedLinkModel from "../../AdvancedDiagram/link/AdvancedLinkModel";
import { NotificationManager } from "react-notifications";

export default class FinalDiagnosticLinkModel extends AdvancedLinkModel {

  /**
   * Create link in database and assign value
   */
  createLink() {
    console.log("createLink ")
    // let instanceId = this.targetPort.options.id;
    // let answerId = this.sourcePort.options.id;
    //
    // this.http.createLink(instanceId, answerId).then(httpRequest => {
    //   httpRequest.json().then(result => {
    //     if (httpRequest.status === 200) {
    //       this.dbConditionId = result.id;
    //       this.parentInstanceId = this.sourcePort.parent.options.dbInstance.id;
    //     } else {
    //       this.triggerEvent = false;
    //       this.remove();
    //       NotificationManager.error(result);
    //     }
    //   });
    // });
  }

  /**
   * Remove link in database
   */
  removeLink() {
    console.log("removeLink ")
    // this.http.removeLink(this.parentInstanceId, this.dbConditionId).then(httpRequest => {
    //   httpRequest.json().then(result => {
    //     if (httpRequest.status !== 200) {
    //       this.triggerEvent = false;
    //       this.remove();
    //       NotificationManager.error(result);
    //     }
    //   });
    // });
  }
}
