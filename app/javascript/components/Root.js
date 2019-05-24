import React from "react";
import { Provider } from 'react-redux';
import DiagramContext from "../context/Diagram.context";
import DefaultDiagram from "../components/diagrams/default/";
import FinalDiagnosticDiagram from "../components/diagrams/final-diagnostic/";
import store from '../state-manager/';

class Root extends React.Component {
  render () {
    const {
      context,
      render,
    } = this.props;

    return (
      <Provider store={store}>
        <DiagramContext value={{...context}}>
          {render === "Diagram" ? <DefaultDiagram/> : <FinalDiagnosticDiagram/>}
        </DiagramContext>
      </Provider>
    );
  }
}

export default Root;
