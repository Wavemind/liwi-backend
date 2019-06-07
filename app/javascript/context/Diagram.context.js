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
      exposure: [],
      symptom: [],
      assessmentTest: [],
      physicalExam: [],
      predefinedSyndrome: [],
      comorbidity: [],
      predefinedCondition: []
    };

    if (type === "Diagnostic") {
      orderedNodes.predefinedSyndromeScored = [];
      orderedNodes.finalDiagnostic = [];
    } else if (type === "FinalDiagnostic") {
      orderedNodes.predefinedSyndromeScored = [];
      orderedNodes.treatment = [];
      orderedNodes.management = [];
    } else if (type === "PredefinedSyndrome") {
      // If different predefined syndromes scored category
      if (instanceable.category.id !== 8) {
        orderedNodes.predefinedSyndromeScored = [];
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

    if (node.type === "Question" || node.type === "PredefinedSyndrome") {
      category = _.camelCase(node.category_name);
    } else {
      category = _.camelCase(node.type);
    }
    return category;
  };


  // @params prop, value
  // Set value in state from children
  setValState = async (prop, value) => {
    await this.setState({ [prop]: value });
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
    const { messages } = this.state;
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
    currentDbNode: null
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
