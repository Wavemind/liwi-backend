import AdvancedNodeModel from "../../AdvancedDiagram/node/AdvancedNodeModel";

export default class HealthCareNodeModel extends AdvancedNodeModel {
  constructor(options = {}) {
    super({ ...options });
    this.options.type = "healthCare";
  }
}
