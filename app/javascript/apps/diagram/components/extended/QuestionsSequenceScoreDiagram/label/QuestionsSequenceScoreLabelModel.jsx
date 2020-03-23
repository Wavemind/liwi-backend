import { DefaultLabelModel } from "@projectstorm/react-diagrams-defaults";

export default class QuestionsSequenceScoreLabelModel extends DefaultLabelModel {
  constructor(options = {}) {
    super({ ...options });

    this.options.type = "questionsSequenceScore";
  }
}
