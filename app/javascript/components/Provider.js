import React from "react"
import DiagramProvider from "../context/Diagram.context";
import Diagram from "../components/Diagram";

class Provider extends React.Component {
  render () {
    const {
      context,
      render,
    } = this.props;

    return (
      <DiagramProvider value={{...context}}>
        <Diagram/>
      </DiagramProvider>
    );
  }
}

export default Provider;
