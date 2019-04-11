import * as React from "react";

class NodeListItem extends React.Component {

  // Get full label of an object
  getFullLabel = (obj) => {
    return obj.reference + " - " + obj.label_translations["en"];
  };

  render = () => {
    const { node } = this.props;

    return (
      <h5>{this.getFullLabel(node)}</h5>
    );
  };
}

export default NodeListItem;
