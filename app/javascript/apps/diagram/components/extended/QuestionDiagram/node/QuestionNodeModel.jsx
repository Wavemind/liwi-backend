import AdvancedNodeModel from "../../AdvancedDiagram/node/AdvancedNodeModel";
import AdvancedPortModel from "../../AdvancedDiagram/port/AdvancedPortModel";
import { getLabel } from "../../../../helpers/nodeHelpers";

export default class QuestionNodeModel extends AdvancedNodeModel {
  constructor(options = {}) {
    super({
      ...options,
      type: "question"
    });

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
