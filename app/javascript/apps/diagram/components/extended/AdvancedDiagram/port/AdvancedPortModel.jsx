import * as React from "react";
import { DefaultPortModel } from "@projectstorm/react-diagrams";

import AdvancedLinkModel from "../link/AdvancedLinkModel";

export default class AdvancedPortModel extends DefaultPortModel {
  createLinkModel() {
    return new AdvancedLinkModel();
  }
}
