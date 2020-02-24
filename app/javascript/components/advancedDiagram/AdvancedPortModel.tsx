import * as React from "react";
import { DefaultPortModel } from "@projectstorm/react-diagrams";

import AdvancedLinkModel from "./AdvancedLinkModel";

export default class AdvancedPortModel extends DefaultPortModel {
  createLinkModel(): AdvancedLinkModel | null {
    return new AdvancedLinkModel();
  }
}
