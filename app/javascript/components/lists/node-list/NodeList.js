import * as React from "react";
import * as _ from "lodash";
import NodeListCategory from "../node-list-category";

export default class NodeList extends React.Component {

  shouldComponentUpdate(nextProps) {
    return !_.isEqual(this.props.orderedNodes, nextProps.orderedNodes);
  }

  render = () => {
    const { orderedNodes } = this.props;
    return (
      <div className="accordion" id="accordionNodes">
        {Object.keys(orderedNodes).map(index => <NodeListCategory nodes={orderedNodes[index]} index={index} key={index} />)}
      </div>
    );
  };
}

