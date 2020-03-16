import React from "react"
import { Provider } from 'react-redux'

import store from "./engine/reducers/store";
import DiagramProvider from "./engine/context/Diagram.context";
import Diagram from "./components/Diagram";
import AdvancedModal from "./components/Modal";

export default class Root extends React.Component {
  render () {
    const {
      context,
      render,
    } = this.props;

    return (
      <Provider store={store}>
        <DiagramProvider value={{...context}}>
          <AdvancedModal/>
          <Diagram/>
        </DiagramProvider>
      </Provider>
    );
  }
}

