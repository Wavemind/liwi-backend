import * as React from "react";

class NodeListItem extends React.Component {

  constructor(props) {
    super(props);
  }

  // Get full label of an object
  getFullLabel = (obj) => {
    return obj.reference + " - " + obj.label_translations["en"];
  };

  render = () => {
    const { node } = this.props;

    return (
      <div className="srd-default-node pt-4"
           draggable={true}
           onDragStart={event => {
             event.dataTransfer.setData("node", JSON.stringify(node));
           }}>
        <div className="srd-default-node__title">
          <div className="srd-default-node__name">{this.getFullLabel(node)}</div>
        </div>
          <div className="row srd-default-node">
            <div className="col">
              <div className="name">S2_1 - Yes</div>
            </div>
            <div className="col">
              <div className="name">S2_2 - No</div>
            </div>
          </div>
      </div>
    );
  };
}

export default NodeListItem;
