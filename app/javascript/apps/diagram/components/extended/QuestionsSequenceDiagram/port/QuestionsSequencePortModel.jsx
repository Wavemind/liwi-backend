import * as React from "react";

import AdvancedPortModel from "../../AdvancedDiagram/port/AdvancedPortModel";
import QuestionsSequenceLinkModel from "../link/QuestionsSequenceLinkModel";

export default class QuestionsSequencePortModel extends AdvancedPortModel {
  createLinkModel() {
    return new QuestionsSequenceLinkModel();
  }
}
