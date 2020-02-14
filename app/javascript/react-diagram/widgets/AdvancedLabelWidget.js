import * as React from "react";
import { DefaultLabelWidget } from "storm-react-diagrams";

import { withDiagram } from "../../context/Diagram.context";

/**
 * @author Emmanuel Barchichat
 * Extended in order to listen click on label to edit them
 */
class AdvancedLabelWidget extends DefaultLabelWidget {

  // @params [DefaultLabelModel] label
  // Open a modal onClick of label and send to context every info it needs in order to do the http method
  editScore = (labelModel) => {
    const { set } = this.props;

    set(
      ['currentNode', 'currentLinkId', 'currentAnswerId', 'modalToOpen', 'updatingScore', 'modalIsOpen'],
      [labelModel.parent.targetPort.parent.node, labelModel.parent.id, labelModel.parent.sourcePort.dbId, 'UpdateScore',  labelModel.label, true]
    );
  };

  render() {
    const { model } = this.props;

    return <div onClick={() => this.editScore(model)} {...this.getProps()}>{model.label}</div>;
  }
}

export default withDiagram(AdvancedLabelWidget);
