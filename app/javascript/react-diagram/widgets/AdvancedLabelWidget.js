import * as React from "react";
import { DefaultLabelWidget } from "storm-react-diagrams";

import { withDiagram } from "../../context/Diagram.context";

/**
 * @author Emmanuel Barchichat
 * Extended in order to listen click on label to edit them
 */
class AdvancedLabelWidget extends DefaultLabelWidget {

  test = () => {
    const { set } = this.props;

    set('modalToOpen', 'UpdateScore')
    set('modalIsOpen', true)
  };

  render() {
    return <div onClick={() => this.test()} {...this.getProps()}>{this.props.model.label}</div>;
  }
}

export default withDiagram(AdvancedLabelWidget);
