import React from "react";

import { withDiagram } from "../../engine/context/Diagram.context";
import Alert from "./Alert";

class FlashMessages extends React.Component {

  constructor(props) {
    super(props);
  }

  render() {
    const { messages } = this.props;

    let alerts = [];

    if (messages.length > 0) {
      alerts = messages.map((message, key) =>
        <Alert alert={message} key={key}/>
      );
    }

    return (alerts);
  }
}

export default withDiagram(FlashMessages);
