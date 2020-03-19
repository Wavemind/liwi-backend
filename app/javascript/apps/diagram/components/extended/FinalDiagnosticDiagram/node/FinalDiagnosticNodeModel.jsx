import AdvancedNodeModel from "../../AdvancedDiagram/node/AdvancedNodeModel";
import FinalDiagnosticPortModel from "../port/FinalDiagnosticPortModel";

export default class FinalDiagnosticModel extends AdvancedNodeModel {
  constructor(options = {}) {
    super({
      ...options,
    });

    this.options.type = "finalDiagnostic";

    // excludedInPort
    this.addPort(
      new FinalDiagnosticPortModel({
        locked: true,
        in: true,
        name: "excludedInPort",
        id: this.options.dbInstance.id,
        nodeId: this.options.dbInstance.node_id
      })
    );

    // excludingOutPort
    this.addPort(new FinalDiagnosticPortModel({
      in: false,
      name: "excludingOutPort",
      id: this.options.dbInstance.id,
      nodeId: this.options.dbInstance.node_id
    }));
  }
}
