import * as React from "react";
import { DefaultPortModel } from "@projectstorm/react-diagrams";

import AdvancedLinkModel from "../link/AdvancedLinkModel";
import { NotificationManager } from "react-notifications";

export default class AdvancedPortModel extends DefaultPortModel {
  constructor(options = {}) {
    super({
      ...options,
    });
    this.options.type = 'advanced';
  }

  createLinkModel() {
    return new AdvancedLinkModel();
  }

  canLinkToPort(port) {
    let valueReturned = this.options.type !== 'finalDiagnostic' && this.linkIsAvailable(port);

    // Remove link if valueReturned is false
    if (!valueReturned) {
      _.find(this.getLinks(), (link) => {return link.targetPort === null}).remove();
    }

    return valueReturned;
  }

  /**
   * Check if a link already exist between these 2 port
   * @params [Object] targetPort
   * @return boolean given result
   */
  linkIsAvailable(targetPort) {
    let valueReturned = _.some(this.getLinks(), (link) => link.targetPort?.options.id === targetPort.options.id);

    // Display error messages if link already exist
    if (valueReturned) {
      NotificationManager.error("Link already exist");
    }

    return !valueReturned;
  }

}
