/* eslint-disable react/no-unused-state */
import * as React from "react";

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

  state = {
    set: this.setValState,
    instanceable: null,
    instanceableType: null,
    questions: null,
    finalDiagnostics: null,
    healthCares: null,
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
