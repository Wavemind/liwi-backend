import AdvancedNodeModel from "../../AdvancedDiagram/node/AdvancedNodeModel";
import FinalDiagnosticPortModel from "../port/FinalDiagnosticPortModel";

export default class FinalDiagnosticModel extends AdvancedNodeModel {
  constructor(options = {}) {
    super({
      ...options,
      type: "finalDiagnostic"
    });

    // excludedInPort
    this.addPort(
      new FinalDiagnosticPortModel({
        locked: true,
        in: true,
        name: "excludedInPort",
        id: this.dbInstance.id
      })
    );

    // excludingOutPort
    this.addPort(new FinalDiagnosticPortModel({
      in: false,
      name: "excludingOutPort",
      id: this.dbInstance.id
    }));
  }
}
