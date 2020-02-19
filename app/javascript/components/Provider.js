import React from "react"
import DiagramContext from "../context/Diagram.context";
import Diagram from "../components/Diagram";
import FinalDiagnosticDiagram from "../components/FinalDiagnosticDiagram";
import CreateHealthCareForm from "../components/modal/contents/health-care/CreateHealthCareForm"

class Provider extends React.Component {
  render () {
    const {
      context,
      render,
    } = this.props;

    return (
      <DiagramContext value={{...context}}>
        {(() => {
          switch(render) {
            case 'Diagram':
              return <Diagram />;
            case 'FinalDiagnosticDiagram':
              return <FinalDiagnosticDiagram />;
            case 'CreateDrug':
              return <CreateHealthCareForm />;
            default:
              return null;
          }
        })()}
      </DiagramContext>
    );
  }
}

export default Provider;
