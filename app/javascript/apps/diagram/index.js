import React from "react";
import { Provider } from "react-redux";
import Appsignal from "@appsignal/javascript"
import { ErrorBoundary } from "@appsignal/react";

import store from "./engine/reducers/store";
import DiagramProvider from "./engine/context/Diagram.context";
import Diagram from "./components/Diagram";
import AdvancedModal from "./components/Modal";
import I18n from "i18n-js";

const appsignal = new Appsignal({ key: "8ddb2e41-492d-4edf-9ec1-641ed2f90054" })

const FallbackComponent = () => (
<div className="d-flex flex-row justify-content-center align-items-center">
  <h2 className="mt-5">
    {I18n.t("error")}
  </h2>
</div>
);

export default class Root extends React.Component {

  render() {
    const { context } = this.props;

    return (
      <ErrorBoundary
        instance={appsignal}
        tags={{ tag: "value" }}
        fallback={(error) => <FallbackComponent />}
      >
      <Provider store={store}>
        <DiagramProvider value={{ ...context }}>
          <AdvancedModal />
          <Diagram />
        </DiagramProvider>
      </Provider>
      </ErrorBoundary>
    );
  }
}
