import React from "react"
import DiagramProvider from "./engine/context/Diagram.context";
import Diagram from "./components/Diagram";

export default class Provider extends React.Component {
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

