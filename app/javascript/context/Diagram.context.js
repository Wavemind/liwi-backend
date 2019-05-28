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


  orderNodes = async (blackList = []) => {
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
      if (_.find(blackList, i => i.node.id === node.id) === undefined) {
        let category = this.getCategoryNode(node);
        orderedNodes[category].push(node);
      }
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
    let categoryItem = [ ...orderedNodes[category] ];

    _.remove(categoryItem, {'id': node.id});

    const newNodesInstance =  {
      ...orderedNodes,
      [category]: categoryItem
    }
    this.setState({ orderedNodes: newNodesInstance });
  };


  addNode = async (node) => {
    const { orderedNodes } = this.state;
    let category = this.getCategoryNode(node);

    let updatedCategory = [ ...orderedNodes[category], node ]

    const newNodesInstance =  {
      ...orderedNodes,
      [category]: updatedCategory
    }

    this.setState({ orderedNodes: newNodesInstance });
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
    orderNodes: this.orderNodes,
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
