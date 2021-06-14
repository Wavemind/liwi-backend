import * as React from "react";
import * as _ from "lodash";
import { DefaultPortModel } from "@projectstorm/react-diagrams";
import I18n from 'i18n-js';

import AdvancedLinkModel from "../link/AdvancedLinkModel";
import { NotificationManager } from "react-notifications";

export default class AdvancedPortModel extends DefaultPortModel {
  constructor(options = {}) {
    super({ ...options });

    this.options.type = "advanced";
  }

  createLinkModel() {
    return new AdvancedLinkModel();
  }

  canLinkToPort(port) {
    let valueReturned = port.options.type !== "finalDiagnosis" && this.linkIsAvailable(port);

    // Remove link if valueReturned is false
    if (!valueReturned) {
      _.find(this.getLinks(), (link) => {
        return link.targetPort === null;
      }).remove();
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
      NotificationManager.error(I18n.t("conditions.validation.link_already_exist"));
    }

    return !valueReturned;
  }

}
