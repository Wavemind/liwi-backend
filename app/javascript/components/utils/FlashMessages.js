import React from "react";
import { withDiagram } from "../../context/Diagram.context";

import Alert from "./Alert";

/**
 * @author Quentin Girard
 * Parent component of Alert, display number of alert required by number of error
 */
class FlashMessages extends React.Component {

  constructor(props) {
    super(props);
  }

  render() {
    const { messages } = this.props;

    let alerts = [];

    if (messages.length > 0) {
      alerts = messages.map((message, key) =>
        <Alert key={key} message={message} index={key}/>
      );
    }

    return (alerts);
  }
}

export default withDiagram(FlashMessages);
