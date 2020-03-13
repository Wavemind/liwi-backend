import AdvancedNodeModel from "../../AdvancedDiagram/node/AdvancedNodeModel";
import AdvancedPortModel from "../../AdvancedDiagram/port/AdvancedPortModel";
import { getLabel } from "../../../../helpers/nodeHelpers";

export default class QuestionsSequenceNodeModel extends AdvancedNodeModel {
  constructor(options = {}) {
    super({ ...options });

    this.options.type = "questionsSequence";
    this.locked = this.dbInstance.instanceable_type === "Node" && this.dbInstance.instanceable_id === this.dbInstance.node_id;

    if (!this.locked) {
      // outPorts
      this.dbInstance.node.answers.map(answer => {
        this.addPort(new AdvancedPortModel({
          in: false,
          name: getLabel(answer),
          id: answer.id
        }));
      });
    }
  }
}
