/* eslint-disable react/no-unused-state */
import * as React from "react";
import * as _ from "lodash";
import Http from "../http";

const defaultValue = {};
const DiagramContext = React.createContext(defaultValue);

export default class DiagramProvider extends React.Component {
  constructor(props) {
    super(props);
  }

  componentWillMount() {
    const { value } = this.props;
    Object.keys(value).map(index => {
      this.setValState(index, value[index]);
    });
  }

  setValState = async (prop, value) => {
    await this.setState({ [prop]: value });
  };

  removeNode = async (node) => {
    const { availableNodes } = this.state;
    let index = _.findIndex(availableNodes, {'id': node.id});
    availableNodes.splice(index, 1);
    this.setState(availableNodes);
  };

  state = {
    set: this.setValState,
    removeNode: this.removeNode,
    instanceable: null,
    instanceableType: null,
    questions: null,
    finalDiagnostics: null,
    healthCares: null,
    availableNodes: null,
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
