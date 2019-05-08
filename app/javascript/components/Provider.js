import React from "react"
import DiagramContext from '../context/Diagram.context';
import Diagram from '../components/Diagram';
import FinalDiagnosticDiagram from '../components/FinalDiagnosticDiagram';

class Provider extends React.Component {
  render () {
    const {
      context,
      render,
    } = this.props;

    return (
      <DiagramContext value={{...context}}>
        {render === 'Diagram' ? <Diagram/> : <FinalDiagnosticDiagram/>}
      </DiagramContext>
    );
  }
}

export default Provider
