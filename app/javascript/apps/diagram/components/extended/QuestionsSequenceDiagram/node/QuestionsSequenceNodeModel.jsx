import AdvancedNodeModel from "../../AdvancedDiagram/node/AdvancedNodeModel";
import AdvancedPortModel from "../../AdvancedDiagram/port/AdvancedPortModel";
import { getLabel } from "../../../../helpers/nodeHelpers";

export default class QuestionsSequenceNodeModel extends AdvancedNodeModel {
  constructor(options = {}) {
    super({ ...options });

    this.options.type = "questionsSequence";
    this.locked = this.options.dbInstance.instanceable_type === "Node" && this.options.dbInstance.instanceable_id === this.options.dbInstance.node_id;

    if (!this.locked) {
      // outPorts
      this.options.dbInstance.node.answers.map(answer => {
        const labelId = this.options.user?.role === "admin" ? `${answer.id} : ` : '';
        this.addPort(new AdvancedPortModel({
          in: false,
          name: `${labelId}${getLabel(answer)}`,
          id: `answer_${answer.id}`
        }));
      });
    }
  }
}
