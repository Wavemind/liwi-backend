import * as React from "react";

import AdvancedPortModel from "../../AdvancedDiagram/port/AdvancedPortModel";
import FinalDiagnosticLinkModel from "../link/FinalDiagnosticLinkModel";

export default class FinalDiagnosticPortModel extends AdvancedPortModel {
  createLinkModel() {
    return new FinalDiagnosticLinkModel();
  }
}
