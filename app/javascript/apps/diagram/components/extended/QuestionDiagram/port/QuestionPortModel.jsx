import * as React from "react";

import AdvancedPortModel from "../../AdvancedDiagram/port/AdvancedPortModel";
import QuestionLinkModel from "../link/QuestionLinkModel";

export default class QuestionPortModel extends AdvancedPortModel {
  createLinkModel() {
    return new QuestionLinkModel();
  }
}
