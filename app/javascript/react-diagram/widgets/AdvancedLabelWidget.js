import * as React from "react";
import { DefaultLabelWidget } from "storm-react-diagrams";

import { withDiagram } from "../../context/Diagram.context";

/**
 * @author Emmanuel Barchichatte <3
 * Extended in order to listen click on label to edit them
 */
class AdvancedLabelWidget extends DefaultLabelWidget {

  editScore = (labelModel) => {
    const { set } = this.props;

    set('currentNodeId', labelModel.parent.targetPort.parent.node.id)
    set('currentLinkId', labelModel.parent.id)
    set('currentAnswerId', labelModel.parent.sourcePort.dbId)
    set('modalToOpen', 'UpdateScore');
    set('updatingScore', labelModel.label);
    set('modalIsOpen', true);
  };

  render() {
    const { model } = this.props

    return <div onClick={() => this.editScore(model)} {...this.getProps()}>{model.label}</div>;
  }
}

export default withDiagram(AdvancedLabelWidget);
