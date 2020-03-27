import * as React from "react";

import AdvancedLinkModel from "../../AdvancedDiagram/link/AdvancedLinkModel";

export default class QuestionLinkModel extends AdvancedLinkModel {
  constructor(options = {}) {
    super({ ...options });
    this.options.type = "question";
  }
}
