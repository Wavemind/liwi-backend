/* eslint-disable react/no-unused-state */
import * as React from "react";
import * as _ from "lodash";

const defaultValue = {};
const DiagramContext = React.createContext(defaultValue);

export default class DiagramProvider extends React.Component {
  constructor(props) {
    super(props);
    this.state = {...this.state, ...props.value }
  }


  async componentWillMount() {
    await this.orderNodes();
  }

  orderNodes = async () => {
    const { availableNodes } = this.state;

    let orderedNodes = {
      exposure: [],
      symptom: [],
      assessmentTest: [],
      physicalExam: [],
      predefinedSyndrome: [],
      comorbidity: [],
      predefinedCondition: [],
      treatment: [],
      management: [],
      finalDiagnostic: []
    };

    // Assign node to correct array
    availableNodes.map((node) => {
      let category = "";

      if (node.type === "Question" || node.type === "PredefinedSyndrome") {
        category = _.camelCase(node.category_name);
      } else {
        category = _.camelCase(node.type);
      }
      orderedNodes[category].push(node);
    });

    this.setState({ orderedNodes });
  };

  setValState = async (prop, value) => {
    await this.setState({ [prop]: value });
  };

  removeNode = async (node) => {
    const { availableNodes } = this.state;
    let index = _.findIndex(availableNodes, {'id': node.id});
    availableNodes.splice(index, 1);
    this.setState({availableNodes}, async () => {
      await this.orderNodes();
    });
  };

  addNode = async (node) => {
    const { availableNodes } = this.state;
    availableNodes.push(node);
    this.setState({availableNodes}, async () => {
      await this.orderNodes();
    });
  };

  state = {
    set: this.setValState,
    removeNode: this.removeNode,
    addNode: this.addNode,
    instanceable: null,
    instanceableType: null,
    questions: null,
    finalDiagnostics: null,
    healthCares: null,
    availableNodes: null,
    orderedNodes: [],
    modalIsOpen: false,
    currentNodeId: null,
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
