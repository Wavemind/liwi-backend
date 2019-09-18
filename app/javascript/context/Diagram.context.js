/* eslint-disable react/no-unused-state */

import * as React from "react";
import * as _ from "lodash";
import Http from "../http";

const defaultValue = {};
const DiagramContext = React.createContext(defaultValue);

export default class DiagramProvider extends React.Component {
  constructor(props) {
    super(props);

    // Init http class
    const http = new Http();
    this.state = { ...this.state, ...props.value, http };
  }

  async componentWillMount() {
    await this.orderNodes();
  }


  // Order available nodes list
  orderNodes = async () => {
    const {
      availableNodes,
      type,
      instanceable
    } = this.state;

    let orderedNodes = {
      assessmentTest: [],
      exposure: [],
      demographic: [],
      physicalExam: [],
      symptom: [],
      vaccine: [],
      predefinedSyndrome: [],
      comorbidity: [],
      triage: [],
      firstLookAssessment: [],
    };

    if (type === "Diagnostic") {
      orderedNodes.scored = [];
      orderedNodes.finalDiagnostic = [];
    } else if (type === "FinalDiagnostic") {
      orderedNodes.scored = [];
      orderedNodes.treatment = [];
      orderedNodes.management = [];
    } else if (type === "QuestionsSequence") {
      // If different predefined syndromes scored category
      if (instanceable.category_name !== 'Scored') {
        orderedNodes.scored = [];
      }
    }

    // Assign node to correct array
    availableNodes.map((node) => {
      let category = this.getCategoryNode(node);
      orderedNodes[category].push(node);
    });

    this.setState({ orderedNodes });
  };

  // @params node
  // Find category
  getCategoryNode = (node) => {
    let category = null;
    if (node.node_type === "Question" || node.node_type === "QuestionsSequence" || node.node_type === "HealthCare") {
      category = _.camelCase(node.category_name);
    } else {
      category = _.camelCase(node.node_type);
    }
    return category;
  };


  // @params props, values
  // Set value in state from children
  // Accept arrays of state to change
  setValState = async (props, values) => {
    let stateHash = {};
    if (Array.isArray(props)) {
      for (let i = 0 ; i < props.length ; i++){
        stateHash[props[i]] = values[i];
      }
    } else {
      stateHash = { [props]: values }
    }
    await this.setState(stateHash);
  };


  // @params node
  // Remove node from available node
  removeNode = async (node) => {
    const { availableNodes } = this.state;
    let index = _.findIndex(availableNodes, { "id": node.id });
    availableNodes.splice(index, 1);
    this.setState({ availableNodes }, async () => {
      await this.orderNodes();
    });
  };

  // @params node
  // Add node from available node
  addNode = async (node) => {
    const { availableNodes } = this.state;
    availableNodes.push(node);
    this.setState({ availableNodes }, async () => {
      await this.orderNodes();
    });
  };


  // @params message
  // Add message to flash message methods
  addMessage = async (message) => {
    let messages = [];
    messages.push(message);
    this.setState({ messages });
  };


  // @params message
  // Remove message to flash message methods
  removeMessage = async (index) => {
    const { messages } = this.state;
    messages.splice(index, 1);
    this.setState({ messages });
  };


  state = {
    set: this.setValState,
    removeNode: this.removeNode,
    addNode: this.addNode,
    addMessage: this.addMessage,
    removeMessage: this.removeMessage,
    instanceable: null,
    instanceableType: null,
    questions: null,
    finalDiagnostics: null,
    healthCares: null,
    availableNodes: null,
    orderedNodes: [],
    modalIsOpen: false,
    modalToOpen: null,
    currentNode: null,
    messages: [],
    type: null,
    readOnly: false,
    currentScore: 0,
    currentLinkId: null,
    currentAnswerId: null,
    updatingScore: 0,
    currentDbNode: null,
    currentDiagramNode: null,
    currentHealthCareType: null,
    questionAnswerTypes: null,
    questionStages: null,
    questionPriorities: null,
    questionCategories: null,
    questionsSequenceCategories: null,
    answersOperators: null,
    currentQuestion: null,
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
