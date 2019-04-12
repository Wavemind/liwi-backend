import * as React from "react";

class NodeListItem extends React.Component {

  constructor(props) {
    super(props);
  }

  getFullLabel = (obj) => {
    return obj.reference + " - " + obj.label_translations["en"];
  };

  render = () => {
    const { node } = this.props;

    return (
      <div className="pt-2"
           draggable={true}
           onDragStart={event => {
             event.dataTransfer.setData("node", JSON.stringify(node));
           }}>
        <div className="mx-1 node">
          <div className="py-2 node-category">
            <div className="col  pl-2 pr-0 text-left">
              {node.reference}
            </div>
            <div className="col  pl-0 pr-2 text-right">
              {node.priority}
            </div>
          </div>
          <div className="py-2 node-label">
            <div className="col text-center">
              {node.label_translations["en"]}
            </div>
          </div>
          {node.get_answers !== null ? (
              <div className="py-1 node-answers">
              {node.get_answers.map((answer) => (
                <div className="col text-center answer-split">
                  {this.getFullLabel(answer)}
                </div>
                ))}
              </div>
          ) : ''}
        </div>
      </div>
    );
  };
}

export default NodeListItem;
