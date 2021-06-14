import AdvancedNodeModel from "../../AdvancedDiagram/node/AdvancedNodeModel";
import FinalDiagnosisPortModel from "../port/FinalDiagnosisPortModel";

export default class FinalDiagnosisModel extends AdvancedNodeModel {
  constructor(options = {}) {
    super({
      ...options,
    });

    this.options.type = "finalDiagnosis";

    // excludedInPort
    this.addPort(
      new FinalDiagnosisPortModel({
        locked: true,
        in: true,
        name: "excludedInPort",
        id: this.options.dbInstance.id,
        nodeId: this.options.dbInstance.node_id
      })
    );

    // excludingOutPort
    this.addPort(new FinalDiagnosisPortModel({
      in: false,
      name: "excludingOutPort",
      id: this.options.dbInstance.id,
      nodeId: this.options.dbInstance.node_id
    }));
  }
}
