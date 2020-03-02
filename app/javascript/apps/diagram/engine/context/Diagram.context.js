import * as React from "react";

import Http from "../http";
import { getCategoryNode } from "../../helpers/nodeHelpers";
import { defaultOrderedNodes } from "../../engine/constants";

const defaultValue = {};
const DiagramContext = React.createContext(defaultValue);

export default class DiagramProvider extends React.Component {

  constructor(props) {
    super(props);
    const {
      availableNodes,
      instanceable
    } = this.props.value;

    // Init http class
    const http = new Http();

    // Assign node to correct array
    let orderedNodes = defaultOrderedNodes;

    if (instanceable.type === "Diagnostic") {
      orderedNodes.scored = [];
      orderedNodes.finalDiagnostic = [];
    } else if (instanceable.type === "FinalDiagnostic") {
      orderedNodes.treatmentQuestion = [];
      orderedNodes.scored = [];
      orderedNodes.treatment = [];
      orderedNodes.management = [];
    } else if (instanceable.type === "QuestionsSequence") {
      // If different predefined syndromes scored category
      if (instanceable.category_name !== "Scored") {
        orderedNodes.scored = [];
      }
    }

    availableNodes.map((node) => {
      let category = getCategoryNode(node);
      orderedNodes[category].push(node);
    });
    /////////////////////////////////////////////////////////////

    this.state = { ...this.state, ...props.value, http, orderedNodes };
  }

  // @params type, category
  // Retrieve reference prefix for given type and category
  getReferencePrefix = (nodeType, nodeCategory) => {
    let prefix = "";

    switch (nodeType) {
      case "Question":
        const { questionCategories } = this.state;
        questionCategories.map((category) => {
          if (category.name === nodeCategory || category.label === nodeCategory) {
            prefix = category.reference_prefix;
          }
        });
        break;
      case "QuestionsSequence":
        const { questionsSequenceCategories } = this.state;
        questionsSequenceCategories.map((category) => {
          if (category.name === nodeCategory || category.label === nodeCategory) {
            prefix = category.reference_prefix;
          }
        });
        break;
      case "HealthCare":
        prefix = nodeCategory === "HealthCares::Management" ? "M" : "T";
        break;
      case "FinalDiagnostic":
        prefix = "DF";
        break;
    }

    return prefix;
  };

  state = {
    getReferencePrefix: this.getReferencePrefix
  };

  render() {
    const { children } = this.props;
    return (
      <DiagramContext.Provider value={this.state}>
        {children}
      </DiagramContext.Provider>
    );
  }
}

export const withDiagram = (Component) => (props) => (
  <DiagramContext.Consumer>
    {(store) => <Component {...store} {...props} />}
  </DiagramContext.Consumer>
);
