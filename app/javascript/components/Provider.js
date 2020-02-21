import React from "react"
import DiagramContext from "../context/Diagram.context";
import Diagram from "../components/Diagram";

class Provider extends React.Component {
  render () {
    const {
      context,
      render,
    } = this.props;

    return (
      <DiagramContext value={{...context}}>
        <Diagram/>
      </DiagramContext>
    );
  }
}

export default Provider;
