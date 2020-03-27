import * as React from "react";

import AdvancedPortModel from "../../AdvancedDiagram/port/AdvancedPortModel";
import HealthCareLinkModel from "../link/HealthCareLinkModel";

export default class HealthCarePortModel extends AdvancedPortModel {
  createLinkModel() {
    return new HealthCareLinkModel();
  }
}
