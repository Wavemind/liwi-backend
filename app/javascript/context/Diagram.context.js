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


  orderNodes = async () => {
    const {
      availableNodes,
      type
    } = this.state;

    let orderedNodes = {
      exposure: [],
      symptom: [],
      assessmentTest: [],
      physicalExam: [],
      predefinedSyndrome: [],
      comorbidity: [],
      predefinedCondition: [],
    };

    if (type === "Diagnostic") {
      orderedNodes.finalDiagnostic = [];
    } else if (type === "FinalDiagnostic") {
      orderedNodes.treatment = [];
      orderedNodes.management = [];
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
    return category
  };


  setValState = async (prop, value) => {
    await this.setState({ [prop]: value });
  };


  removeNode = async (node) => {
    const { orderedNodes } = this.state;
    let category = this.getCategoryNode(node);

    _.remove(orderedNodes[category], {'id': node.id});
    this.setState({ orderedNodes });
  };


  addNode = async (node) => {
    const { orderedNodes } = this.state;
    let category = this.getCategoryNode(node);

    orderedNodes[category].push(node);
    this.setState({orderedNodes});
  };


  addMessage = async (message) => {
    const { messages } = this.state;
    messages.push(message);
    this.setState({messages});
  };


  removeMessage = async (index) => {
    const { messages } = this.state;
    messages.splice(index, 1);
    this.setState({messages});
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
    currentNodeId: null,
    messages: [],
    type: null,
  };

  render() {
    const { children } = this.props;
    console.log(this.state.orderedNodes, this.state.availableNodes )
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
